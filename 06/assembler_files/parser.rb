# Takes a line and returns it as a string of binary numbers

class Parser
  @@COMP = {'0' => '0101010', '1' => '0111111', '-1' => '0111010', 'D' => '0001100', 'A' => '0110000', 'M' => '1110000', '!D' => '0001101', '!A' => '0110001', '!M' => '1110001', '-D' => '0001111', '-A' => '0110011', '-M' => '1110011', 'D+1' => '0011111', 'A+1' => '0110111', 'M+1' => '1110111', 'D-1' => '0001110', 'A-1' => '0110010', 'M-1' => '1110010', 'D+A' => '0000010', 'D+M' => '1000010', 'D-A' => '0010011', 'D-M' => '1010011', 'A-D' => '0000111', 'M-D' => '1000111', 'D&A' => '0000000', 'D&M' => '1000000', 'D|A' => '0010101', 'D|M' => '1010101'}
  @@DEST = {'M' => '001', 'D' => '010', 'MD' => '011', 'A' => '100', 'AM' => '101', 'AD' => '110', 'AMD' => '111'}
  @@JUMP = {'JGT' => '001', 'JEQ' => '010', 'JGE' => '011', 'JLT' => '100', 'JNE' => '101', 'JLE' => '110', 'JMP' => '111'}

  def initialize()
    @parsed_file = []
  end

  def parsed_file()
    @parsed_file
  end

  def command_type(line)
    line = line.strip
    if line[0] != '@' # If line starts with a @ it's an A-instruction
      'C'
    else
      'A'
    end
  end

  def dest(line)
    dest = line.split('=')[0] # Destinations are declared before the =
    begin
      dest = dest.strip
    rescue
    end
    if @@DEST.has_key?(dest)
      @@DEST[dest]
    else
      '000'
    end
  end

  def comp(line, jump)
    unless jump
      comp = String.try_convert(line.split('=')[1]) # If it's an assignment operation then computation happens after the =
    else
      comp = String.try_convert(line.split(';')[0]) # If it's a jump, what's being compared to 0 is declared before the ;
    end
    begin
      comp = comp.strip
    rescue
    end
    if @@COMP.has_key?(comp)
      @@COMP[comp]
    else
      '0000000'
    end
  end

  def jump(line)
    jump = String.try_convert(line.split(';')[1]) # Jump conditions are declared after the ;
    begin
      jump = jump.strip
    rescue
    end
    if @@JUMP.has_key?(jump)
      @@JUMP[jump]
    else
      '000'
    end
  end

  def read_file(file, symbols)
    current_line = 0 # Keeps track of current line for labels
    file.each do |line|
      skip_line = false
      new_line = ''
      jump = false
      line.split(//).each do |x|
        if x == '(' # If label, skip the line and add the label name to the symbol table with an address equal to the current line
          skip_line = true
          symbols.add_entry(line.gsub(/[()]/, ""), current_line)
          break
        elsif x == "/" # If comment, stop reading
          break
        end
        new_line += x # Builds a new string that doesn't have any potential in line comments
      end
      next if skip_line || new_line.strip.empty? # skip adding the new line to the parsed file if line is empty or is a label
      @parsed_file.push(new_line)
      current_line += 1
    end
  end
end
