require "active_support/core_ext/numeric/time"

require_relative "adapters/github"
require_relative "config"

require_relative "repository"

class Organization
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def repos(since: 30.days.ago)
    fetch_repos(since:).map { Repository.new(name: _1.full_name) }
  end

  private

  def fetch_repos(since:)
    (1..).each_with_object([]) do |page, repos|
      repo_chunk =
        Adapters::Github
          .organization_repositories(name, type: "sources", sort: "pushed", page:)
          .filter { _1.pushed_at > since }
      repos.concat(repo_chunk)

      return repos if repo_chunk.size < Adapters::Github.per_page
    end
  end
end
