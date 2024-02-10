require_relative "lib/code_review_leaderboard/version"

Gem::Specification.new do |spec|
  spec.name = "code_review_leaderboard"
  spec.version = CodeReviewLeaderboard::VERSION
  spec.authors = ["markokajzer"]
  spec.email = ["markokajzer91@gmail.com"]

  spec.summary = "Code Review Leaderboard"
  # spec.description = "TODO: Write a longer description or delete this line."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "octokit"
  spec.add_dependency "faraday-retry"
  spec.add_dependency "activesupport"
  spec.add_dependency "async"

  # Progress
  spec.add_dependency "whirly"
  spec.add_dependency "paint"

  # Output
  spec.add_dependency "terminal-table"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
