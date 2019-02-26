load "VirtualMachine/code_writer.rb"

class Parser
  @@arithmetic = ['add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not']

  def initialize(stream, output)
    @input_files = stream
    @code_writer = CodeWriter.new(output)
  end

  def command_type(line) # Returns the type of vm command
    if @@arithmetic.include? "#{line}"
      'C_Arithmetic'
    elsif line == 'pop'
      'C_Pop'
    elsif line == 'push'
      'C_Push'
    elsif line == 'label'
      'L_Command'
    elsif line == 'goto'
      'GoTo_Command'
    elsif line == 'if-goto'
      'If_Command'
    elsif line == 'function'
      'Function_Command'
    elsif line == 'return'
      'Return'
    elsif line == 'call'
      'Call_Command'
    else
      abort('Invalid syntax')
    end
  end

  def arg1(line) # Returns the first argument of a push/pop command or returns arithmetic command
    command_type = command_type(line[0].strip)
    if command_type == 'C_Arithmetic'
      line[0]
    else
      line[1]
    end
  end

  def arg2(command) # Returns second argument of push/pop command
    command[2].strip
  end

  def parse()
    @input_files.each do |file|
      File.open(file, 'r').each do |line|
        skip_line = false
        new_line = ''
        line.split(//).each do |x|
          if x == "/" # If comment, stop reading
            break
          end
          new_line += x # Builds a new string that doesn't have any potential in line comments
        end
        next if skip_line || new_line.strip.empty?
        command = new_line.strip.split()
        command_type = command_type(command[0].strip)
        if command_type == 'C_Arithmetic'
          @code_writer.write_arithmetic(arg1(command), $.)
        elsif command_type == "C_Pop" || command_type == "C_Push"
          @code_writer.write_push_pop(command_type, arg1(command), arg2(command), $.)
        elsif command_type == "L_Command"
          @code_writer.write_label(arg1(command))
        elsif command_type == "GoTo_Command"
          @code_writer.write_goto(arg1(command))
        elsif command_type == "If_Command"
          @code_writer.write_if(arg1(command))
        elsif command_type == "Function_Command"
          @code_writer.write_function(arg1(command), arg2(command))
        elsif command_type == "Return"
          @code_writer.write_return()
        elsif command_type == "Call_Command"
          @code_writer.write_call(arg1(command), arg2(command))
        end
      end
    end
    @code_writer.close()
  end
end
