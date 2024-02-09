RSpec.configure do |config|
  config.before(github_mock: true) do
    stub_const("Pulls::PER_PAGE", 2)

    if defined?(repository)
      stub_request(:get, "https://api.github.com/repos/#{repository.name}/pulls")
        .with(query: hash_including({}))
        .to_return_json(
          {body: JSON.parse(File.read("spec/fixtures/pulls.json"))},
          {body: JSON.parse(File.read("spec/fixtures/pulls-2.json"))},
          {body: []}
        )
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
