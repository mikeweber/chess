require 'glimmer-dsl-libui'
require_relative './chess_board'
require_relative './pos'

class ChessGUI
  include Glimmer

  def initialize(width, height)
    @width = width
    @height = height
    @square_size = [width, height].min / 8
    @chess_board = ChessBoard.new
  end

  def launch
    @main_window = create_gui
    main_window.show
  end

  def create_gui
    main_window = window("Chess", width, height) {
      resizable false

      vertical_box {
        padded false

        8.times.map do |row|
          horizontal_box {
            padded false

            8.times do |col|
              pos = Pos.from_row_col(row, col)
              area {
                p "rendering area #{pos.index}"
                square(0, 0, square_size) {
                  fill <= [chess_board.square_at(pos), :current_color]
                }

                on_mouse_up do
                  chess_board.toggle_active(pos)
                  p chess_board.active_at?(pos)
                end
              }
            end
          }
        end
      }
    }
  end

  private

  attr_reader :chess_board, :main_window, :width, :height, :square_size
end

ChessGUI.new(800, 800).launch
