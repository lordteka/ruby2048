require 'gosu'
require_relative 'area'
require_relative 'tile'

class Ruby2048 < Gosu::Window
  def initialize
    super 514, 514 #FIXME gérer les dimensions en fonction de la dimension des tiles
    self.caption = "2048"
    @area = Area.new
  end

  def button_up(id)
    case id
    when Gosu::KB_UP
      @area.update :up
    when Gosu::KB_DOWN
      @area.update :down
    when Gosu::KB_LEFT
      @area.update :left
    when Gosu::KB_RIGHT
      @area.update :right
    when Gosu::KB_ESCAPE
      close
    end
  end

  def draw
    @area.draw
  end
end
