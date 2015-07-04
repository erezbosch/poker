require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck

  def initialize(num_players = 2)
    @deck = Deck.new
    @deck.shuffle!
    @players = Array.new(num_players) { Player.new(Hand.new(@deck), 100) }
    @active_players = @players.dup
    @pot = 0
    @bet = 10
  end

  def over?
    @players.map(&:pot).count(0) == @players.count - 1
  end

  def winner
    return false unless over?
    @players.find { |player| player.pot != 0 }
  end

  def play
    until over?
      play_round
      reset
    end

    puts "Player #{@players.index(winner)} wins!"
  end

  def play_round
    betting_round
    changing_round
    betting_round
    battle_round
  end

  def battle_round
    i = @active_players.size
    i.times do
      display_player(false, true)
      won_round = @active_players.drop(1).map(&:hand).all? do |hand|
        current_player.hand.beats?(hand)
      end
      if won_round
        puts "Player #{@players.index(current_player)} won #{@pot}!\n\n"
        current_player.pot += @pot
      end
      next_turn!
    end
  end

  def betting_round
    i = @active_players.size
    i.times do
      place_bet
      next_turn!
    end
  end

  def changing_round
    i = @active_players.size
    i.times do
      change_cards
      next_turn!
    end
  end

  def reset
    @players.map(&:hand).each { |hand| hand.return }
    @deck.shuffle!
    @players.each { |player| player.hand = Hand.new(@deck) }
    @active_players = @players.dup
    @bet = 10
    @pot = 0
    puts "*" * 25 + "\n\n"
  end

  def current_player
    @active_players.first
  end

  def next_turn!
    @active_players.rotate!
  end

  def place_bet
    display_player(false)

    if current_player.fold?
      @active_players.delete(current_player)
      return
    end

    current_player.pot -= @bet

    raise_amount = current_player.get_raise

    @bet += raise_amount

    @pot += @bet
    current_player.pot -= raise_amount
  end

  def display_player(change, battle = false)
    print "Player #{@players.index(current_player)}: "
    current_player.hand.cards.each { |card| print card.to_s.ljust(5) }


    if change
      print "\n" + (" " * 11)
      5.times { |num| print num.to_s.ljust(5) }
    elsif !battle
      print "\nYour Pot: #{current_player.pot}  Bet: #{@bet}  Pot: #{@pot}"
    else
      puts
    end
    puts
  end

  def change_cards
    display_player(true)
    current_player.discard
  end
end

Game.new.play if __FILE__ == $PROGRAM_NAME
