class Card
  attr_reader :rank, :suit
  attr_accessor :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    if @rank == "A"
      @value = 11
    elsif @rank.is_a? String
      @value = 10
    else
      @value = rank
    end
  end

  def is_face?
    @rank.is_a? String
  end

  def is_ace?
    @rank == "A"
  end
end
