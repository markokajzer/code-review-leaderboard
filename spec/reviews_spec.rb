require "reviews"

require "repository"

RSpec.describe Reviews, :github_mock do
  let(:repository) { Repository.new(name: "rails/rails") }
  let(:pull) { object_fixture("spec/fixtures/pull-208.json") }

  before do
    Timecop.freeze(Date.new(2024, 2, 8))

    [208, 206].each do |number|
      stub_request(:get, "https://api.github.com/repos/#{repository.name}/pulls/#{number}/reviews")
        .with(query: hash_including({}))
        .to_return_json(body: JSON.parse(File.read("spec/fixtures/reviews-#{number}.json")))
    end
  end

  after do
    Timecop.return
  end

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
