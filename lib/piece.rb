class Piece
  attr_reader :board, :team, :name

  def initialize(board:, team: nil)
    raise "Team can only be :black or :white" unless team.nil? || %i[black white].include?(team)

    @board = board
    @team = team
  end

  def legal_moves_from(pos)
    []
  end

  def color
    team == :white ? { r: 200, g: 200, b: 200 } : { r: 55, g: 55, b: 55 }
  end

  def opponent?(other)
    !other.team.nil? && team != other.team
  end

  def empty?
    false
  end

  protected

  def cardinal_moves_from(pos)
    moves  = map_moves(left_positions(pos))
    moves += map_moves(right_positions(pos))
    moves += map_moves(up_positions(pos))
    moves += map_moves(down_positions(pos))
    moves
  end

  def diagonal_moves_from(pos)
    moves  = map_moves(left_up_positions(pos))
    moves += map_moves(right_up_positions(pos))
    moves += map_moves(left_down_positions(pos))
    moves += map_moves(right_down_positions(pos))
    moves
  end

  def map_moves(positions)
    moves = []
    positions.each do |pos|
      piece = board.piece_at(pos)
      is_opponent = opponent?(piece)
      moves << Move.new(pos, is_opponent) if piece.empty? || is_opponent
      break unless piece.empty?
    end
    moves
  end

  def left_positions(pos)
    (pos.col == 0 ? [] : 0..(pos.col - 1)).reverse_each.map { |x| Pos.from_row_col(pos.row, x) }
  end

  def right_positions(pos)
    (pos.col == 7 ? [] : (pos.col + 1)..7).map { |x| Pos.from_row_col(pos.row, x) }
  end

  def up_positions(pos)
    (pos.row == 0 ? [] : 0..(pos.row - 1)).reverse_each.map { |y| Pos.from_row_col(y, pos.col) }
  end

  def down_positions(pos)
    (pos.row == 7 ? [] : (pos.row + 1)..7).map { |y| Pos.from_row_col(y, pos.col) }
  end

  def left_up_positions(pos)
    [pos.row, pos.col].min.times.map do |i|
      Pos.from_row_col(pos.row - (i + 1), pos.col - (i + 1))
    end
  end

  def right_up_positions(pos)
    [pos.row, 7 - pos.col].min.times.map do |i|
      Pos.from_row_col(pos.row - (i + 1), pos.col + (i + 1))
    end
  end

  def left_down_positions(pos)
    [7 - pos.row, pos.col].min.times.map do |i|
      Pos.from_row_col(pos.row + (i + 1), pos.col - (i + 1))
    end
  end
 
  def right_down_positions(pos)
    [7 - pos.row, 7 - pos.col].min.times.map do |i|
      Pos.from_row_col(pos.row + (i + 1), pos.col + (i + 1))
    end
  end
end

class Move
  attr_reader :pos, :is_capture

  def initialize(pos, is_capture)
    @pos = pos
    @is_capture = is_capture
  end

  def is_capture?
    is_capture
  end
end
