load "assembler_files/code.rb"
load "assembler_files/misc_functions.rb"
load "assembler_files/parser.rb"
load "assembler_files/symbol_table.rb"

class Assembler

  def initialize()
    @symbols = SymbolTable.new()
    @parser = Parser.new()
    @code = Code.new()
  end

  def assemble(input_file, output_file)
    write_file = File.open(output_file, 'w')
    runs = 0
    while runs < 2
      puts runs
      if runs == 0
        @parser.read_file(File.open(input_file, 'r'), @symbols)
      else
        @parser.parsed_file.each do |line|
          puts line
          @code.translate(@parser, @parser.command_type(line), line, @symbols, write_file)
        end
      end
    runs += 1
    end
  end
end
