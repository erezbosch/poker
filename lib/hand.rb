require_relative 'deck'

class Hand
  attr_reader :cards

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
      compare_cards_in_order_of_frequency(other_hand)
    end
  end

  def discard_and_replace(array)
    raise "Too many discards" if array.size > 3
    raise "Discard out of bounds" unless array.all? { |el| el.between?(0, 4) }

    discard(array)
    replace(array.size)
  end

  protected

  def frequency_hash
    points.uniq.each_with_object({}) do |value, hash|
      hash[value] = points.count(value)
    end
  end

  def compare_cards_in_order_of_frequency(other_hand)
    hand_hash = frequency_hash
    other_hash = other_hand.frequency_hash

    (1..4).to_a.reverse.each do |i|
      my_keys = hand_hash.keys.select { |k| hand_hash[k] == i}.sort.reverse
      other_keys = other_hash.keys.select { |k| other_hash[k] == i}.sort.reverse

      my_keys.size.times do |j|
        if my_keys[j] > other_keys[j]
          return true
        elsif my_keys[j] < other_keys[j]
          return false
        end
      end
    end

    # these two hands are a match: a doesn't beat b
    false
  end

  private

  def discard(array)
    discards = array.sort.reverse.inject([]) do |discards, idx|
       discards << @cards.delete_at(idx)
    end

    @deck.return(discards)
  end

  def replace(num)
    @cards += @deck.deal(num)
  end

  def suits
    @cards.map(&:suit)
  end

  def points
    @cards.map(&:points)
  end

  def n_of_a_kind? n
    points.uniq.any? { |value| points.count(value) == n }
  end

  ## The following methods MUST BE CALLED IN ORDER

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    points.uniq.size == 2
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    return true if points.sort == [14, 2, 3, 4, 5] # ace can be low
    points.sort == (points.min..points.min + 4).to_a
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    points.uniq.size == 3
  end

  def pair?
    n_of_a_kind?(2)
  end

  def high_card?
    true
  end
end
