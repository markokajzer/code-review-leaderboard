require "pulls"

require "repository"

RSpec.describe Pulls do
  let(:repository) { Repository.new(name: "rails/rails") }

  before do
    stub_const("Pulls::PAGE_SIZE", 2)

    stub_request(:get, "https://api.github.com/repos/#{repository.name}/pulls")
      .with(query: hash_including({}))
      .to_return_json(
        {body: JSON.parse(File.read("spec/fixtures/pulls.json"))},
        {body: JSON.parse(File.read("spec/fixtures/pulls-2.json"))},
        {body: []}
      )

    Timecop.freeze(Date.new(2024, 2, 8))
  end

  after do
    Timecop.return
  end

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
