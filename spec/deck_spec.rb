require 'rspec'
require 'deck'

describe Deck do
  let(:test_deck) { Deck.new }
  let(:a_few_cards) { [1, 2, 3] }
  let(:small_deck) { Deck.new(a_few_cards) }

  describe "#initialize" do
    context "when called without arguments" do
      it "creates a 52-card deck" do
        expect(test_deck.all_cards.size).to eq(52)
      end

      it "creates a deck of 52 unique cards" do
        expect(test_deck.all_cards.uniq.size).to eq(52)
      end
    end

    context "when passed an array of cards" do
      it "stores those cards" do
        expect(small_deck.all_cards).to eq(a_few_cards)
      end
    end
  end

  describe "return" do
    it "raises an error unless the argument provided is an array" do
      expect { test_deck.return("hi") }.to raise_error
    end

    it "returns cards to the bottom of the deck" do
      test_deck.return(a_few_cards)
      expect(test_deck.all_cards[-a_few_cards.length .. -1]).to eq(a_few_cards)
    end
  end

  describe "#deal" do
    it "takes cards off the top of the deck" do
      expect(small_deck.deal(1)).to eq([1])
    end

    it "removes the dealt cards from the deck" do
      small_deck.deal(1)
      expect(small_deck.all_cards.size).to eq(2)
    end

    it "raises an error if asked to deal more cards than the deck contains" do
      expect{ small_deck.deal(5) }.to raise_error
    end
  end

  describe '#shuffle' do
    it "shuffles the deck" do
      cards = Deck.new.all_cards
      expect(test_deck.shuffle!.all_cards).to_not eq(cards)
    end
  end
end
