class Deck
  RANKS = Array(2..10) + ["J","Q","K","A"]
  SUITS = ['♠', '♥', '♦', '♣']

  def initialize
    @deck = make_deck
  end

  def make_deck
    deck = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle!
  end

  def deal_card
    @deck.shift
  end
end
