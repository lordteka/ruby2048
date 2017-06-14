require 'minitest/autorun'
require 'minitest/pride'
require_relative '../ruby2048.rb'


#FIXME
class Tile
  def inspect
    "#{@value}"
  end
end

class Area
  attr_accessor :tiles

  def add_tile
    #NOOP
  end

  def defeat
  end

  public :lose?
end

class AreaTest < Minitest::Test
  def setup
    @area = Area.new
  end

  def test_that_the_non_empty_tiles_goes_up
    @area.tiles = [(Array.new 4  { Tile.empty }),
                  [Tile.empty, Tile.new(2), Tile.empty, Tile.empty],
                  (Array.new 4  { Tile.empty }),
                  (Array.new 4  { Tile.empty })]

    @area.update :up

    assert_equal @area.tiles.inspect, [[0, 2, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0]].inspect
  end

  def test_that_the_non_empty_tiles_goes_down
    @area.tiles = [(Array.new 4  { Tile.empty }),
                  [Tile.empty, Tile.new(2), Tile.empty, Tile.empty],
                  (Array.new 4  { Tile.empty }),
                  (Array.new 4  { Tile.empty })]

    @area.update :down

    assert_equal @area.tiles.inspect, [[0, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 2, 0, 0]].inspect
  end

  def test_that_the_non_empty_tiles_goes_left
    @area.tiles = [(Array.new 4  { Tile.empty }),
                  [Tile.empty, Tile.new(2), Tile.empty, Tile.empty],
                  (Array.new 4  { Tile.empty }),
                  (Array.new 4  { Tile.empty })]

    @area.update :left

    assert_equal @area.tiles.inspect, [[0, 0, 0, 0],
                                       [2, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0]].inspect
  end

  def test_that_the_non_empty_tiles_goes_right
    @area.tiles = [(Array.new 4  { Tile.empty }),
                  [Tile.empty, Tile.new(2), Tile.empty, Tile.empty],
                  (Array.new 4  { Tile.empty }),
                  (Array.new 4  { Tile.empty })]

    @area.update :right

    assert_equal @area.tiles.inspect, [[0, 0, 0, 0],
                                       [0, 0, 0, 2],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0]].inspect
  end

  def test_fusion
    @area.tiles = [[Tile.new(2), Tile.new(2), Tile.empty, Tile.empty],
                   [Tile.new(2), Tile.empty, Tile.empty, Tile.new(2)],
                   [Tile.empty, Tile.empty, Tile.new(2), Tile.new(2)],
                   [Tile.empty, Tile.new(2), Tile.new(2), Tile.new(4)]]

    @area.update :left

    assert_equal @area.tiles.inspect, [[4, 0, 0, 0],
                                      [4, 0, 0, 0],
                                      [4, 0, 0, 0],
                                      [4, 4, 0, 0]].inspect
  end

  def test_lose_condition
    @area.tiles = [[Tile.new(2), Tile.new(4), Tile.new(2), Tile.new(4)],
                   [Tile.new(4), Tile.new(2), Tile.new(4), Tile.new(2)],
                   [Tile.new(2), Tile.new(4), Tile.new(2), Tile.new(4)],
                   [Tile.new(4), Tile.new(8), Tile.empty, Tile.new(2)]]

    assert !@area.lose?

    @area.tiles = [[Tile.new(2), Tile.new(4), Tile.new(2), Tile.new(4)],
                   [Tile.new(4), Tile.new(2), Tile.new(4), Tile.new(2)],
                   [Tile.new(2), Tile.new(4), Tile.new(2), Tile.new(4)],
                   [Tile.new(4), Tile.new(2), Tile.new(4), Tile.new(2)]]

    assert @area.lose?

    @area.tiles = [[Tile.new(2), Tile.new(4), Tile.new(2), Tile.new(4)],
                   [Tile.new(4), Tile.new(2), Tile.new(4), Tile.new(2)],
                   [Tile.new(2), Tile.new(4), Tile.new(2), Tile.new(4)],
                   [Tile.new(4), Tile.new(2), Tile.new(2), Tile.new(2)]]

    assert !@area.lose?
  end
end
