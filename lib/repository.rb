require_relative "pulls"

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
