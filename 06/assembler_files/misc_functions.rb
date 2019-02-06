def take_input()
  print "What .asm file would you like to convert? (Please provide the path) "
  input_file = gets.chomp

  if File.exists?(input_file)
    unless File.extname(input_file) == ".asm"
      print "Your file is not an asm file\n"
      exit
    end
    return input_file
  else
    print "I did not find the file.\n"
    exit
  end
end
