require "active_support/core_ext/module/delegation"
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
    puts "Fetching pulls for #{repository.name}..." if Config.log_level == "debug"

    fetch_pulls.filter { _1.updated_at > since }
  end

  private

  attr_reader :repository, :since

  delegate :client, :page_size, to: Adapters::Github

  def fetch_pulls
    (1..).each_with_object([]) do |page, pulls|
      puts "Page #{page}..." if Config.log_level == "debug"

      pulls_chunk = client.pull_requests(repository.name, state: "all", sort: "updated", direction: "desc", per_page: PAGE_SIZE, page:)
      pulls.concat(pulls_chunk)

      return pulls if pulls_chunk.size < PAGE_SIZE
      return pulls if pulls_chunk.last.updated_at < since
    end
  end
end
