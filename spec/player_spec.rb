require 'rspec'
require 'player'


describe Player do

  let(:test_player) { Player.new }

  describe "#initialize" do
    it "is initialized with a hand" do
      expect(test_player).to respond_to(:hand)
    end

    it "is initialized with a pot" do
      expect(test_player).to respond_to(:pot)
    end
  end

  describe ""


end
