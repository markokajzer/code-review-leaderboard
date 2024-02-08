RSpec.configure do |config|
  config.before(github_mock: true) do
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

  config.after(github_mock: true) do
    Timecop.return
  end
end
