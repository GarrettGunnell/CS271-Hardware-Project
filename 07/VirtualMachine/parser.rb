class Parser

  def initialize(stream)
    @input_file = File.open(stream, 'r')
  end

  def command_type()

  end

  def arg1()

  end

  def arg2()

  end

  def parse()
    @input_file.each do |line|
      next if line.strip[0] == '/' || line.strip.empty?
      line.split(" ").each do |command|
        puts command
      end
      puts "========="
    end
  end
end
