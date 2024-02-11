ENV["RUBY_ENV"] = "test"

require "simplecov"
SimpleCov.start do
  add_filter "spec/"
end

require "bundler"
Bundler.require(:default, :test)

require "webmock/rspec"

Dir[File.expand_path("support/**/*.rb", __dir__)].sort.each { |f| require f }
