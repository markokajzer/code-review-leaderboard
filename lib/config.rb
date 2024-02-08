require "active_support/configurable"

module Config
  include ActiveSupport::Configurable

  ConfigurationError = Class.new(StandardError)

  config_accessor :access_token, :repository
  config_accessor :log_level, default: "info"

  class << self
    def initialize!
      self.access_token = ENV["ACCESS_TOKEN"]
      self.repository = ENV["REPOSITORY"]
      self.log_level = ENV["LOG_LEVEL"]
    end
  end
end
