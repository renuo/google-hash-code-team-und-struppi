Coordinate = Struct.new(:x, :y)
Vehicle = Struct.new(:id, :rides, :location)
Ride = Struct.new(:id, :coordinate_start, :coordinate_end, :start, :finish, :distance)

class Parser
  attr_reader :num_rows, :num_columns, :num_vehicles, :num_rides, :num_bonus, :num_steps, :rides, :vehicles

  def initialize(path)
    @lines = File.readlines(path)
    @rides = []
    @vehicles = []
  end

  def parse
    parse_first_line
    parse_rides
    init_vehicles
  end

  def parse_rides
    @num_rides.times do |index|
      @rides.push(parse_ride(index, @lines.shift.strip.split(' ').map(&:to_i)))
    end
  end

  def parse_ride(id, params)
    ride = Ride.new(id, Coordinate.new(params[0], params[1]), Coordinate.new(params[2], params[3]), params[4], params[5])
    ride.distance = calculate_distance(ride)
    ride
  end

  def calculate_distance(ride)
    a = ride.coordinate_start.x
    b = ride.coordinate_start.y
    x = ride.coordinate_end.x
    y = ride.coordinate_end.y

    (a-x).abs+(b-y).abs
  end

  def parse_first_line
    line = @lines.shift.strip.split(' ').map(&:to_i)
    @num_rows, @num_columns, @num_vehicles, @num_rides, @num_bonus, @num_steps = line
  end

  private
  def init_vehicles
    @num_rides.times do |index|
      @vehicles.push(Vehicle.new(index + 1, [], Coordinate.new(0,0)))
    end
  end

end
