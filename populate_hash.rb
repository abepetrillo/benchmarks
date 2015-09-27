require 'benchmark'
require 'pry'

Foo = Struct.new(:rating)
arr = []
arr.push (0...999).map {|i| Foo.new(rating:  {client: 1})}
arr.push (0...999).map {|i| Foo.new(rating: {bad:1})}
arr.push (0...999).map {|i| Foo.new(rating: {ugly: 1})}
a = arr.flatten

puts Benchmark.bm  { |x|
  x.report('reduce') {
    a.reduce({}) do |hsh, o|
      hsh[:rating] = o.rating
    end
  }

  x.report('each_with_object') {
    a.each_with_object({}) do |o, hsh|
      hsh[:rating] = o.rating
    end
  }


}
