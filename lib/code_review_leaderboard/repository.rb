require_relative "pulls"

module CodeReviewLeaderboard
  class Repository
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def pulls
      Pulls.for(repository: self)
    end

    def ==(other)
      name == other.name
    end
  end
end
