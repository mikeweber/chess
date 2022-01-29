class Knight < Piece
  def name
    "N"
  end

  def legal_moves_from(pos)
    map_moves(legal_positions_from(pos), calculate_all_positions: true)
  end

  def legal_positions_from(pos)
    [
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1],
      [-2, 1],
      [-1, 2]
    ].map do |row_offset, col_offset|
      begin
        Pos.from_row_col(pos.row + row_offset, pos.col + col_offset)
      rescue ArgumentError
      end
    end.compact
  end
end
