require "active_support"
require "active_support/core_ext/numeric/time"

require "adapters/github"
require_relative "config"

module CodeReviewLeaderboard
  class Pulls
    PER_PAGE = 100

    class << self
      def for(repository:, since: 30.days.ago)
        new(repository:, since:).pulls
      end
    end

    def initialize(repository:, since:)
      @repository = repository
      @since = since
    end

    def pulls
      fetch_pulls
    end

    private

    attr_reader :repository, :since

    def fetch_pulls
      (1..).each_with_object([]) do |page, pulls|
        pulls_chunk =
          Adapters::Github
            .pull_requests(repository.name, state: "all", per_page: PER_PAGE, page:)
            .filter { _1.created_at > since }
        pulls.concat(pulls_chunk)

        return pulls if pulls_chunk.size < PER_PAGE
      end
    end
  end
end
