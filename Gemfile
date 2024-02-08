source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "octokit"
gem "activesupport"
gem "terminal-table"

group :development do
  gem "awesome_print"
  gem "standard"
end

group :test do
  gem "rspec"
  gem "timecop"
  gem "webmock"
end

group :development, :test do
  gem "debug"
end
