class ChessSquare
  BLACK = { r: 40, g: 40, b: 40 }
  WHITE = { r: 215, g: 215, b: 215 }
  GREEN = { r: 127, g: 200, b: 127 }
  RED   = { r: 200, g: 127, b: 127 }
  attr_reader :active, :current_color, :original_color, :active_color, :piece, :piece_name, :piece_color

  def initialize(color, empty_piece, active_color = RED)
    @original_color = color
    @current_color = color
    @active_color = active_color
    @piece = empty_piece
    @empty_piece = empty_piece
    @active = false
  end

  def piece=(new_piece)
    @piece = new_piece || @empty_piece
    @piece_color = piece.color
    @piece_name = piece.name
  end

  def deactivate
    self.active = false
    reset
  end

  def activate
    self.active = false
    self.current_color = active_color
  end

  def highlight_for_move
    if current_color == BLACK
      self.current_color = { r: 0, g: 0, b: 120 }
    elsif current_color == WHITE
      self.current_color = { r: 170, g: 170, b: 255 }
    end
  end

  def highlight_for_capture
    self.current_color = { r: 200, g: 127, b: 127 }
  end

  def reset
    self.current_color = original_color
  end

  def active?
    active
  end

  private

  attr_writer :active, :current_color
end
