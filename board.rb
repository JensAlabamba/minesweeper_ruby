require_relative "chunk"

class Board

    attr_reader :grid_size, :num_bombs

    def initialize(grid_size, num_bombs)
        @grid_size = grid_size
        @num_bombs = num_bombs

        create_board
    end
    
    def create_board
        @grid = Array.new(@grid_size) do |row|
            Array.new(@grid_size) { |col| Chunk.new(self, [row, col]) }
        end
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def lost?
        @grid.flatten.any? { |tile| tile.bombed? != explored? }
    end
end