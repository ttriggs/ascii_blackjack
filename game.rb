class Game
  def initialize
    @round  = 1
    @deck   = Deck.new
    @player = Player.new
    @dealer = Dealer.new(@player)
    deal_initial_cards
  end

  def deal_initial_cards
    2.times do
      @player.cards << @deck.deal_card
      @dealer.cards << @deck.deal_card
    end
  end

  def game_over?
    tie? || @dealer.bust_or_bj? || @player.bust_or_bj? || both_stand? ? true : false
  end

  def both_stand?
    @dealer.state == "stand" && @player.state == "stand"
  end

  def tie?
    @dealer.black_jack? && @player.black_jack? ? true : false
  end

  def player_wins?
    @dealer.bust? || @player.black_jack? || best_hand == @player
  end

  def dealer_wins?
    @player.bust? || @dealer.black_jack? || best_hand == @dealer
  end

  def best_hand
    dealer_diff = Hand::HAND_LIMIT - @dealer.total
    player_diff = Hand::HAND_LIMIT - @player.total
    if player_diff < dealer_diff && player_diff > 0
      @player
    elsif dealer_diff < player_diff && dealer_diff > 0
      @dealer
    end
  end

  def show_end
    if tie?
      puts "It's a Push! Both players have blackjack!"
    elsif player_wins? && !dealer_wins?
      puts "#{@player.name} wins!".green
    elsif dealer_wins? && !player_wins?
      puts "#{@dealer.name} wins!".green
    end
    # if dealer hits BJ in round one, show full hand:
    puts "Dealer had: #{@dealer.show}".yellow  if @round == 1
  end

  def show_status
    @player.update_total
    @dealer.update_total
    83.times { print "_" } # draw a line break
    puts
    puts "Round: #{@round}".green
    puts "Dealer has: #{@dealer.show_limited}".yellow  if @round == 1
    puts "Dealer has: #{@dealer.show}".yellow          if @round > 1
    puts "Player has: #{@player.show}".yellow
  end

  def take_turn(person)
    return puts ">> #{person.name} choses to STAND" if person.state == "stand"
    if person.choice == "hit"
      person.cards << @deck.deal_card
      puts ">> #{person.name} is dealt a card"
      sleep 1
    end
  end

  def play
    show_status
    until game_over?
      take_turn(@player)
      take_turn(@dealer) if !game_over?
      @round += 1
      show_status
      sleep 1
    end
    show_end
  end

end
