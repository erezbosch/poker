class Card
  attr_reader :value, :suit

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

POINT_VALUES = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace => 14
  }

  def initialize(value, suit)
    @suit = suit
    @value = value
    unless Card.values.include?(value) && Card.suits.include?(suit)
      raise "Invalid value or suit provided."
    end
  end

  def self.values
    VALUE_STRINGS.keys
  end

  def self.suits
    SUIT_STRINGS.keys
  end

  def points
    POINT_VALUES[value]
  end

  def ==(other_card)
    return false if other_card.nil?
    other_card.value == value && other_card.suit == suit
  end
end
