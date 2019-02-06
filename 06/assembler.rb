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

File.open(input_file).each do |line|
  skip_line = false
  new_line = ''
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
  puts new_line
end
