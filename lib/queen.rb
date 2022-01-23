require_relative './piece'

class Queen < Piece
  def name
    "Q"
  end

  def legal_moves_from(pos)
    cardinal_moves_from(pos) + diagonal_moves_from(pos)
  end
end
