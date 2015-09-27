require 'benchmark'
require 'pry'
require 'ruby-prof'
RubyProf.measure_mode = RubyProf::MEMORY
#RubyProf.measure_mode = RubyProf::CPU_TIME

Foo = Struct.new(:rating)
arr = []
arr.push (0...99999).map {|i| Foo.new(rating:  {client: 1})}
arr.push (0...99999).map {|i| Foo.new(rating: {bad:1})}
arr.push (0...99999).map {|i| Foo.new(rating: {ugly: 1})}
a = arr.flatten

result2 = RubyProf.profile do
  a.each_with_object({}) do |o, hsh|
    hsh[:rating] = o.rating
  end
end

result = RubyProf.profile do
  a.reduce({}) do |hsh, o|
    hsh[:rating] = o.rating
  end
end



printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT, {})

printer = RubyProf::FlatPrinter.new(result2)
printer.print(STDOUT, {})
