require_relative '../spec_helper'
require_relative '../../rides/parser'

RSpec.describe Parser do
  context(:example_dataset) do
    let(:parser) do
      parser = Parser.new('rides/datasets/a_example.in')
      parser.parse
      parser
    end

    it 'parses the first line' do
      expect(parser.num_rows).to eq(3)
      expect(parser.num_columns).to eq(4)
      expect(parser.num_vehicles).to eq(2)
      expect(parser.num_rides).to eq(3)
      expect(parser.num_bonus).to eq(2)
      expect(parser.num_steps).to eq(10)
    end

    it 'parses the rides' do
      expect(parser.rides.length).to eq(3)
      expect(parser.rides[0].id).to eq(0)
      expect(parser.rides[1].id).to eq(1)
      expect(parser.rides[2].id).to eq(2)
      expect(parser.rides[0].coordinate_start.x).to eq(0)
      expect(parser.rides[0].coordinate_start.y).to eq(0)
      expect(parser.rides[0].coordinate_end.x).to eq(1)
      expect(parser.rides[0].start).to eq(2)
      expect(parser.rides[0].finish).to eq(9)
      expect(parser.rides[0].distance).to eq(4)
      expect(parser.rides[1].coordinate_start.x).to eq(1)
      expect(parser.rides[1].coordinate_start.y).to eq(2)
      expect(parser.rides[1].coordinate_end.x).to eq(1)
      expect(parser.rides[1].coordinate_end.y).to eq(0)
    end
  end
end
