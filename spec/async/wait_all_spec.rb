require "async/wait_all"

RSpec.describe "WaitAll" do
  it "waits for all tasks to complete" do
    expect do
      WaitAll do |barrier|
        Async do
          barrier.async do
            sleep(0.02)
            puts "slow"
          end
          barrier.async do
            sleep(0.01)
            puts "fast"
          end
        end
      end
      puts "done"
    end.to output("fast\nslow\ndone\n").to_stdout
  end
end
