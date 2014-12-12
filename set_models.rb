require 'pry'

Colors = [:green, :red, :purple]
Shapes = [:rectangles, :diamonds, :ovals]
Fills = [:solid, :empty, :striped]
Numbers = [1, 2, 3]
Attributes = [:color, :shape, :fill, :number]

def set?(card1, card2, card3)
  Attributes.each do |attribute|
    c1 = card1.send(attribute)
    c2 = card2.send(attribute)
    c3 = card3.send(attribute)
    unless (c1 == c2 && c1 == c3) || (c1 != c2 && c2 != c3 && c1 != c3)
      return false
    end
  end
  true
end

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    Colors.each do |color|
      Shapes.each do |shape|
        Fills.each do |fill|
          Numbers.each do |number|
            @cards << Card.new(color, shape, fill, number)
          end
        end
      end
    end
    @cards.shuffle!
  end

  def draw
    @cards.pop
  end
end

class Card
  def initialize(color,shape,fill,number)
    @color = color
    @shape = shape
    @fill = fill
    @number = number
  end

  attr_reader :color, :shape, :fill, :number
end

class Board
  attr_accessor :cards

  def initialize(deck)
    @cards = []
    @deck = deck
    12.times { draw_card }
  end

  def draw_card
    @cards << @deck.draw
  end

  def combinations
    cards.combination(3).to_a
  end

  def choose_set(index1, index2, index3)
    return "Not a set" unless set?(cards[index1], cards[index2], cards[index3])
    [index1, index2, index3].each do |index|
      cards[index] = @deck.draw
    end
    "Found a set"
  end

  def any_sets?
    combinations.each do |combination|
      return true if set?(combination[0], combination[1], combination[2])
    end
    false
  end

  def find_set
    combinations.each do |combination|
      if set?(combination[0], combination[1], combination[2])
        return combination
      end
    end
    false
  end
end


binding.pry
