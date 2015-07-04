require 'rspec'
require 'game'

describe Game do
  let(:test_game) { Game.new }

  describe '#initialize' do
    it "creates a deck" do
      expect(test_game).to respond_to(:deck)
    end

    it "creates players" do
      expect(test_game).to respond_to(:current_player)
    end
  end

  describe '#take_turn' do
  end

end
