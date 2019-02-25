load "VirtualMachine/code_writer.rb"
load "VirtualMachine/parser.rb"

def args_valid?
  ARGV[0] && Dir.exist?(ARGV[0])
end

unless args_valid?
  abort('Directory does not exist')
end

def main()
  files = []
  Dir.foreach(ARGV[0]) do |file|
    if File.extname(file) == ".vm"
      files.append(ARGV[0] + '/' + file)
    end
  end
  parser = Parser.new(files, ARGV[0] + '/' + ARGV[0].split('/')[1] + '.asm')
  parser.parse()
end

main()
