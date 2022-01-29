class Pos
  attr_reader :index, :row, :col

  def initialize(i)
    raise ArgumentError.new("#{i} must be between 0 and 63, inclusive") if i < 0 || 63 < i

    @index = i
    @row   = i / 8
    @col   = i % 8
  end

  def self.from_row_col(row, col)
    raise ArgumentError.new("row [#{row}] or col [#{col}] was out of bounds") unless inbounds?(row, col)

    new(row * 8 + col)
  end

  def self.inbounds?(row, col)
    0 <= row && row <= 7 && 0 <= col && col <= 7
  end

  def ==(other)
    index == other.index
  end

  def to_s
    "#{row}x#{col}"
  end
end
