require_relative './piece'

class Bishop < Piece
  def name
    "B"
  end

  def legal_moves_from(pos)
    diagonal_moves_from(pos)
  end
end
