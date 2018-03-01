require_relative 'parser'
require_relative 'sorted_optimize'
require_relative 'random_optimize'
require_relative 'export'
require_relative 'preprocessing'

['a_example', 'b_should_be_easy', 'c_no_hurry'].each do |dataset_name|
  data = Parser.new("rides/datasets/#{dataset_name}.in")
  data.parse

  Preprocessing.new(data).preprocess
  # RandomOptimize.new(data).run
  SortedOptimize.new(data).run

  Export.new(data.vehicles, dataset_name).generate_file
end