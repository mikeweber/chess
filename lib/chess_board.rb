require_relative './chess_square'

class ChessBoard
  attr_reader :active_square

  def initialize
    self.pieces = []
    self.squares = 64.times.map do |i|
      pos = Pos.new(i)
      color = pos.row % 2 == pos.col % 2 ? { r: 255, g: 255, b: 255 } : { r: 0, g: 0, b: 0 }
      ChessSquare.new(pos, color)
    end
  end

  def add_piece(piece, pos)
    pieces[pos.index] = piece
  end

  def remove_piece(pos)
    pieces[pos.index] = nil
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
    end
  end

  def set_active(pos)
    active_square.deactivate if active_square

    self.active_square = square_at(pos)
    self.active_square.activate
  end

  def square_at(pos)
    squares[pos.index]
  end

  private

  attr_accessor :pieces, :squares
  attr_writer :active_square
end
