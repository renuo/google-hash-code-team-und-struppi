require 'time'

class Export

  def initialize(vehicles, name = nil)
    @vehicles = vehicles
    # @vehicles.keep_if { |vehicle| !vehicle.rides.empty? }
    @name = name
  end

  def output
    output = []
    @vehicles.each do |vehicle|
      rides = vehicle.rides.map(&:id)
      output << [rides.length, *rides]
    end
    output
  end

  def generate_file
    Dir.mkdir('out') unless Dir.exists?('out')
    File.write("out/output_#{@name}.out", generate_export_data)
    # File.write("out/output_#{Time.now.iso8601}.out", generate_export_data)
  end

  def generate_export_data
    output.map { |line| line.join ' ' }.join("\n")
  end
end

