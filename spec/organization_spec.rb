require "organization"

RSpec.describe Organization, :github_mock do
  subject(:organization) { described_class.new(name: "rails") }

  describe "#repos" do
    it "returns a list of repositories" do
      expect(organization.repos).to eq([
        Repository.new(name: "rails/rails"),
        Repository.new(name: "rails/thor"),
        Repository.new(name: "rails/jbuilder")
      ])
    end

    it "considers timeframe" do
      expect(organization.repos(since: 1.week.ago))
        .not_to include(Repository.new(name: "rails/jbuilder"))
    end
  end
end
