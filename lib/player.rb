require_relative 'hand'

class Player
  attr_reader :hand, :pot

  def initialize hand, pot
    @hand = hand
    @pot = pot
  end

  def discard
    puts "Enter the cards you'd like to discard separated by commas, "
    puts "or just press return to discard nothing."
    discards = gets.chomp.split(",").map(&:to_i)
    @hand.discard_and_replace(discards)
  rescue RuntimeError => e
    puts e.message + "!"
    retry
  end

  def fold?
    puts "Fold? (y/n) "
    gets.chomp.downcase == "y"
  end

  def get_raise
    puts "Would you like to raise? (y/n)"
    return 0 if gets.chomp.downcase == "n"
    puts "How much?"
    [pot, gets.to_i.abs].min
  end
end
