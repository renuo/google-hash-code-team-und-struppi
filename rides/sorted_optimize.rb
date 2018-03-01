require_relative 'score_hash'

class SortedOptimize
  def initialize(data)
    @data = data
    # @score_hash = ScoreHash.new(@data)
    @score_hash = {}
    @rides_to_do = data.rides.clone
  end

  def run

    @data.vehicles.each_with_index do |vehicle, index|
      tick = 0
      while(tick < @data.num_steps)
        ride = possible_rides(tick, vehicle).first
        break if ride.nil?
        tick = tick + total_duration(ride, vehicle)
        vehicle.location = ride.coordinate_end
        @rides_to_do.delete(ride)
      end
    end
  end

  private
  def possible_rides(tick, vehicle)
    @rides_to_do.clone.keep_if do |ride|
      is_able_to_start?(ride, tick) && is_able_to_reach(ride, tick, vehicle)
    end
  end

  def is_able_to_reach(ride, tick, vehicle)
    total_duration_to_destination = total_duration(ride, vehicle)
    tick + total_duration_to_destination <= ride.finish
  end

  def total_duration(ride, vehicle)
    vehicle_distance_to_ride_start = calculate_distance(vehicle.location, ride.coordinate_start)
    total_duration_to_destination = vehicle_distance_to_ride_start + ride.distance
  end

  def is_able_to_start?(ride, tick)
    ride.start <= tick
  end

  def calculate_distance(start, ende)

    a = start.x
    b = start.y
    x = ende.x
    y = ende.y

    (a-x).abs+(b-y).abs
  end
end
