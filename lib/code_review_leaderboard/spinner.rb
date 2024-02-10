require "whirly"

module CodeReviewLeaderboard
  module Spinner
    extend self

    delegate :status=, to: Whirly

    def start
      result = nil

      Whirly.start(spinner: "dots", stop: "✔") do
        result = yield
      end

      result
    end
  end
end
