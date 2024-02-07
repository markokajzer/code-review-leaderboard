require "terminal-table"

class Formatter
  def initialize(tally)
    @tally = tally
  end

  def to_table
    Terminal::Table.new(headings:) do |rows|
      totals.each do |user, reviews|
        rows << [user, reviews[:total], reviews[:approved], reviews[:changes_requested], reviews[:commented]]
      end
    end
  end

  private

  attr_reader :tally

  def totals
    tally.each_with_object({}) do |review, totals|
      totals[review[:user].to_sym] ||= Hash.new(0)
      totals[review[:user].to_sym][review[:state]] += 1
      totals[review[:user].to_sym][:total] += 1
    end
      .sort_by { _2[:total] }
      .reverse
  end

  def headings
    ["Login", "Total", "Approved", "Changes Requested", "Commented"]
  end
end
