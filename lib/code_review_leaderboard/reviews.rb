require_relative "config"

module CodeReviewLeaderboard
  class Reviews
    class << self
      def for(pull:, since: 30.days.ago)
        new(pull:, since:).reviews
      end
    end

    def initialize(pull:, since: 30.days.ago)
      @pull = pull
      @since = since
    end

    def reviews
      puts "Fetching reviews for #{repository}##{pull.number}..." if Config.log_level == :debug

      comments, reviews =
        fetch_reviews
          .map { {user: _1.user.login, state: _1.state.downcase.to_sym} }
          .uniq
          .partition { _1[:state] == :commented }

      # Do not count comments if already otherwise reviewed
      comments.filter! do |commenter|
        reviews.none? { |reviewer| reviewer[:user] == commenter[:user] }
      end

      reviews + comments
    end

    private

    attr_reader :pull, :since

    def fetch_reviews
      Adapters::Github.pull_request_reviews(repository, pull.number)
        .reject { _1.state == "PENDING" }
        .filter { _1.submitted_at > since }
    end

    def repository
      pull.base.repo.full_name
    end
  end
end
