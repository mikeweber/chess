require_relative './piece'

class Rook < Piece
  def name
    "R"
  end

  def legal_moves_from(pos)
    cardinal_moves_from(pos)
  end
end
