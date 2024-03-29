require "code_review_leaderboard/spinner"

RSpec.describe CodeReviewLeaderboard::Spinner do
  before do
    allow(Whirly).to receive(:start).and_yield
  end

  it "shows the spinner" do
    described_class.start { "result" }

    expect(Whirly).to have_received(:start).with(
      hash_including(spinner: "dots", stop: "✔")
    )
  end

  it "returns the result of the block" do
    expect(described_class.start { "result" })
      .to eq("result")
  end
end
