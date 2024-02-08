require_relative "config"

class Reviews
  class << self
    def for(repository:, pull:, since: 30.days.ago)
      new(repository:, pull:, since:).reviews
    end
  end

  def initialize(repository:, pull:, since: 30.days.ago)
    @repository = repository
    @pull = pull
    @since = since
  end

  # Do not count comments if already otherwise reviewed
  def reviews
    puts "Fetching reviews for #{repository.name}##{pull.number}..." if Config.log_level == "debug"

    comments, reviews =
      fetch_reviews
        .map { {user: _1.user.login, state: _1.state.downcase.to_sym} }
        .uniq
        .partition { _1[:state] == :commented }

    comments.filter! do |commenter|
      reviews.none? { |reviewer| reviewer[:user] == commenter[:user] }
    end

    reviews + comments
  end

  private

  attr_reader :repository, :pull, :since

  def fetch_reviews
    Adapters::Github.pull_request_reviews(repository.name, pull.number)
      .filter { _1.submitted_at > since }
  end
end
