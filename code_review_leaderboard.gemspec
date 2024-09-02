require_relative "lib/code_review_leaderboard/version"

Gem::Specification.new do |spec|
  spec.name = "code_review_leaderboard"
  spec.version = CodeReviewLeaderboard::VERSION
  spec.authors = ["markokajzer"]
  spec.email = ["markokajzer91@gmail.com"]

  spec.summary = "Create a leaderboard for code review in your repository or organization"
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/markokajzer/code-review-leaderboard"
  spec.required_ruby_version = ">= 3.3.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github .rspec .rubocop .standard.yml .tool-versions appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "octokit", ">= 8.1", "< 10.0"
  spec.add_dependency "faraday-retry", "~> 2.2"
  spec.add_dependency "activesupport", "~> 7.1"
  spec.add_dependency "async", "~> 2.8"

  # Progress
  spec.add_dependency "whirly", "~> 0.3"
  spec.add_dependency "paint", "~> 2.3"

  # Output
  spec.add_dependency "terminal-table", "~> 3.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
