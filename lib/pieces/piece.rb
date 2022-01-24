class Piece
  attr_reader :board, :team, :name

  def initialize(board:, team: nil)
    raise "Team can only be :black or :white" unless team.nil? || %i[black white].include?(team)

    @board = board
    @team = team
    @moved = false
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

  def moved?
    @moved
  end

  def move!
    @moved = true
  end

  protected

  def cardinal_moves_from(pos, limit = nil)
    moves  = map_moves(left_positions(pos, limit))
    moves += map_moves(right_positions(pos, limit))
    moves += map_moves(up_positions(pos, limit))
    moves += map_moves(down_positions(pos, limit))
    moves
  end

  def diagonal_moves_from(pos, limit = nil)
    moves  = map_moves(left_up_positions(pos, limit))
    moves += map_moves(right_up_positions(pos, limit))
    moves += map_moves(left_down_positions(pos, limit))
    moves += map_moves(right_down_positions(pos, limit))
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

  def left_positions(pos, limit)
    [pos.col, limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row, pos.col - (i + 1))
    end
  end

  def right_positions(pos, limit)
    [(7 - pos.col), limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row, pos.col + (i + 1))
    end
  end

  def up_positions(pos, limit)
    [pos.row, limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row - (i + 1), pos.col)
    end
  end

  def down_positions(pos, limit)
    [(7 - pos.row), limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row + (i + 1), pos.col)
    end
  end

  def left_up_positions(pos, limit)
    [pos.row, pos.col, limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row - (i + 1), pos.col - (i + 1))
    end
  end

  def right_up_positions(pos, limit)
    [pos.row, 7 - pos.col, limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row - (i + 1), pos.col + (i + 1))
    end
  end

  def left_down_positions(pos, limit)
    [7 - pos.row, pos.col, limit].compact.min.times.map do |i|
      Pos.from_row_col(pos.row + (i + 1), pos.col - (i + 1))
    end
  end
 
  def right_down_positions(pos, limit)
    [7 - pos.row, 7 - pos.col, limit].compact.min.times.map do |i|
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
