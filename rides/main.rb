require_relative 'parser'
require_relative 'sorted_optimize'
require_relative 'export'
require_relative 'preprocessing'

['a_example'].each do |dataset_name|
  data = Parser.new("video/datasets/#{dataset_name}.in")
  data.parse

  Preprocessing.new(data).preprocess
  RandomOptimizer.new(data).run

  Export.new(data.caches, dataset_name).generate_file
end
