class Code
  
  def translate(parser, instruction, line, symbol_table, file)
    if instruction == 'C'
      jump = false
      if line.include? ";"
        jump = true
      end
      translation = '111' + parser.comp(line, jump) + parser.dest(line) + parser.jump(line)
      file.puts translation.to_i
    else
      variable = line.strip
      if variable.split('@')[1].to_i.to_s == variable.split('@')[1]
        constant = variable.split('@')[1].to_i
        constant = constant.to_s(2).rjust(16, '0')
        file.puts constant
      else
        if symbol_table.contains(variable.split('@')[1])
          file.puts symbol_table.get_address(variable.split('@')[1]).to_s(2).rjust(16, '0')
        else
          symbol_table.add_entry(variable.split('@')[1])
          file.puts symbol_table.get_address(variable.split('@')[1]).to_s(2).rjust(16, '0')
        end
      end
    end
  end
end
