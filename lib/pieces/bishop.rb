require_relative './piece'

class Bishop < Piece
  def name
    "B"
  end

  def legal_moves_from(pos)
    disagonal_moves_from(pos)
  end
end
