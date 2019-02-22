load "VirtualMachine/code_writer.rb"

class Parser
  @@arithmetic = ['add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not']

  def initialize(stream, output)
    @input_file = File.open(stream, 'r')
    @code_writer = CodeWriter.new(output)
  end

  def command_type(line) # Returns the type of vm command
    if @@arithmetic.include? "#{line}"
      'C_Arithmetic'
    elsif line == 'pop'
      'C_Pop'
    elsif line == 'push'
      'C_Push'
    else
      abort('Invalid syntax')
    end
  end

  def arg1(line) # Returns the first argument of a push/pop command or returns arithmetic command
    command_type = command_type(line[0].strip)
    if command_type == 'C_Arithmetic'
      line[0]
    elsif command_type == "C_Pop" || command_type == "C_Push"
      line[1]
    else
      abort ('Yikes!')
    end
  end

  def arg2(command) # Returns second argument of push/pop command
    command[2].strip
  end

  def parse()
    @input_file.each do |line|
      next if line.strip[0] == '/' || line.strip.empty?
      command = line.split()
      command_type = command_type(command[0].strip)
      if command_type == 'C_Arithmetic'
        @code_writer.write_arithmetic(arg1(command), $.)
      elsif command_type == "C_Pop" || command_type == "C_Push"
        @code_writer.write_push_pop(command_type, arg1(command), arg2(command), $.)
      end
    end
    @code_writer.close()
  end
end
