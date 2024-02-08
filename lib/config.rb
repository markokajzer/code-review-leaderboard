require "active_support/configurable"

require_relative "argument_parser"

class Config
  include ActiveSupport::Configurable

  ConfigurationError = Class.new(StandardError)

  config_accessor :access_token, :repository
  config_accessor :log_level, default: "info"

  class << self
    delegate :initialize!, to: :instance

    def instance
      @instance ||= new
    end
  end

  def initialize!
    initialize_from_env!
    initialize_from_args!
  end

  def initialize_from_env!
    self.access_token = ENV["ACCESS_TOKEN"]
    self.repository = ENV["REPOSITORY"]
    self.log_level = ENV["LOG_LEVEL"]
  end

  def initialize_from_args!
    ArgumentParser.parse!
  end
end
