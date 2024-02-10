require_relative "code_review_leaderboard/version"

require_relative "async/wait_all_throttled"

require "code_review_leaderboard/config"
require "code_review_leaderboard/formatter"
require "code_review_leaderboard/organization"
require "code_review_leaderboard/pulls"
require "code_review_leaderboard/repository"
require "code_review_leaderboard/reviews"
require "code_review_leaderboard/spinner"

module CodeReviewLeaderboard
  extend self

  def initialize!
    Config.initialize!

    raise ConfigurationError, "Access token is required" if Config.access_token.nil?
    raise ConfigurationError, "Repository or owner is required" if Config.repositories.empty? && Config.organization.blank?
  end

  def start
    puts "Found #{repositories.size} repositories" if Config.organization.present? && Config.log_level == :debug
    puts "Found #{pulls.size} pull requests."
    puts "Found #{reviews.size} reviews."
    puts

    puts Formatter.new(reviews).to_table
  end

  private

  def repositories
    @@repositories ||= if Config.repositories.present?
      Config.repositories.map { Repository.new(name: _1) }
    else
      Spinner.start do
        Spinner.status = "Fetching repos for #{Config.organization}..."
        Organization.new(name: Config.organization).repos
      end
    end
  end
  alias_method :load_repositories, :repositories

  def pulls
    # Load before we enter the next spinner so we do not end up nesting them
    load_repositories

    @@pulls ||= Spinner.start do
      Spinner.status = "Fetching pull requests..."

      WaitAllThrottled(repositories) { _1.pulls }
    end
  end

  def reviews
    @@reviews ||= Spinner.start do
      Spinner.status = "Fetching reviews..."

      WaitAllThrottled(pulls) { Reviews.for(pull: _1) }
    end
  end
end
