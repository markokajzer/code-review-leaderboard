class Reviews
  class << self
    def for(repository:, pull:)
      new(repository:, pull:).reviews
    end
  end

  def initialize(repository:, pull:)
    @repository = repository
    @pull = pull
  end

  # TODO: `COMMENTED` should either not count, or only count once
  # if didn't otherwise review
  def reviews
    puts "Fetching reviews for #{repository.name}##{pull.number}..."

    fetch_reviews
      .map { {user: _1.user.login, state: _1.state.downcase.to_sym} }
  end

  private

  attr_reader :repository, :pull

  delegate :client, to: Adapters::Github

  def fetch_reviews
    @fetch_reviews ||= client.pull_request_reviews(repository.name, pull.number)
  end
end
