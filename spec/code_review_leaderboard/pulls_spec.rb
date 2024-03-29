require "code_review_leaderboard/pulls"

require "code_review_leaderboard/repository"

RSpec.describe CodeReviewLeaderboard::Pulls, :github_mock do
  let(:repository) { CodeReviewLeaderboard::Repository.new(name: "rails/rails") }

  describe ".for" do
    it "returns the pulls of a repository" do
      expect(described_class.for(repository:).map(&:number))
        .to contain_exactly(208, 206, 112, 110)
    end

    it "considers timeframe" do
      expect(described_class.for(repository:, since: 1.week.ago).map { _1[:number] })
        .to contain_exactly(208, 206)
    end
  end
end
