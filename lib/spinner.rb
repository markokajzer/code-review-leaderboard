require "whirly"

module Spinner
  extend self

  def start
    result = nil

    Whirly.start(spinner: "dots", stop: "✔") do
      result = yield
    end

    result
  end
end
