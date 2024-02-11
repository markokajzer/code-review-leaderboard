# frozen_string_literal: true

RSpec.describe CodeReviewLeaderboard do
  it "has a version number" do
    expect(CodeReviewLeaderboard::VERSION).to be_present
  end

  describe "#initialize!" do
    before do
      # Putting this in `after` sometimes does not seem to actually clear it
      CodeReviewLeaderboard::Config.config.clear
    end

    it "initializes the configuration" do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("ACCESS_TOKEN").and_return("token")
      allow(ENV).to receive(:[]).with("REPOSITORY").and_return("rails/rails")

      described_class.initialize!

      expect(CodeReviewLeaderboard::Config.access_token).to eq("token")
    end

    it "throws an error if the access token is missing" do
      expect { described_class.initialize! }
        .to raise_error(CodeReviewLeaderboard::ConfigurationError)
    end

    it "throws an error if the repository and owner is missing" do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("ACCESS_TOKEN").and_return("token")

      expect { described_class.initialize! }
        .to raise_error(CodeReviewLeaderboard::ConfigurationError)
    end
  end

  describe "#start" do
    before do
      CodeReviewLeaderboard::Config.config.clear
      CodeReviewLeaderboard::Config.access_token = "token"
    end

    context "with repository" do
      let(:repository) { CodeReviewLeaderboard::Repository.new(name: "rails/rails") }

      before do
        CodeReviewLeaderboard::Config.repositories = [repository.name]

        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls")
          .with(query: hash_including({}))
          .to_return_json(
            {body: json_fixture("spec/fixtures/pulls.json")},
            {body: []}
          )

        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls/208/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: json_fixture("spec/fixtures/reviews-208.json"))

        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls/206/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: json_fixture("spec/fixtures/reviews-206.json"))
      end

      it "prints the leaderboard" do
        expect { described_class.start }
          .to output(
            <<~OUTPUT
              +---------+-------+----------+-------------------+-----------+
              | Login   | Total | Approved | Changes Requested | Commented |
              +---------+-------+----------+-------------------+-----------+
              | octocat | 3     | 2        | 1                 | 0         |
              | defunkt | 1     | 0        | 0                 | 1         |
              +---------+-------+----------+-------------------+-----------+
            OUTPUT
          ).to_stdout
      end
    end

    context "with organization", :github_mock do
      let(:organization) { CodeReviewLeaderboard::Organization.new(name: "rails") }

      before do
        CodeReviewLeaderboard::Config.organization = organization.name

        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls")
          .with(query: hash_including({}))
          .to_return_json(
            {body: json_fixture("spec/fixtures/pulls.json")},
            {body: []}
          )

        stub_request(:get, "https://api.github.com/repos/rails/thor/pulls")
          .with(query: hash_including({}))
          .to_return_json(
            {body: json_fixture("spec/fixtures/pulls-2.json")},
            {body: []}
          )

        stub_request(:get, "https://api.github.com/repos/rails/jbuilder/pulls")
          .with(query: hash_including({}))
          .to_return_json(body: [])

        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls/208/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: json_fixture("spec/fixtures/reviews-208.json"))

        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls/206/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: json_fixture("spec/fixtures/reviews-206.json"))

        stub_request(:get, "https://api.github.com/repos/rails/thor/pulls/112/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: json_fixture("spec/fixtures/reviews-112.json"))

        stub_request(:get, "https://api.github.com/repos/rails/thor/pulls/110/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: json_fixture("spec/fixtures/reviews-110.json"))
      end

      it "prints the leaderboard" do
        expect { described_class.start }
          .to output(
            <<~OUTPUT
              +-------------+-------+----------+-------------------+-----------+
              | Login       | Total | Approved | Changes Requested | Commented |
              +-------------+-------+----------+-------------------+-----------+
              | octocat     | 4     | 2        | 1                 | 1         |
              | markokajzer | 2     | 2        | 0                 | 0         |
              | defunkt     | 2     | 0        | 0                 | 2         |
              +-------------+-------+----------+-------------------+-----------+
            OUTPUT
          ).to_stdout
      end
    end
  end
end
