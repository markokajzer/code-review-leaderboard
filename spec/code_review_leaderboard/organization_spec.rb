require "code_review_leaderboard/organization"

RSpec.describe CodeReviewLeaderboard::Organization, :github_mock do
  subject(:organization) { described_class.new(name: "rails") }

  describe "#repos" do
    it "returns a list of repositories" do
      expect(organization.repos).to eq([
        CodeReviewLeaderboard::Repository.new(name: "rails/rails"),
        CodeReviewLeaderboard::Repository.new(name: "rails/thor"),
        CodeReviewLeaderboard::Repository.new(name: "rails/jbuilder")
      ])
    end

    it "considers timeframe" do
      expect(organization.repos(since: 1.week.ago))
        .not_to include(CodeReviewLeaderboard::Repository.new(name: "rails/jbuilder"))
    end
  end
end
