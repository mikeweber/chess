require_relative './piece'

class King < Piece
  def name
    "K"
  end

  def legal_moves_from(pos)
    cardinal_moves_from(pos, 1) + diagonal_moves_from(pos, 1)
  end
end
