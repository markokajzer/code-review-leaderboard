require "active_support"
require "active_support/core_ext/numeric/time"

require_relative "adapters/github"
require_relative "config"

class Pulls
  PAGE_SIZE = 100

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
      puts "Page #{page}..." if Config.log_level == "debug"

      pulls_chunk =
        Adapters::Github
          .pull_requests(repository.name, state: "all", per_page: PAGE_SIZE, page:)
          .filter { _1.created_at > since }
      pulls.concat(pulls_chunk)

      return pulls if pulls_chunk.size < PAGE_SIZE
    end
  end
end
