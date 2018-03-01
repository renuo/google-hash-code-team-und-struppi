class Preprocessing
  attr_reader :parser

  def initialize(parser)
    @parser = parser
  end

  def preprocess_rides
    @parser.rides.sort! { |a,b | [a.start, a.distance]<=>[b.start, b.distance]}
  end

  def preprocess
    preprocess_rides
  end
end
