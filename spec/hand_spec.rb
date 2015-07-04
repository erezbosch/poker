require 'rspec'
require 'hand'
require 'card'

describe Hand do
  let(:deck) { Deck.new }

  let(:high_card_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                 Card.new(:four, :clubs),
                                 Card.new(:six, :diamonds),
                                 Card.new(:eight, :spades),
                                 Card.new(:ten, :hearts)])}

  let(:pair_hand) {Hand.new(deck, [Card.new(:three, :spades),
                            Card.new(:three, :clubs),
                            Card.new(:six, :diamonds),
                            Card.new(:eight, :spades),
                            Card.new(:ten, :hearts)])}

  let(:two_pair_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                Card.new(:three, :clubs),
                                Card.new(:six, :diamonds),
                                Card.new(:six, :spades),
                                Card.new(:ten, :hearts)])}

  let(:two_pair_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                Card.new(:three, :clubs),
                                Card.new(:six, :diamonds),
                                Card.new(:six, :spades),
                                Card.new(:deuce, :hearts)])}

  let(:two_pair_hand2) {Hand.new(deck, [Card.new(:three, :spades),
                                        Card.new(:three, :hearts),
                                        Card.new(:five, :spades),
                                        Card.new(:five, :clubs),
                                        Card.new(:seven, :spades)])}

  let(:three_of_a_kind_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                       Card.new(:three, :clubs),
                                       Card.new(:three, :diamonds),
                                       Card.new(:six, :spades),
                                       Card.new(:ten, :hearts)])}

  let(:straight_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                Card.new(:four, :clubs),
                                Card.new(:five, :diamonds),
                                Card.new(:six, :spades),
                                Card.new(:seven, :hearts)])}

  let(:flush_hand) {Hand.new(deck, [Card.new(:three, :clubs),
                             Card.new(:three, :clubs),
                             Card.new(:six, :clubs),
                             Card.new(:six, :clubs),
                             Card.new(:ten, :clubs)])}

  let(:full_house_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                  Card.new(:three, :clubs),
                                  Card.new(:three, :diamonds),
                                  Card.new(:six, :spades),
                                  Card.new(:six, :hearts)])}

  let(:four_of_a_kind_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                      Card.new(:three, :clubs),
                                      Card.new(:three, :diamonds),
                                      Card.new(:three, :spades),
                                      Card.new(:six, :hearts)])}

  let(:four_of_a_kind_hand2) {Hand.new(deck, [Card.new(:deuce, :spades),
                                       Card.new(:deuce, :clubs),
                                       Card.new(:deuce, :diamonds),
                                       Card.new(:deuce, :spades),
                                       Card.new(:six, :hearts)])}

  let(:straight_flush_hand) {Hand.new(deck, [Card.new(:three, :spades),
                                      Card.new(:four, :spades),
                                      Card.new(:five, :spades),
                                      Card.new(:six, :spades),
                                      Card.new(:seven, :spades)])}

  let(:four_of_a_kind_hand2) {Hand.new(deck, [Card.new(:deuce, :spades),
                                       Card.new(:deuce, :clubs),
                                       Card.new(:deuce, :diamonds),
                                       Card.new(:deuce, :spades),
                                       Card.new(:six, :hearts)])}

  describe '#initialize' do
    it "with no cards argument provided, draws 5 cards from the deck" do
      expect(Hand.new(deck).cards.size).to eq(5)
    end

    it "when provided with an array of cards, has those cards" do
      expect(high_card_hand.cards).to eq([Card.new(:three, :spades),
                                     Card.new(:four, :clubs),
                                     Card.new(:six, :diamonds),
                                     Card.new(:eight, :spades),
                                     Card.new(:ten, :hearts)])
    end
  end

  describe '#beats?' do
    it "straight flush beats pair" do
      expect(straight_flush_hand.beats?(pair_hand)).to eq(true)
    end

    it "pair doesn't beat three of a kind" do
      expect(pair_hand.beats?(three_of_a_kind_hand)).to eq(false)
    end

    it "higher card value four-of-a-kind beats lower" do
      expect(four_of_a_kind_hand2.beats?(four_of_a_kind_hand)).to eq(false)
    end

    it "does the same for two-pair hands" do
      expect(two_pair_hand.beats?(two_pair_hand2)).to eq(true)
    end

  end

  describe '#discard_and_replace' do
    it "discards selected cards" do
      high_card_hand.discard_and_replace([2])
      expect(high_card_hand.cards.include?(Card.new(:six, :diamonds))).to be false
    end

    it "refills hand only if cards have been discarded" do
      high_card_hand.discard_and_replace([2])
      expect(high_card_hand.cards.size).to eq(5)
    end

    it "raises an error if the player wants to discard > 3 cards" do
      expect{ high_card_hand.discard_and_replace([0,1,2,3]) }.to raise_error
    end

    it "raises an error if provided indices not between 0, 4" do
      expect{ high_card_hand.discard_and_replace([-1]) }.to raise_error
    end
  end

  describe '#evaluate' do
    it "identifies a hand with just the high card" do
      expect(high_card_hand.evaluate).to eq(:high_card)
    end

    it "identifies a pair" do
      expect(pair_hand.evaluate).to eq(:pair)
    end

    it "identifies two pair" do
      expect(two_pair_hand.evaluate).to eq(:two_pair)
    end

    it "identifies a three of a kind" do
      expect(three_of_a_kind_hand.evaluate).to eq(:three_of_a_kind)
    end

    it "identifies a straight" do
      expect(straight_hand.evaluate).to eq(:straight)
    end

    it "identifies a flush" do
      expect(flush_hand.evaluate).to eq(:flush)
    end

    it "identifies a full house" do
      expect(full_house_hand.evaluate).to eq(:full_house)
    end

    it "identifies a four of a kind" do
      expect(four_of_a_kind_hand.evaluate).to eq(:four_of_a_kind)
    end

    it "identifies a straight flush" do
      expect(straight_flush_hand.evaluate).to eq(:straight_flush)
    end
  end
end
