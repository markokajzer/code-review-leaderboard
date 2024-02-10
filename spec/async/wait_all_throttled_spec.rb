require "async/wait_all_throttled"

RSpec.describe "WaitAllThrottled" do
  it "waits for all tasks to complete" do
    order = []
    WaitAllThrottled([1, 2, 3], concurrency: 2) do |i|
      order << i
      sleep 0.01
      order << i
    end

    expect(order).to eq([1, 2, 1, 3, 2, 3])
  end

  it "aggregates the results" do
    expect(
      WaitAllThrottled([1, 2, 3], concurrency: 2) { _1 * _1 }.sum
    ).to eq(14)
  end
end
