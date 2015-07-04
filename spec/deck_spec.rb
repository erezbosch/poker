require 'rspec'
require 'deck'

describe Deck do
  let(:test_deck) { Deck.new }
  let(:a_few_cards) { [1, 2, 3] }
  let(:small_deck) { Deck.new(a_few_cards) }

  describe "#initialize" do
    context "when called without arguments" do
      it "creates a 52 card deck when called without arguments" do
        expect(test_deck.all_cards.size).to eq(52)
      end

      it "creates a unique 52-card deck" do
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
    it "takes cards off the deck" do
      expect(small_deck.deal(1)).to eq([1])
    end

    it "removes the dealt cards from the deck" do
      small_deck.deal(1)
      expect(small_deck.all_cards.size).to eq(2)
    end

    it "does not allow you to deal more cards than the deck has" do
      expect{ small_deck.deal(5) }.to raise_error
    end

  end

end
