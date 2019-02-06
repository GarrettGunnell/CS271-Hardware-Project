load "assembler_files/parser.rb"
load "assembler_files/symbol_table.rb"
load "assembler_files/misc_functions.rb"
load "assembler_files/code.rb"

input_file = take_input()

parser = Parser.new(input_file)
code = Code.new("assemble.hack")
symbols = SymbolTable.new
runs = 0
first_run = true
current_line = 0

while runs < 2
parser.file.each do |line|
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
parser = Parser.new(input_file)
end


=begin
while runs < 2
parser.file.each do |line|
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
    if parser.command_type(new_line) == 'C'
      if new_line.include? ";"
        jump = true
      end
      writer.puts 111.to_s + parser.comp(new_line, jump) + parser.dest(new_line) + parser.jump(new_line)
    else
      variable = new_line.strip
      if variable.split('@')[1].to_i.to_s == variable.split('@')[1]
        constant = variable.split('@')[1].to_i
        constant = constant.to_s(2).rjust(16, '0')
        writer.puts constant
      else
        if symbols.contains(variable.split('@')[1])
          writer.puts symbols.get_address(variable.split('@')[1]).to_s(2).rjust(16, '0')
        else
          symbols.add_entry(variable.split('@')[1])
          writer.puts symbols.get_address(variable.split('@')[1]).to_s(2).rjust(16, '0')
        end
      end
    end
  end
  current_line += 1
end
runs += 1
parser = Parser.new(input_file)
end
=end
