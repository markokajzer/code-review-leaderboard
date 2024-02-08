require "optparse"

require_relative "config"

module ArgumentParser
  extend self

  def parse!
    {}.tap do |options|
      OptionParser.new do |opts|
        opts.banner = "Usage: leaderboard [options]"

        opts.on("-t", "--access-token ACCESS_TOKEN", "Specify the access token") do |access_token|
          Config.access_token = access_token
        end

        opts.on("-r", "--repo REPOSITORY", "--repository REPOSITORY", "Specify the repository") do |repository|
          Config.repository = repository
        end

        opts.on("-v", "--verbose", "Run verbosely") do
          Config.log_level = "debug"
        end

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!
    end
  end
end
