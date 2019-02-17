class CodeWriter
  @@segments = {'local' => 'LCL',
                'argument' => 'ARG',
                'this' => 'THIS',
                'that' => 'THAT',
                'temp' => 'R5',
                'static' => '???',
                'pointer' => '???'}

  def initialize(output_file)
    @output_file = File.open(output_file, 'w')
  end

  def write_arithmetic(command, current_line)
    if command == 'add'
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "A=A-1\n"\
      "M=M+D"\
    elsif command == 'sub'
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "A=A-1\n"\
      "M=M-D"\
    end
    @output_file.puts "//#{current_line}"
  end

  def write_push_pop(command_type, segment, index, current_line)
    segment_arg = @@segments[segment]

    if command_type == 'C_Push'
      if segment == 'constant'
        @output_file.puts "@#{index}\n"\
        "D=A\n"\
        "@SP\n"\
        "A=M\n"\
        "M=D\n"\
        "@SP\n"\
        "M=M+1"\
      else
        @output_file.puts "@#{index}\n"\
        "D=A\n"\
        "@#{segment_arg}\n"\
        "A=D+A\n"\
        "D=M\n"\
        "@SP\n"\
        "A=M\n"\
        "M=D\n"\
        "@SP\n"\
        "M=M+1"\
      end
    elsif command_type == 'C_Pop'
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "@R13\n"\
      "M=D\n"\
      "@#{index}\n"\
      "D=A\n"\
      "@#{segment_arg}\n"\
      "A=A+D\n"\
      "D=A\n"\
      "@R14\n"\
      "M=D\n"\
      "@R13\n"\
      "D=M\n"\
      "@R14\n"\
      "A=M\n"\
      "M=D"\
    end
    @output_file.puts "//#{current_line}"
  end

  def close()
    @output_file.puts "(END)\n"\
    "@END\n"\
    "0;JMP"
  end
end
