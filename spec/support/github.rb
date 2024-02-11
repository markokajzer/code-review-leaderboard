RSpec.configure do |config|
  config.before(github_mock: true) do
    # TODO try removing this
    stub_const("#{CodeReviewLeaderboard::Pulls}::PER_PAGE", 2)

    if defined?(repository)
      stub_request(:get, "https://api.github.com/repos/#{repository.name}/pulls")
        .with(query: hash_including({}))
        .to_return_json(
          {body: JSON.parse(File.read("spec/fixtures/pulls.json"))},
          {body: JSON.parse(File.read("spec/fixtures/pulls-2.json"))},
          {body: []}
        )

      [208, 206, 112, 110].each do |number|
        stub_request(:get, "https://api.github.com/repos/#{repository.name}/pulls/#{number}/reviews")
          .with(query: hash_including({}))
          .to_return_json(body: JSON.parse(File.read("spec/fixtures/reviews-#{number}.json")))
      end
    end

    if defined?(organization)
      stub_request(:get, "https://api.github.com/orgs/#{organization.name}/repos")
        .with(query: hash_including({}))
        .to_return_json(
          body: JSON.parse(File.read("spec/fixtures/repos.json"))
        )
    end

    Timecop.freeze(Date.new(2024, 2, 8))
  end

  config.after(github_mock: true) do
    Timecop.return
  end
end
