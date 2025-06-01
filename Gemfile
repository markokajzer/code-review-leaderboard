# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.6"

# Specify your gem's dependencies in code_review_leaderboard.gemspec
gemspec

group :development do
  gem "rake", "~> 13.3"

  gem "awesome_print"
  gem "standard", require: false
  gem "rubocop-rspec", require: false
end

group :test do
  gem "rspec"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :development, :test do
  gem "debug"
end
