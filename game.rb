require 'amazing_print'
#1. Crear lista de celulas con propiedades iniciales
#2. La lista de celulas tiene que tener celulas vivas y muertas aleatoreamente
#3. Contar cuantos vecinos vivos tiene cada celula 
#4. 
class Game
  attr_accessor :initial_generation
  #initialize the universe with random dead and alive cells
  def initialize(initial_generation = Generation.new(3,3))
    @initial_generation = initial_generation
  end

end

class Generation 
  attr_accessor :width, :height, :cells, :cell_list
    def initialize(width, height)
        @width = width
        @height = height
        @cells = []
        @second_generation = []
        # list of cells. Cell arra
        puts "First Generation"
        initial_generation = create_generation
        first_generation = self.random_generation(initial_generation)
        #sobrevivientes
        self.print_universe(first_generation)
        second_generation = next_generation(first_generation)
        puts "Second Generation"
        self.print_universe(second_generation)
    end

    def create_generation
        @cell_list = Array.new(@width) do |row|
            Array.new(@height) do |col|
              @x = Cell.new(col, row)
              @cells << @x
            end
        end
        @cells
    end
  
    def random_generation(generation)
        generation.each do |cell|
            random_life = [true, false].sample
            cell.alive = random_life
        end
    end

    def next_generation(generation)
        @temp_generation = generation
        @new_generation = create_generation
            @new_generation.each do |cell|
                # verify alive neighbours
                cell.alives = self.live_neighbours_around_cell(cell).count
                # if the cell is alive
                if cell.alive
                    #condition 1 : 
                    if cell.alives < 2
                        cell.die
                        
                    #condition 2 : 
                    elsif [2, 3].include?(cell.alives)
                        cell.alive
                        #@new_generation[cell].alive
                    #condition 3 : 
                    elsif cell.alives > 3
                        cell.alive
                        #@new_generation[cell].die
                    else
                        cell.die
                    end
                elsif cell.alive && cell.lives > 3
                    cell.revive!
                end
            end
        @new_generation
    end
    
    def print_universe(list)
        # cont = @width
        @alt = 0
        @result = @width * @height

        while @alt < @result do
          @width.times do |number|
            list[number + @alt].paint
          end 
          @alt = @alt + @width
          print "\n"
        end
        
    end

    def live_cells
        @cells.select { |cell| cell.alive }
    end
    def dead_cells
        @cells.select { |cell| cell.alive == false }
    end

    def live_neighbours_around_cell(cell)
      live_neighbours = []
      live_cells.each do |live_cell|
        # Neighbour to the North
        if live_cell.x == cell.x - 1 && live_cell.y == cell.y
           live_neighbours << live_cell
        end
        # Neighbour to the North-East
        if live_cell.x == cell.x - 1 && live_cell.y == cell.y + 1
           live_neighbours << live_cell
        end
        # Neighbour to the East
         if live_cell.x == cell.x && live_cell.y == cell.y + 1
          live_neighbours << live_cell
         end
        # Neighbour to the South-East
        if live_cell.x == cell.x + 1 && live_cell.y == cell.y + 1
          live_neighbours << live_cell
        end          # Neighbour to the South
        if live_cell.x == cell.x + 1 && live_cell.y == cell.y
          live_neighbours << live_cell
        end
        # Neighbour to the South-West
        if live_cell.x == cell.x + 1 && live_cell.y == cell.y - 1
          live_neighbours << live_cell
        end          # Neighbour to the West
       if live_cell.x == cell.x && live_cell.y == cell.y - 1
          live_neighbours << live_cell
        end
        # Neighbour to the North-West
        if live_cell.x == cell.x - 1 && live_cell.y == cell.y - 1
          live_neighbours << live_cell
        end
      end
        return live_neighbours
    end
end

class Cell
  attr_accessor :x, :y, :alive, :dead, :alives, :die, :revive, :paint

  def initialize(x=0, y=0)
    @x = x
    @y = y
    @alive = false
    @alives = 0
  end 
  def alive?
    alive
  end
  def dead?
    !alive
  end
  def die!
    @alive = false
  end
  def revive!
    @alive = true
  end
  def paint
    if self.alive
        print '*'
    else
        print '.'
    end
  end
end


game = Game.new

