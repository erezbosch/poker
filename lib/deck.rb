require_relative 'card'

class Deck
  def initialize(cards = Deck.standard_deck)
    @cards = cards
  end

  def all_cards
    @cards
  end

  def return new_cards
    raise "That's not an array!" unless new_cards.is_a?(Array)
    @cards += new_cards
  end

  def deal num_cards
    raise "That's too many cards!" if num_cards > all_cards.size
    @cards.shift(num_cards)
  end

  private

  def self.standard_deck
    new_deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        new_deck << Card.new(value, suit)
      end
    end
    new_deck
  end
end
