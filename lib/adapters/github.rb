require "octokit"

module Adapters
  module Github
    extend self

    delegate :pull_requests, :pull_request_reviews, to: :client

    def client
      @client ||= Octokit::Client.new(access_token: Config.access_token)
    end
  end
end
