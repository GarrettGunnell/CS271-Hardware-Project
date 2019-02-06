print "What .asm file would you like to convert? (Please provide the path) "
input_file = gets.chomp

if File.exists?(input_file)
  if File.extname(input_file) == ".asm"
    print "Your file is an .asm file\n"
  else
    print "Your file is not an asm file\n"
  end
else
  print "I did not find the file.\n"
  exit
end

File.open(input_file).each do |line|
  puts line
end
