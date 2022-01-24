require_relative './piece'

class EmptyPiece < Piece
  def initialize
  end

  def name
    ""
  end

  def piece_color
    { r: 0, g: 0, b: 0 }
  end

  def piece_name
    ""
  end

  def opponent?(_other)
    false
  end

  def empty?
    true
  end
end
