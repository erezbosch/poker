require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck

  def initialize(num_players = 2)
    @deck = Deck.new.shuffle!
    @players = Array.new(num_players) { Player.new(Hand.new(@deck), 100) }
    @active_players = @players.dup
    @pot = 0
    @bet = 10
  end

  def play
    until over?
      play_round
      reset
    end

    puts "Player #{@players.index(winner)} wins!"
  end

  private

  def over?
    @players.map(&:pot).count(0) == @players.count - 1
  end

  def winner
    return false unless over?
    @players.find { |player| player.pot != 0 }
  end

  def play_round
    return if betting_round
    changing_round
    return if betting_round
    battle_round
  end

  def battle_round
    @active_players.size.times do
      display_player(:battle)
      won_round = @active_players.drop(1).map(&:hand).all? do |hand|
        current_player.hand.beats?(hand)
      end
      record_win if won_round
      next_turn!
    end
  end

  def betting_round
    @active_players.size.times do
      if last_bettor?
        fold_payout
        return true
      end
      next_turn! unless place_bet
    end
    false
  end

  def changing_round
    @active_players.size.times do
      change_cards
      next_turn!
    end
  end

  def change_cards
    display_player(:change)
    current_player.discard
  end

  def place_bet
    display_player

    if current_player.fold?
      @active_players.delete(current_player)
      return true
    end

    current_player.pot -= @bet

    raise_amount = current_player.get_raise

    @bet += raise_amount

    @pot += @bet
    current_player.pot -= raise_amount

    false
  end

  def last_bettor?
    @active_players.size == 1
  end

  def fold_payout
    display_player(:battle)
    print "Due to all other players folding, "
    record_win
  end

  def current_player
    @active_players.first
  end

  def next_turn!
    @active_players.rotate!
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

  def record_win
    puts "Player #{@players.index(current_player)} won #{@pot}!\n\n"
    current_player.pot += @pot
  end

  def display_player(situation = :bet)
    print "Player #{@players.index(current_player)}: "
    current_player.hand.cards.each { |card| print card.to_s.ljust(5) }


    if situation == :change
      print "\n" + (" " * 11)
      5.times { |num| print num.to_s.ljust(5) }
    elsif situation == :battle
      puts
    else
      print "\nYour Pot: #{current_player.pot}  Bet: #{@bet}  Pot: #{@pot}"
    end
    puts
  end
end

Game.new(3).play if __FILE__ == $PROGRAM_NAME
