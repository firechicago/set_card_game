COLORS = [:green, :red, :purple]
SHAPES = [:rectangles, :diamonds, :ovals]
FILLS = [:solid, :empty, :striped]
NUMBERS = [1, 2, 3]
ATTRIBUTES = [:color, :shape, :fill, :number]

def set?(card1, card2, card3)
  ATTRIBUTES.each do |attribute|
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
    COLORS.each do |color|
      SHAPES.each do |shape|
        FILLS.each do |fill|
          NUMBERS.each do |number|
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

  def empty?
    cards.length == 0
  end
end

class Card
  def initialize(color, shape, fill, number)
    @color = color
    @shape = shape
    @fill = fill
    @number = number
  end

  attr_reader :color, :shape, :fill, :number
end

class Board
  attr_accessor :cards
  attr_reader :deck

  def initialize(deck)
    @cards = []
    @deck = deck
    12.times { draw_card }
  end

  def draw_card
    @cards << deck.draw unless deck.empty?
  end

  def combinations
    cards.combination(3).to_a
  end

  def choose_set(index1, index2, index3)
    return "Not a set" unless set?(cards[index1], cards[index2], cards[index3])
    [index1, index2, index3].sort.reverse.each do |index|
      unless deck.empty? || cards.length > 12
        cards[index] = @deck.draw
      else
        cards.delete_at(index)
      end
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
