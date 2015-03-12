class Hand
  HAND_LIMIT = 21
  attr_reader :name, :state, :total
  attr_accessor :cards

  def initialize(opponent="")
    @cards = []
    @total = 0
    @state = "play"
  end

  def test_bust?(total)
    total > HAND_LIMIT
  end

  def bust?
    if @total > HAND_LIMIT
      puts ">>>  #{name} BUSTS!!".red if @state != "lose"
      @state = "lose"
    else
      false
    end
  end

  def black_jack?
    if @total == HAND_LIMIT
      puts ">>> #{name} has BLACK JACK!".red if @state != "win"
      @state = "win"
    else
      false
    end
  end

  def bust_or_bj?
    bust? || black_jack?
  end

  def stand
    @state = "stand"
  end

  def show
    string = ""
    @cards.each do |card|
      string += " #{card.rank}#{card.suit},"
    end
    string.chomp(",")
    string += " total: #{@total}"
  end

  def update_total
    @total = 0
    @cards.sort_by! {|card| card.value } # count high-value Aces last
    @cards.each do |card|
      if card.is_ace? && test_bust?(@total + card.value)
        card.value = 1 # set ace back to 1
      end
      @total += card.value
    end
  end
end

class Player < Hand
  def initialize
    super
    @name = "Player"
  end

  def choice
    print "#{@name}, it's your turn... respond with 1=hit or 2=stand? [ 1:2 ]  "
    answer = ""
    possible_answers = [1, 2]
    while answer == ""
      answer = gets.chomp.to_i
      if !possible_answers.include?(answer)
        answer = ""
        puts "Sorry, could you please try that answer again?"
        puts "\tpossible choices are: 1=hit or 2=stand? [ 1:2 ]"
      end
    end
    (answer == 1) ? "hit" : stand
  end
end


class Dealer < Hand

  def initialize(opponent)
    super
    @opponent = opponent
    @name = "Dealer"
  end

  def choice
    if @opponent.state == "lose"
      "stand"
    elsif @total > @opponent.total
      return stand if @opponent.state == "stand"
      @total.between?(17, HAND_LIMIT - 1) ? stand : "hit"
    else
      "hit"
    end
  end

  def show_limited
    string = ""
    @cards.each_with_index do |card, index|
      if index == 0
        string += " #{card.rank}#{card.suit},"
      else
        string += " [card_face_down],"
      end
    end
    string.chomp(",")
  end
end
