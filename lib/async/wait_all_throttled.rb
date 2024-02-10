require "async/barrier"
require "async/semaphore"

require_relative "wait_all"

def WaitAllThrottled(array, concurrency: 5, &block)
  result = []

  WaitAll do |barrier|
    semaphore = Async::Semaphore.new(concurrency, parent: barrier)

    Async do
      array.each do |item|
        semaphore.async(parent: barrier) do
          result << yield(item)
        end
      end
    end
  end

  result.flatten
end
