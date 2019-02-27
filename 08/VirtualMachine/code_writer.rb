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
    @current_calls = 0
    @current_function = ''
  end

  def write_arithmetic(command, current_line)
    @output_file.puts "//#{current_line}" + ' ' + command

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
    @output_file.puts "//"
  end

  def write_push_pop(command_type, segment, index, current_line)
    segment_arg = @@segments[segment]

    @output_file.puts "//#{current_line}" + ' ' + command_type

    if command_type == 'C_Push'
      if segment == 'constant'
        @output_file.puts "@#{index}\n"\
        "D=A\n"\
        "@SP\n"\
        "A=M\n"\
        "M=D\n"\
        "@SP\n"\
        "M=M+1"\
      elsif segment == 'pointer' || segment == 'static' || segment == 'temp'
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
      if segment == 'pointer' || segment == 'static' || segment == 'temp'
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
    @output_file.puts "//"
  end

  def write_label(label_name, current_line)
    function_label = @current_function + '$' + label_name

    @output_file.puts "//#{current_line}" + ' label'

    @output_file.puts "(#{function_label})"

    @output_file.puts "//"
  end

  def write_goto(label_name, current_line)
    function_label = @current_function + '$' + label_name
    @output_file.puts "//#{current_line}" + ' goto'

    @output_file.puts "@#{function_label}\n"\
    "0;JMP"

    @output_file.puts "//"
  end

  def write_if(label_name, current_line)
    function_label = @current_function + '$' + label_name

    @output_file.puts "//#{current_line}" + ' if goto'

    @output_file.puts "@SP\n"\
    "AM=M-1\n"\
    "D=M\n"\
    "@#{function_label}\n"\
    "D;JNE\n"

    @output_file.puts "//"
  end

  def write_function(function_name, num_locals, current_line)
    @output_file.puts "//#{current_line}" + ' write function'

    @output_file.puts "(#{function_name})"
    for i in 0...num_locals.to_i
      @output_file.puts "@SP\n"\
      "A=M\n"\
      "M=0\n"\
      "@SP\n"\
      "M=M+1"
    end

    @current_function = function_name

    @output_file.puts "//"
  end

  def write_call(function_name, num_args, current_line)
    call_label = 'CALL' + @current_calls.to_s

    @output_file.puts "//#{current_line}" + ' write call'

    @output_file.puts "@#{call_label}\n"\
    "D=A\n"\
    "@SP\n"\
    "A=M\n"\
    "M=D\n"\
    "@SP\n"\
    "M=M+1\n"\
    "@LCL\n"\
    "D=M\n"\
    "@SP\n"\
    "A=M\n"\
    "M=D\n"\
    "@SP\n"\
    "M=M+1\n"\
    "@ARG\n"\
    "D=M\n"\
    "@SP\n"\
    "A=M\n"\
    "M=D\n"\
    "@SP\n"\
    "M=M+1\n"\
    "@THIS\n"\
    "D=M\n"\
    "@SP\n"\
    "A=M\n"\
    "M=D\n"\
    "@SP\n"\
    "M=M+1\n"\
    "@THAT\n"\
    "D=M\n"\
    "@SP\n"\
    "A=M\n"\
    "M=D\n"\
    "@SP\n"\
    "M=M+1\n"\
    "@SP\n"\
    "D=M\n"\
    "@#{num_args}\n"\
    "D=D-A\n"\
    "@5\n"\
    "D=D-A\n"\
    "@ARG\n"\
    "M=D\n"\
    "@SP\n"\
    "D=M\n"\
    "@LCL\n"\
    "M=D\n"\
    "@#{function_name}\n"\
    "0;JMP\n"\
    "(#{call_label})\n"

    @output_file.puts "//"

    @current_calls += 1
  end

  def write_return(current_line)
    @output_file.puts "//#{current_line}" + ' write return'

    @output_file.puts "@LCL\n"\
    "D=M\n"\
    "@R13\n"\
    "M=D\n"\
    "@5\n"\
    "A=D-A\n"\
    "D=M\n"\
    "@R14\n"\
    "M=D\n"\
    "@SP\n"\
    "A=M-1\n"\
    "D=M\n"\
    "@ARG\n"\
    "A=M\n"\
    "M=D\n"\
    "@ARG\n"\
    "D=M\n"\
    "@SP\n"\
    "M=D+1\n"\
    "@R13\n"\
    "D=M\n"\
    "A=D-1\n"\
    "D=M\n"\
    "@THAT\n"\
    "M=D\n"\
    "@R13\n"\
    "D=M\n"\
    "@2\n"\
    "A=D-A\n"\
    "D=M\n"\
    "@THIS\n"\
    "M=D\n"\
    "@R13\n"\
    "D=M\n"\
    "@3\n"\
    "A=D-A\n"\
    "D=M\n"\
    "@ARG\n"\
    "M=D\n"\
    "@R13\n"\
    "D=M\n"\
    "@4\n"\
    "A=D-A\n"\
    "D=M\n"\
    "@LCL\n"\
    "M=D\n"\
    "@R14\n"\
    "A=M\n"\
    "0;JMP"

    @output_file.puts "//"
  end

  def close() # Puts infinite loop at end of asm file
    @output_file.puts "(END)\n"\
    "@END\n"\
    "0;JMP"
  end
end
