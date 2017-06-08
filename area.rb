class Area
  def initialize
    @area_sprite = Gosu::Image.new "2048area.png"

    @tiles = Array.new 4 { Array.new 4 { Tile.empty } }
  end

  def update(direction)
    @tiles.flatten.each { |tile| tile.update }
    tiles_has_changed = false    

    rotate direction

    @tiles = @tiles.map do |row|
      row = row.inject [] do |r, tile|
        if r.last && (r.last.same(tile) || r.last == Tile.empty || tile == Tile.empty)
          tiles_has_changed ||= tile != Tile.empty
          r << r.pop + tile
        else
          r << tile
        end
      end
      row << Tile.empty while row.length < 4
      row
    end

    unrotate direction

    add_tile if tiles_has_changed || empty_area?
    Area.defeat if lose?
  end

  def draw
    @area_sprite.draw 0, 0, 0
    @tiles.flatten.each_with_index { |tile, pos| tile.draw pos }
  end

  def self.victory
    puts "you're strong"
    exit
  end

  def self.defeat
    puts "you lose"
    exit
  end

  private

  def rotate(direction)
    case direction
    when :left
      return
    when :right
      @tiles.each{ |r| r.reverse! }
    when :up
      @tiles = @tiles.transpose
    when :down
      @tiles = @tiles.transpose.each{ |r| r.reverse! } 
    end
  end

  def unrotate(direction)
    case direction
    when :left
      return
    when :right
      @tiles.each{ |r| r.reverse! }
    when :up
      @tiles = @tiles.transpose
    when :down
      @tiles = @tiles.each{ |r| r.reverse! }.transpose 
    end
  end

  def lose?
    return false if @tiles.flatten.include?(Tile::empty)

    @tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        return false if @tiles[y][x + 1] == tile || (y < 3 && @tiles[y][x] == @tiles[y + 1][x])
      end
    end

    true
  end

  def add_tile
    empty_tiles_idx = @tiles.flatten.map.with_index { |t, idx| idx if t == Tile.empty }.compact
    i = empty_tiles_idx.sample
    @tiles[i / 4][i % 4] = Tile.new [2, 2, 2, 2, 2, 2, 2, 2, 4, 4].sample
  end

  def empty_area?
    @tiles.flatten.reject { |tile| tile == Tile.empty }.length == 0
  end
end