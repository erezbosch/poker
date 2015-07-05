require 'rspec'
require 'player'

describe Player do

  let(:test_player) { Player.new(:hand, :pot) }

  context "attributes" do
    it "has a hand" do
      expect(test_player.hand).to_not be_nil
    end

    it "has a pot" do
      expect(test_player).to_not be_nil
    end
  end

  describe '#pot=' do
    it "sets the player's pot value" do
      test_player.pot = 500
      expect(test_player.pot).to eq(500)
    end

    it "doesn't go below zero" do
      test_player.pot = -500
      expect(test_player.pot).to eq(0)
    end
  end
end
