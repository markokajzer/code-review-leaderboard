require "active_support/configurable"
require "active_support/core_ext/module/delegation"

require_relative "argument_parser"

module Config
  extend self

  include ActiveSupport::Configurable

  ConfigurationError = Class.new(StandardError)

  config_accessor :access_token
  config_accessor :repositories, default: []
  config_accessor :log_level, default: :info

  def initialize!
    initialize_from_args!
    initialize_from_env!
  end

  def initialize_from_args!
    options = ArgumentParser.parse!

    self.access_token = options[:access_token]
    self.repositories = options[:repositories] if options[:repositories].present?
    self.log_level = options[:log_level]
  end

  def initialize_from_env!
    self.access_token ||= ENV["ACCESS_TOKEN"]
    self.repositories = repositories.presence || ENV["REPOSITORY"].split(",")
    self.log_level ||= ENV["LOG_LEVEL"]
  end
end
