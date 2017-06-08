class Tile
  @@tile_sprite = Gosu::Image::load_tiles "2048tiles.png", 128, 128

  attr_reader :value, :fresh

  def initialize(value, fresh=true)
    Area.victory if value == 16384

    @value = value
    @sprite_index = value >= 2 ? sprite_index : nil
    @fresh = fresh
  end

  EMPTY = Tile.new 0

  def update
    @fresh = false
  end

  def draw(pos)
    @@tile_sprite[@sprite_index].draw x_pos(pos), y_pos(pos), 1 if @sprite_index
  end

  def self.empty
    EMPTY
  end

  def ==(other_tile)
    @value == other_tile.value
  end

  def same(other_tile)
    @value == other_tile.value && !@fresh && !other_tile.fresh
  end

  def +(other_tile)
    return EMPTY if other_tile == EMPTY && self == EMPTY

    Tile.new @value + other_tile.value, !(other_tile == EMPTY || self == EMPTY)
  end

  private

  def sprite_index(i = 0, tmp_value = @value)
    return i if tmp_value <= 2

    sprite_index i + 1, tmp_value / 2
  end

  def x_pos(pos)
    pos % 4 * 128 + 1
  end

  def y_pos(pos)
    pos / 4 * 128 + 1
  end
end