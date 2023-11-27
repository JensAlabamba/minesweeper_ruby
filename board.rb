class Board

    def self.empty_grid
        Array.new(9) do 
            Arry.new(9) { Chunk.new(0) }
    end

    def initialize(grid = self.empty_grid)
        @grid = grid
    end
end