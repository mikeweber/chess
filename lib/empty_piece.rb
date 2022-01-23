require_relative './piece'

class EmptyPiece < Piece
  def name
    ""
  end

  def opponent?(_other)
    false
  end

  def empty?
    true
  end
end
