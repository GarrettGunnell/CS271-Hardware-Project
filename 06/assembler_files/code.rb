# Takes the parsed assembly lines and translates them into integer machine instructions

class Code
  def translate(parser, instruction, line, symbol_table, file)
    if instruction == 'C'
      jump = false
      if line.include? ";" # If the line is a jump command then interpet C-Instruction as a jump command
        jump = true
      end
      translation = '111' + parser.comp(line, jump) + parser.dest(line) + parser.jump(line) # Combine all the bit instructions together
      file.puts translation.to_i
    else
      variable = line.strip # Strip any white space that would interfere with string interpretation
      if variable.split('@')[1].to_i.to_s == variable.split('@')[1] # If converting the string to an integer and back to a string equals the original string then it's not a variable and just a constant
        file.puts variable.split('@')[1].to_i.to_s(2).rjust(16, '0') # Take the numbers after the @, convert them to an integer, convert it to base 2 with a fixed number of 0's
      else
        if symbol_table.contains(variable.split('@')[1]) # If the variable already exists
          file.puts symbol_table.get_address(variable.split('@')[1]).to_s(2).rjust(16, '0')
        else
          symbol_table.add_entry(variable.split('@')[1]) # If the variable hasn't been used before
          file.puts symbol_table.get_address(variable.split('@')[1]).to_s(2).rjust(16, '0')
        end
      end
    end
  end
end
