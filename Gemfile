source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "octokit"
gem "activesupport", require: "active_support"

# Progress
gem "whirly"
gem "paint"

# Output
gem "terminal-table"

group :development do
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
