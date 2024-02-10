require "code_review_leaderboard/formatter"

RSpec.describe CodeReviewLeaderboard::Formatter do
  subject(:formatter) { described_class.new(tally) }

  let(:tally) do
    [
      {user: "defunkt", state: :approved},
      {user: "bob", state: :commented},
      {user: "defunkt", state: :changes_requested},
      {user: "defunkt", state: :commented},
      {user: "alice", state: :changes_request},
      {user: "defunkt", state: :commented},
      {user: "alice", state: :approved},
      {user: "defunkt", state: :approved}
    ]
  end

  describe "#to_table" do
    subject(:table) { formatter.to_table.to_s }

    it "returns a table of the tally" do
      expect(table).to include("| Login   | Total | Approved | Changes Requested | Commented |")
      expect(table).to include("| defunkt | 5     | 2        | 1                 | 2         |")
      expect(table).to include("| alice   | 2     | 1        | 0                 | 0         |")
      expect(table).to include("| bob     | 1     | 0        | 0                 | 1         |")
    end
  end
end
