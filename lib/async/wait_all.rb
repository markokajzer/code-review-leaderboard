require "async/barrier"

def WaitAll(&block)
  barrier = Async::Barrier.new

  yield barrier

  barrier.wait
end
