require_relative 'deck'


class Hand
  attr_accessor :cards

  HAND_LEVELS = [:straight_flush, :four_of_a_kind, :full_house, :flush,
                 :straight, :three_of_a_kind, :two_pair, :pair, :high_card]

  def initialize(deck, cards = deck.deal(5))
    @deck = deck
    @cards = cards
  end

  def evaluate
    HAND_LEVELS.each { |level| return level if send(level.to_s + "?") }
  end

  def beats?(other_hand)
    ranking = HAND_LEVELS.reverse

    if ranking.index(evaluate) > ranking.index(other_hand.evaluate)
      true
    elsif ranking.index(evaluate) < ranking.index(other_hand.evaluate)
      false
    else
      compare_match(other_hand)
    end
  end

  def find_high_card
  end

  def discard_and_replace(array)
    if array.size > 3
      raise StandardError
    end
    cards_to_discard = []
    @cards.each_with_index do |el, index|
      if array.include?(index)
        cards_to_discard << @cards[index]
        @cards[index] = nil
      end
    end
    @cards.compact!
    @deck.return(cards_to_discard)
    replace(array.length)
  end

  def replace(num)
    @cards += @deck.deal(num)
  end

  protected

  def freq_hash
    hash = Hash.new
    points.uniq.each do |value|
      hash[value] = points.count(value)
    end
    hash
  end

  def compare_match(other_hand)
    hashed_hand = self.freq_hash
    hashed_other = other_hand.freq_hash
    p hashed_hand, hashed_other

    (1..4).to_a.reverse.each do |i|
      my_keys = hashed_hand.keys.select { |k| hashed_hand[k] == i}.sort.reverse
      other_keys = hashed_other.keys.select { |k| hashed_other[k] == i}.sort.reverse
      p my_keys, other_keys
      my_keys.length.times do |j|
        if my_keys[j] > other_keys[j]
          return true
        elsif my_keys[j] < other_keys[j]
          return false
        end
      end
    end

    # these two hands are a match
    false
  end





  private

  def suits
    @cards.map(&:suit)
  end

  def values
    @cards.map(&:value)
  end

  def points
    @cards.map(&:points)
  end

  def n_of_a_kind? n
    values.uniq.any? { |value| values.count(value) == n }
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    values.uniq.size == 2
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    points.sort == (points.min..points.min + 4).to_a || points.sort == [14, 2, 3, 4, 5]
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    values.uniq.size == 3
  end

  def pair?
    n_of_a_kind?(2)
  end

  def high_card?
    true
  end
end
