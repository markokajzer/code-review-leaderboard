require "optparse"

module ArgumentParser
  extend self

  def parse!(args: ARGV)
    {}.tap do |options|
      OptionParser.new do |opts|
        opts.banner = "Usage: leaderboard [options]"

        opts.on("-t", "--access-token ACCESS_TOKEN", "Specify the access token") { |token| options[:access_token] = token }
        opts.on("-r", "--repo REPOSITORY", "--repository REPOSITORY", "Specify the repository") { |repository| options[:repository] = repository }
        opts.on("-v", "--verbose", "Run verbosely") { options[:log_level] = "debug" }

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!(args)
    end
  end
end
