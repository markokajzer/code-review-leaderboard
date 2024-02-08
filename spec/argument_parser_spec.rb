require "argument_parser"

RSpec.describe ArgumentParser do
  subject(:options) { ArgumentParser.parse!(args: argv) }

  let(:argv) { ["--access-token", "abcd", "--repo", "rails/rails", "--verbose"] }

  it "sets the access token" do
    expect(options[:access_token]).to eq("abcd")
  end

  it "sets the repository" do
    expect(options[:repository]).to eq("rails/rails")
  end

  it "sets the log level" do
    expect(options[:log_level]).to eq("debug")
  end

  # When this test is enabled, rspec randomly skips other specs...
  xit "shows the help message" do
    expect { ArgumentParser.parse!(args: ["--help"]) }
      .to output("Show this message").to_stdout
  end
end
