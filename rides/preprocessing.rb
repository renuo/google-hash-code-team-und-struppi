class Preprocessing
  attr_reader :parser

  def initialize(parser)
    @parser = parser
  end

  def preprocess_rides
    @parser.rides.sort { |a,b | a.start<=>b.start}
  end

  def preprocess
    preprocess_rides
  end
end
