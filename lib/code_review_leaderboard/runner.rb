require "async/wait_all_throttled"

require_relative "config"
require_relative "formatter"
require_relative "organization"
require_relative "pulls"
require_relative "repository"
require_relative "reviews"
require_relative "spinner"

module CodeReviewLeaderboard
  class Runner
    class << self
      def start
        new.start
      end
    end

    def start
      puts Formatter.new(reviews).to_table
    end

    private

    def repositories
      @repositories ||= if Config.repositories.present?
        Config.repositories.map { Repository.new(name: _1) }
      else
        Spinner.start do
          Spinner.status = "Fetching repos for #{Config.organization}..."
          Organization.new(name: Config.organization).repos
            .tap { Spinner.status = "Found #{_1.size} repositories." }
        end
      end
    end
    alias_method :load_repositories, :repositories

    def pulls
      # Load before we enter the next spinner so we do not end up nesting them
      load_repositories

      @pulls ||= Spinner.start do
        Spinner.status = "Fetching pull requests..."

        WaitAllThrottled(repositories) { _1.pulls }
          .tap { Spinner.status = "Found #{_1.size} pull requests." }
      end
    end
    alias_method :load_pulls, :pulls

    def reviews
      load_pulls

      @reviews ||= Spinner.start do
        Spinner.status = "Fetching reviews..."

        WaitAllThrottled(pulls) { Reviews.for(pull: _1) }
          .tap { Spinner.status = "Found #{_1.size} reviews.\n" }
      end
    end
  end
end
