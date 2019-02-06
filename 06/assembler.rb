class Parser
  @@file = nil

  def initialize(file)
    @@file = File.open(file)
  end

  def file()
    return @@file
  end

  def command_type(line)
    if line[0] != '@'
      return 'C'
    else
      return 'A'
    end
  end

  def symbol(line)
  end

  def dest(line)
    dest = line.split('=')[0]
    if dest == 'M'
      return '001'
    elsif dest == 'D'
      return '010'
    elsif dest == 'MD'
      return '011'
    elsif dest == 'A'
      return '100'
    elsif dest == 'AM'
      return '101'
    elsif dest == 'AD'
      return '110'
    elsif dest == 'AMD'
      return '111'
    else
      return '000'
    end
  end
end

print "What .asm file would you like to convert? (Please provide the path) "
input_file = gets.chomp

if File.exists?(input_file)
  unless File.extname(input_file) == ".asm"
    print "Your file is not an asm file\n"
    exit
  end
else
  print "I did not find the file.\n"
  exit
end

parser = Parser.new(input_file)

parser.file.each do |line|
  skip_line = false
  new_line = ''
  dest = '('
  line.split(//).each do |x|
    if x == '('
      skip_line = true
      break
    elsif x == "/"
      break
    end
    new_line += x
  end
  next if skip_line || new_line.strip.empty?
  puts parser.dest(line)
  # puts new_line
end
