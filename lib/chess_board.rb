require_relative './chess_square'
require_relative './pieces'

class ChessBoard
  attr_reader :active_position, :team_turn

  def self.setup
    board = new
    [[:white, -1, 1], [:black, 64, -1]].each do |team, start, inc|
      index = start
      board.add_piece(Rook.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Knight.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Bishop.new(board: board, team: team), Pos.new(index += inc))
      if team == :black
        board.add_piece(Queen.new(board: board, team: team), Pos.new(index += inc))
        board.add_piece(King.new(board: board, team: team), Pos.new(index += inc))
      else
        board.add_piece(King.new(board: board, team: team), Pos.new(index += inc))
        board.add_piece(Queen.new(board: board, team: team), Pos.new(index += inc))
      end
      board.add_piece(Bishop.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Knight.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Rook.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
      board.add_piece(Pawn.new(board: board, team: team), Pos.new(index += inc))
    end
    board
  end

  def initialize
    @team_turn = :white
    empty_piece = EmptyPiece.new
    self.squares = 64.times.map do |i|
      pos = Pos.new(i)
      color = pos.row % 2 == pos.col % 2 ? ChessSquare::WHITE : ChessSquare::BLACK
      ChessSquare.new(color, empty_piece)
    end
  end

  def select_square_at(pos)
    if active_position
      move = active_piece.legal_moves_from(active_position).detect { |move| move.pos == pos }
      if move
        puts "active piece can move to #{move.pos}"
        move_piece(active_position, move.pos)
        toggle_active(active_position)
      elsif piece_at(pos).team == team_turn
        puts "clicked on a different piece for the current team"
        toggle_active(pos)
      elsif pos == active_position
        puts "toggling the active position off or activating a new position"
        toggle_active(pos)
      end
    elsif piece_at(pos).team == team_turn
      puts "toggling #{pos}"
      toggle_active(pos)
    end
  end

  def move_piece(from_pos, to_pos)
    piece = piece_at(from_pos)
    piece.move!((to_pos.row - from_pos.row).abs)
    add_piece(piece, to_pos)
    remove_piece(from_pos)
    if to_pos.row > 0 && to_pos.row < 7
      [Pos.from_row_col(to_pos.row + 1, to_pos.col), Pos.from_row_col(to_pos.row - 1, to_pos.col)].each do |passable_pos|
        remove_piece(passable_pos) if piece_at(passable_pos).passable
      end
    end
    end_turn
  end

  def add_piece(piece, pos)
    squares[pos.index].piece = piece
  end

  def remove_piece(pos)
    squares[pos.index].piece = nil
  end

  def piece_at(pos)
    square_at(pos).piece
  end

  def toggle_active(pos)
    if active_position != pos
      set_active(pos)
    else
      active_square.deactivate
      self.active_position = nil
      reset_all_squares
    end
  end

  def set_active(pos)
    active_square.deactivate if active_square

    reset_all_squares
    self.active_position = pos
    self.active_square.activate
    highlight_legal_moves_from(pos)
  end

  def active_square
    return if active_position.nil?

    square_at(active_position)
  end

  def active_piece
    return if active_position.nil?

    piece_at(active_position)
  end

  def highlight_legal_moves_from(pos)
    active_piece = piece_at(pos)
    active_piece.legal_moves_from(pos).each do |move|
      highlight_color = move.is_capture? ? square_at(move.pos).highlight_for_capture : square_at(move.pos).highlight_for_move
    end
  end

  def reset_all_squares
    squares.each(&:reset)
  end

  def square_at(pos)
    squares[pos.index]
  end

  def end_turn
    toggle_teams
    reset_pieces
  end

  private

  attr_accessor :squares
  attr_writer :active_square, :active_position

  def toggle_teams
    @team_turn = team_turn == :white ? :black : :white
  end

  def reset_pieces
    squares.each { |s| s.piece.reset if s.piece.team == team_turn }
  end
end
