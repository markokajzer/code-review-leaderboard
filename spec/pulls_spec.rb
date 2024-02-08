require "pulls"

require "repository"

RSpec.describe Pulls, :github_mock do
  let(:repository) { Repository.new(name: "rails/rails") }

  describe ".for" do
    it "returns the pulls of a repository" do
      expect(Pulls.for(repository:).map { _1[:number] })
        .to contain_exactly(208, 206, 112, 110)
    end

    it "considers timeframe" do
      expect(Pulls.for(repository:, since: 1.week.ago).map { _1[:number] })
        .to contain_exactly(208, 206)
    end
  end
end
