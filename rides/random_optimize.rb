# require_relative 'score_hash'

class RandomOptimize
  def initialize(data)
    @data = data
    # @score_hash = ScoreHash.new(@data)
    @score_hash = {}
    @rides = []
  end

  def run
    @data.rides.each_with_index do |ride, index|
      vehicle = @data.vehicles[index%@data.num_vehicles]
      vehicle.rides.push(ride)
    end
  end
end
