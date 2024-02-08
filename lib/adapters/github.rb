require "octokit"

module Adapters
  module Github
    extend self

    delegate :pull_requests, :pull_request_reviews, to: :client

    def client
      @client ||= Octokit::Client.new(access_token: ENV["ACCESS_TOKEN"])
    end
  end
end
