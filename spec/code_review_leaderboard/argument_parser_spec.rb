require "code_review_leaderboard/argument_parser"

RSpec.describe CodeReviewLeaderboard::ArgumentParser do
  subject(:options) { described_class.parse!(args: argv) }

  let(:argv) { ["--access-token", "abcd", "--repo", "rails/rails", "--verbose"] }

  it "sets the access token" do
    expect(options[:access_token]).to eq("abcd")
  end

  it "sets the repository" do
    expect(options[:repositories]).to contain_exactly("rails/rails")
  end

  it "sets the log level" do
    expect(options[:log_level]).to eq(:debug)
  end

  it "shows version information" do
    stub_const("CodeReviewLeaderboard::VERSION", "0.1.1")

    expect { described_class.parse!(args: ["--version"]) }
      .to output(/0.1.1/).to_stdout
      .and raise_error(SystemExit)
  end

  it "shows the help message" do
    expect { described_class.parse!(args: ["--help"]) }
      .to output(/Show this message/).to_stdout
      .and raise_error(SystemExit)
  end
end
