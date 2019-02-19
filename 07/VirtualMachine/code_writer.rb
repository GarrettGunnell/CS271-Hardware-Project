class CodeWriter
  @@segments = {'local' => 'LCL',
                'argument' => 'ARG',
                'this' => 'THIS',
                'that' => 'THAT',
                'temp' => 'R5',
                'static' => '16',
                'pointer' => '3'}

  @@equalities = {'eq' => 'D;JEQ',
                  'gt' => 'D;JGT',
                  'lt' => 'D;JLT'}

  def initialize(output_file)
    @output_file = File.open(output_file, 'w')
    @current_labels = 0
  end

  def write_arithmetic(command, current_line)
    if command == 'add'# X + Y
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "A=A-1\n"\
      "M=M+D"\
    elsif command == 'sub' # X - Y
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "A=A-1\n"\
      "M=M-D"\
    elsif @@equalities.has_key?(command) # Handles X>Y, X<Y, X == Y
      equality = @@equalities[command]
      label1 = "If_True" + @current_labels.to_s
      label2 = "Else" + @current_labels.to_s
      label3 = "End" + @current_labels.to_s
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "A=A-1\n"\
      "D=M-D\n"\
      "@#{label1}\n"\
      "#{equality}\n"\
      "@#{label2}\n"\
      "0;JMP\n"\
      "(#{label1})\n"\
      "@SP\n"\
      "A=M-1\n"\
      "M=-1\n"\
      "@#{label3}\n"\
      "0;JMP\n"\
      "(#{label2})\n"\
      "@SP\n"\
      "A=M-1\n"\
      "M=0\n"\
      "(#{label3})"
      @current_labels += 1
    elsif command == 'or' || command == 'and' # Handles X|Y and X&Y
      if command == 'or'
        operator = 'M|D'
      else
        operator = 'M&D'
      end
      @output_file.puts "@SP\n"\
      "AM=M-1\n"\
      "D=M\n"\
      "A=A-1\n"\
      "M=#{operator}"
    elsif command == 'not' #!Y
      @output_file.puts "@SP\n"\
      "A=M-1\n"\
      "M=!M"\
    elsif command == 'neg' #-Y
      @output_file.puts "@SP\n"\
      "A=M-1\n"\
      "M=-M"\
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
      elsif segment == 'pointer' || segment == 'static'
        @output_file.puts "@#{index}\n"\
        "D=A\n"\
        "@#{segment_arg}\n"\
        "A=A+D\n"\
        "D=M\n"\
        "@SP\n"\
        "A=M\n"\
        "M=D\n"\
        "@SP\n"\
        "M=M+1"\
      else
        @output_file.puts "@#{index}\n"\
        "D=A\n"\
        "@#{segment_arg}\n"\
        "A=M+D\n"\
        "D=M\n"\
        "@SP\n"\
        "A=M\n"\
        "M=D\n"\
        "@SP\n"\
        "M=M+1"\
      end
    elsif command_type == 'C_Pop'
      if segment == 'pointer' || segment == 'static'
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
      else
        @output_file.puts "@SP\n"\
        "AM=M-1\n"\
        "D=M\n"\
        "@R13\n"\
        "M=D\n"\
        "@#{index}\n"\
        "D=A\n"\
        "@#{segment_arg}\n"\
        "A=M+D\n"\
        "D=A\n"\
        "@R14\n"\
        "M=D\n"\
        "@R13\n"\
        "D=M\n"\
        "@R14\n"\
        "A=M\n"\
        "M=D"\
      end
    end
    @output_file.puts "//#{current_line}"
  end

  def close() # Puts infinite loop at end of asm file
    @output_file.puts "(END)\n"\
    "@END\n"\
    "0;JMP"
  end
end
