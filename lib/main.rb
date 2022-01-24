require 'glimmer-dsl-libui'
require_relative './chess_board'
require_relative './pos'

class ChessGUI
  include Glimmer

  def initialize(width, height)
    @width = width
    @height = height
    @square_size = [width, height].min / 8
    @chess_board = ChessBoard.setup
  end

  def launch
    @main_window = create_gui
    register_observers
    main_window.show
  end

  def register_observers
    @gui_squares.each.with_index do |gui_square, i|
      chess_square = chess_board.square_at(Pos.new(i))
      observe(chess_square, :piece) do |piece|
        gui_square.string = piece.name
        gui_square.color = piece.color
      end
    end
  end

  def create_gui
    main_window = window("Chess", width, height) {
      resizable false

      @gui_squares = []
      vertical_box {
        padded false

        8.times.map do |row|
          horizontal_box {
            padded false

            8.times do |col|
              pos = Pos.from_row_col(row, col)
              chess_square = chess_board.square_at(pos)
              area {
                square(0, 0, square_size) {
                  fill <= [chess_square, :current_color]
                }
                text(square_size / 2 - 20, square_size / 2 - 27) {
                  @gui_squares << string {
                    font family: 'Arial', size: OS.mac? ? 50 : 40
                    color <= [chess_square, :piece_color]
                    string <= [chess_square, :piece_name]
                  }
                }

                on_mouse_up do
                  chess_board.select_square_at(pos)
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
