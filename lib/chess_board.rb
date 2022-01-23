require_relative './chess_square'
require_relative './empty_piece'

class ChessBoard
  attr_reader :active_square

  def initialize
    self.pieces = 64.times.map { EmptyPiece.new(board: self) }
    self.squares = 64.times.map do |i|
      pos = Pos.new(i)
      color = pos.row % 2 == pos.col % 2 ? { r: 255, g: 255, b: 255 } : { r: 0, g: 0, b: 0 }
      ChessSquare.new(pos, color)
    end
  end

  def move_piece(from_pos, to_pos)
    piece = piece_at(from_pos)
    return false unless can_move_to?(piece, to_pos)
  end

  def can_move_to?(piece, from_pos, to_pos)
    piece.legal_moves_from(from_pos).include?(to_pos)
  end

  def add_piece(piece, pos)
    pieces[pos.index] = piece
  end

  def remove_piece(pos)
    pieces[pos.index] = nil
  end

  def piece_at(pos)
    pieces[pos.index]
  end

  def active_at?(pos)
    squares[pos.index].active?
  end

  def toggle_active(pos)
    if active_square.nil? || active_square.pos != pos
      set_active(pos)
    else
      active_square.deactivate
      self.active_square = nil
      reset_all_squares
    end
  end

  def set_active(pos)
    active_square.deactivate if active_square

    reset_all_squares
    self.active_square = square_at(pos)
    self.active_square.activate
    highlight_legal_moves_from(pos)
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

  private

  attr_accessor :pieces, :squares
  attr_writer :active_square
end
