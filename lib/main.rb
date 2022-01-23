require 'glimmer-dsl-libui'
require_relative './chess_board'
require_relative './pos'
require_relative './queen'

class ChessGUI
  include Glimmer

  def initialize(width, height)
    @width = width
    @height = height
    @square_size = [width, height].min / 8
    @chess_board = ChessBoard.new
    chess_board.add_piece(Queen.new(board: chess_board, team: :white), Pos.new(19))
    chess_board.add_piece(Queen.new(board: chess_board, team: :black), Pos.new(21))
    chess_board.add_piece(Queen.new(board: chess_board, team: :white), Pos.new(14))
    chess_board.add_piece(Queen.new(board: chess_board, team: :white), Pos.new(12))
    chess_board.add_piece(Queen.new(board: chess_board, team: :white), Pos.new(60))
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
                square(0, 0, square_size) {
                  fill <= [chess_board.square_at(pos), :current_color]
                }
                text(square_size / 2 - 20, square_size / 2 - 27) {
                  string {
                    font family: 'Arial', size: OS.mac? ? 50 : 40
                    color <= [chess_board.piece_at(pos), :color]
                    string <= [chess_board.piece_at(pos), :name]
                  }
                }

                on_mouse_up do
                  chess_board.toggle_active(pos)
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
