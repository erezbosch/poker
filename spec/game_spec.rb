require 'rspec'
require 'game'

describe Game do
  let(:test_game) { Game.new }

  describe '#initialize' do
    it "creates a deck" do
      expect(test_game).to respond_to(:deck)
    end
  end
end
