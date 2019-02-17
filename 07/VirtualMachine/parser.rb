class Parser
  @@arithmetic = ['add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not']
  @@memory = ['argument', 'local', 'static', 'constant', 'this', 'that', 'pointer', 'temp']

  def initialize(stream)
    @input_file = File.open(stream, 'r')
  end

  def command_type(line)
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

  def arg1(line)
    command_type = command_type(line[0].strip)
    if command_type == 'C_Arithmetic'
      return line[0]
    elsif command_type == "C_Pop" || command_type == "C_Push"
      return line[1]
    else
      abort ('Yikes!')
    end
  end

  def arg2()

  end

  def parse()
    @input_file.each do |line|
      next if line.strip[0] == '/' || line.strip.empty?
      command = line.split()
      puts command_type(command[0])
      puts arg1(command)
      puts "#{$.} ========="
    end
  end
end
