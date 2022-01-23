require_relative './chess_square'
require_relative './empty_piece'

class ChessBoard
  attr_reader :active_position, :team_turn

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
    add_piece(piece, to_pos)
    remove_piece(from_pos)
    toggle_turn
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

  def toggle_turn
    @team_turn = team_turn == :white ? :black : :white
  end

  private

  attr_accessor :squares
  attr_writer :active_square, :active_position
end
