require_relative './piece'

class Pawn < Piece
  def name
    "P"
  end

  def legal_moves_from(pos)
    moves = []
    if pos.col > 1 && board.piece_at(Pos.new(pos.index - 1)).passable
      offset = team == :white ? 1 : -1
      moves << Move.new(Pos.from_row_col(pos.row + offset, pos.col - 1), true)
    elsif pos.col < 7 && board.piece_at(Pos.new(pos.index + 1)).passable
      offset = team == :white ? 1 : -1
      moves << Move.new(Pos.from_row_col(pos.row + offset, pos.col + 1), true)
    end
    if team == :white
      moves += map_moves(down_positions(pos, moved? ? 1 : 2), skip_captures: true)
      moves += map_moves(right_down_positions(pos, 1), only_captures: true)
      moves += map_moves(left_down_positions(pos, 1), only_captures: true)
    else
      moves += map_moves(up_positions(pos, moved? ? 1 : 2), skip_captures: true)
      moves += map_moves(right_up_positions(pos, 1), only_captures: true)
      moves += map_moves(left_up_positions(pos, 1), only_captures: true)
    end
  end

  def reset
    @passable = false
  end

  def move!(dist)
    super
    @passable = dist == 2
  end
end
