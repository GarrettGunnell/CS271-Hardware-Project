load "assembler_files/parser.rb"
load "assembler_files/symbol_table.rb"
load "assembler_files/misc_functions.rb"
load "assembler_files/code.rb"

input_file = take_input()
code = Code.new(input_file.split('.')[0] + '.hack')
symbols = SymbolTable.new()
runs = 0
current_line = 0
parser = Parser.new(input_file)
write_file = File.open(input_file.split('.')[0] + '.hack', 'w')

while runs < 2
  # TO DO: Basically uhhhh add new function in parser class that takes the line and puts it in member array, then in the second loop iterate through parser list
  if runs == 0
    parser.read_file(symbols)
  else
    parser.parsed_file.each do |line|
      code.translate(parser, parser.command_type(line), line, symbols, write_file)
    end
  end
runs += 1
end
