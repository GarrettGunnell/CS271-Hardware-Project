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

  def write_arithmetic()

  end

  def write_push_pop(command_type, segment, index)
    if command_type == 'C_Push'
      @output_file.puts "@#{index}\n"\
      "D=A\n"\
      "@SP\n"\
      "A=M\n"\
      "M=D\n"\
      "@SP\n"\
      "M=M+1"
    elsif command_type == 'C_Pop'
      @output_file.puts "@#{index}\n"\
      "D=A\n"\
      "@#{segment}\n"\
      "D=D+M\n"\
      "@R13\n"\
      "M=D\n"\
      "@SP\n"\
      "M=M-1\n"\
      "A=M\n"\
      "D=M\n"\
      "@R13\n"\
      "A=M\n"\
      "M=D"
    end
  end

  def close()
    @output_file.puts "(END)\n"\
    "0;JMP"
  end
end
