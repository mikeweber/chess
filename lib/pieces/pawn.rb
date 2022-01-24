require_relative './piece'

class Pawn < Piece
  def name
    "P"
  end

  def legal_moves_from(pos)
    if team == :white
      map_moves(down_positions(pos, moved? ? 1 : 2))
    else
      map_moves(up_positions(pos, moved? ? 1 : 2))
    end
  end
end
