load "assembler_files/code.rb"
load "assembler_files/parser.rb"
load "assembler_files/symbol_table.rb"

# Takes an assembly input file and converts it to machine instructions by writing to an output file

class Assembler
  def initialize() # The assembler is composed of 3 modules, a symbol table, a parser, and a code module
    @symbols = SymbolTable.new()
    @parser = Parser.new()
    @code = Code.new()
  end

  def assemble(input_file, output_file)
    write_file = File.open(output_file, 'w')
    runs = 0
    while runs < 2
      if runs == 0
        @parser.read_file(File.open(input_file, 'r'), @symbols)
      else
        @parser.parsed_file.each do |line|
          @code.translate(@parser, @parser.command_type(line), line, @symbols, write_file)
        end
      end
    runs += 1
    end
  end
end
