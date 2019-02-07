load "assembler_files/parser.rb"
load "assembler_files/symbol_table.rb"
load "assembler_files/misc_functions.rb"
load "assembler_files/code.rb"

input_file = take_input()
code = Code.new(input_file.split('.')[0] + '.hack')
symbols = SymbolTable.new()
runs = 0
current_line = 0

while runs < 2
  parser = Parser.new(input_file)
parser.file.each do |line|
  # TO DO: Basically uhhhh add new function in parser class that takes the line and puts it in member array, then in the second loop iterate through parser list
  skip_line = false
  new_line = ''
  jump = false
  line.split(//).each do |x|
    if x == '('
      skip_line = true
      if runs == 0
        symbols.add_entry(line.gsub(/[()]/, ""), (current_line))
      end
      break
    elsif x == "/"
      break
    end
    new_line += x
  end
  next if skip_line || new_line.strip.empty?
  if runs == 1
    code.translate(parser, parser.command_type(new_line), new_line, symbols)
  end
  current_line += 1
end
runs += 1
end
