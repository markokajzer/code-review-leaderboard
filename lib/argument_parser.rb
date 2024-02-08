require "optparse"

require_relative "config"

module ArgumentParser
  extend self

  def parse!
    {}.tap do |options|
      OptionParser.new do |opts|
        opts.banner = "Usage: leaderboard [options]"

        opts.on("-t", "--access-token ACCESS_TOKEN", "Specify the access token") { |token| Config.access_token = token }
        opts.on("-r", "--repo REPOSITORY", "--repository REPOSITORY", "Specify the repository") { |repository| Config.repository = repository }
        opts.on("-v", "--verbose", "Run verbosely") { Config.log_level = "debug" }

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!
    end
  end
end
