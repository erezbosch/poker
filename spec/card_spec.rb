require 'rspec'
require 'card'

describe Card do

  let(:card) { Card.new(:three, :spades)}
  let(:card2) { Card.new(:three, :spades)}
  let(:card3) { Card.new(:four, :hearts)}


  describe "#initialize" do
    it "raises an error if an illegal suit or value was passed" do
      expect { Card.new(:eleven, :spades) }.to raise_error
    end

    it "requires two arguments" do
      expect { Card.new }.to raise_error(ArgumentError)
      # maybe ask how to check for multiple arguments?
    end

    it "initializes with a value" do
      expect(card.value).to eq(:three)
    end

    it "initializes with a value" do
      expect(card.suit).to eq(:spades)
    end
  end

  describe "::suits" do
    it "returns an array of all suits" do
      expect(Card.suits).to match_array([:spades, :hearts, :diamonds, :clubs])
    end
  end

  describe "::values" do
    let(:value_array) { [:deuce, :three, :four, :five, :six, :seven,
                         :eight, :nine, :ten, :jack, :queen, :king, :ace] }

    it "returns an array of all values" do
      expect(Card.values).to match_array(value_array)
    end
  end

  describe "#points" do
    it "has a numerical value attached" do
      expect(card.points).to eq(3)
    end
  end

end
