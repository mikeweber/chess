class ChessSquare
  attr_reader :pos, :active, :current_color, :original_color, :active_color

  def initialize(pos, color, active_color = { r: 127, g: 127, b: 127 })
    @pos = pos
    @original_color = color
    @current_color = color
    @active_color = active_color
    @active = false
  end

  def deactivate
    self.active = false
    self.current_color = original_color
  end

  def activate
    self.active = false
    self.current_color = active_color
  end

  def active?
    active
  end

  private

  attr_writer :active, :current_color
end
