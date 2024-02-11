require "whirly"

module CodeReviewLeaderboard
  module Spinner
    extend self

    delegate :status=, to: Whirly

    def start
      result = nil

      Whirly.start(spinner: "dots", stop: "✔", **options) do
        result = yield
      end

      result
    end

    private

    # NOTE: For testing only
    # Even when using rspec `expect {...}.to output`, output is not suppressed
    def options
      {
        stream:,
        non_tty: (ENV["RUBY_ENV"] == "test")
      }
    end

    def stream
      if ENV["RUBY_ENV"] == "test"
        require "stringio"
        StringIO.new
      else
        $stdout
      end
    end
  end
end
