class Pos
  attr_reader :index, :row, :col

  def initialize(i)
    @index = i
    @row   = i / 8
    @col   = i % 8
  end

  def self.from_row_col(row, col)
    new(row * 8 + col)
  end

  def ==(other)
    index == other.index
  end
end
