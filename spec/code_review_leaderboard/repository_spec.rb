require "code_review_leaderboard/repository"

RSpec.describe CodeReviewLeaderboard::Repository, :github_mock do
  describe "#pulls" do
    subject(:repository) { described_class.new(name: "rails/rails") }

    it "returns the pulls of a repository" do
      expect(repository.pulls.map { _1[:number] })
        .to contain_exactly(208, 206, 112, 110)
    end
  end
end
