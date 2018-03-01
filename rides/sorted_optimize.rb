require_relative 'score_hash'

class SortedOptimize
  def initialize(data)
    @data = data
    # @score_hash = ScoreHash.new(@data)
    @score_hash = {}
    @rides_to_do = data.rides.clone
  end

  def run
    vehicle_ticks = []
    @data.num_vehicles.times do |index|
      puts index
      vehicle_ticks[index] = 0
    end

    while (there_are_vehicles_with_ticks(vehicle_ticks))
      @data.vehicles.each_with_index do |vehicle, index|
        puts index
        next if vehicle_ticks[vehicle.id] > @data.num_steps
        puts "its the turn of #{vehicle.id}"
        possible_rides = possible_rides(vehicle_ticks[index], vehicle)
        ride = sort_by_distance(possible_rides).first
        if ride.nil?
          puts 'noo ride'
          vehicle_ticks[index] = vehicle_ticks[index] + 100
        else
          puts 'ridee!'
          vehicle_ticks[index] = vehicle_ticks[index] + total_duration(ride, vehicle)
          vehicle.location = ride.coordinate_end
          vehicle.rides.push(ride)
          @rides_to_do.delete(ride)
        end
      end

    end

  end

  private
  def there_are_vehicles_with_ticks(vehicle_ticks)
    return false if @rides_to_do.empty?
    !vehicle_ticks.clone.keep_if do |tick|
      tick < @data.num_steps
    end.empty?
  end

  def possible_rides(tick, vehicle)
    @rides_to_do.clone.keep_if do |ride|
      is_able_to_reach(ride, tick, vehicle)
    end
  end

  def is_able_to_reach(ride, tick, vehicle)
    total_duration_to_destination = total_duration(ride, vehicle)
    tick + total_duration_to_destination <= ride.finish
  end

  def total_duration(ride, vehicle)
    vehicle_distance_to_ride_start = distance_to_the_start(ride, vehicle)
    total_duration_to_destination = vehicle_distance_to_ride_start + ride.distance
  end

  def distance_to_the_start(ride, vehicle)
    vehicle_distance_to_ride_start = calculate_distance(vehicle.location, ride.coordinate_start)
  end

  def is_able_to_start?(ride, tick, vehicle)
    ride.start <= tick + distance_to_the_start(ride, vehicle)
  end

  def calculate_distance(start, ende)

    a = start.x
    b = start.y
    x = ende.x
    y = ende.y

    (a - x).abs + (b - y).abs
  end

  def find_by_position(position)

  end

  def sort_by_distance(rides)
    rides.sort! {|a, b| a.distance <=> b.distance}
  end
end
