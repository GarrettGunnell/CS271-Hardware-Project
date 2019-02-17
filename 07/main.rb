load "VirtualMachine/code_writer.rb"
load "VirtualMachine/parser.rb"

def args_valid?
  ARGV[0] && File.extname(ARGV[0]) == '.vm' && ARGV.size == 1
end

unless args_valid?
  abort('Wrong file!')
end

parser = Parser.new(ARGV[0])

parser.parse()
