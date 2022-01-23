class ChessSquare
  BLACK = { r: 0, g: 0, b: 0 }
  WHITE = { r: 255, g: 255, b: 255 }
  GREEN = { r: 127, g: 200, b: 127 }
  RED   = { r: 200, g: 127, b: 127 }
  attr_reader :pos, :active, :current_color, :original_color, :active_color

  def initialize(pos, color, active_color = RED)
    @pos = pos
    @original_color = color
    @current_color = color
    @active_color = active_color
    @active = false
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
