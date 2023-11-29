require_relative "chunk"

class Board

    attr_reader :grid_size, :num_bombs

    def initialize(grid_size, num_bombs)
        @grid_size = grid_size
        @num_bombs = num_bombs

        create_board
    end
    

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def lost?
        @grid.flatten.any? { |chunk| chunk.bombed? != chunk.explored? }
    end

    def won?
        @grid.flatten.all? { |chunk| chunk.bombed? != chunk.explored? }
    end

    def render(reveal = false)
        @grid.map do |row|
            row.map do |chunk|
                reveal ? chunk.reveal : chunk.render
            end.join("")
        end.join("\n")
    end

    def reveal
        render(true)
    end

    private

    def create_board
        @grid = Array.new(@grid_size) do |row|
            Array.new(@grid_size) { |col| Chunk.new(self, [row, col]) }
        end

        plant_bombs
    end

    def plant_bombs
        total_bombs = 0
        while total_bombs < @num_bombs
          rand_pos = Array.new(2) { rand(@grid_size) }
    
          tile = self[rand_pos]
          next if tile.bombed?
    
          tile.plant_bomb
          total_bombs += 1
        end
    
        nil
    end    
end