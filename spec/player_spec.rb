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
end
