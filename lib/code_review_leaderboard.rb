require_relative "code_review_leaderboard/version"

require_relative "code_review_leaderboard/runner"

module CodeReviewLeaderboard
  extend self

  def initialize!
    Config.initialize!

    raise ConfigurationError, "Access token is required" if Config.access_token.blank?
    raise ConfigurationError, "Repository or owner is required" if Config.repositories.empty? && Config.organization.blank?
  end

  delegate :start, to: Runner
end
