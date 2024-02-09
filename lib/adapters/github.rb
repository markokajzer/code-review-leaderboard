require "active_support/core_ext/module/delegation"

module Adapters
  module Github
    extend self

    delegate :organization_repositories,
      :pull_requests,
      :pull_request_reviews,
      to: :client

    def client
      @client ||= Octokit::Client.new(access_token: Config.access_token)
    end

    def per_page
      client.per_page || 30
    end
  end
end
