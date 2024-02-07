require "octokit"

module Adapters
  module Github
    extend self

    def client
      @client ||= Octokit::Client.new(access_token: ENV["ACCESS_TOKEN"])
    end
  end
end
