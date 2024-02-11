require "code_review_leaderboard/reviews"

require "code_review_leaderboard/repository"

RSpec.describe CodeReviewLeaderboard::Reviews, :github_mock do
  let(:repository) { CodeReviewLeaderboard::Repository.new(name: "rails/rails") }
  let(:pull) { object_fixture("spec/fixtures/pull-208.json") }

  describe ".for" do
    it "aggregates the reviews of a pull request" do
      expect(described_class.for(pull:))
        .to eq([
          {user: "octocat", state: :approved},
          {user: "defunkt", state: :commented}
        ])
    end

    it "does not count comments if already reviewed" do
      expect(described_class.for(pull:))
        .not_to include({user: "octocat", state: :commented})
    end

    it "counts approvals and rejections of the same user" do
      pull = object_fixture("spec/fixtures/pull-206.json")

      expect(described_class.for(pull:))
        .to eq([
          {user: "octocat", state: :approved},
          {user: "octocat", state: :changes_requested}
        ])
    end
  end
end
