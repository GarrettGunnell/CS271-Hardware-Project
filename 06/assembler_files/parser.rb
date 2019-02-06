class Parser
  @@file = nil

  def initialize(file)
    @@file = File.open(file)
  end

  def file()
    return @@file
  end

  def command_type(line)
    line = line.strip
    if line[0] != '@'
      return 'C'
    else
      return 'A'
    end
  end

  def symbol(line)
  end

  def dest(line)
    dest = line.split('=')[0]
    begin
      dest = dest.strip
    rescue
    end
    if dest == 'M'
      return '001'
    elsif dest == 'D'
      return '010'
    elsif dest == 'MD'
      return '011'
    elsif dest == 'A'
      return '100'
    elsif dest == 'AM'
      return '101'
    elsif dest == 'AD'
      return '110'
    elsif dest == 'AMD'
      return '111'
    else
      return '000'
    end
  end

  def comp(line, jump)
    unless jump
      comp = String.try_convert(line.split('=')[1])
    else
      comp = String.try_convert(line.split(';')[0])
    end
    begin
      comp = comp.strip
    rescue
    end
    if comp == '0'
      return '0101010'
    elsif comp == '1'
      return '0111111'
    elsif comp == '-1'
      return '0111010'
    elsif comp == 'D'
      return '0001100'
    elsif comp == 'A'
      return '0110000'
    elsif comp == 'M'
      return '1110000'
    elsif comp == '!D'
      return '0001101'
    elsif comp == '!A'
      return '0110001'
    elsif comp == '!M'
      return '1110001'
    elsif comp == '-D'
      return '0001111'
    elsif comp == '-A'
      return '0110011'
    elsif comp == '-M'
      return '1110011'
    elsif comp == 'D+1'
      return '0011111'
    elsif comp == 'A+1'
      return '0110111'
    elsif comp == 'M+1'
      return '1110111'
    elsif comp == 'D-1'
      return '0001110'
    elsif comp == 'A-1'
      return '0110010'
    elsif comp == 'M-1'
      return '1110010'
    elsif comp == 'D+A'
      return '0000010'
    elsif comp == 'D+M'
      return '1000010'
    elsif comp == 'D-A'
      return '0010011'
    elsif comp == 'D-M'
      return '1010011'
    elsif comp == 'A-D'
      return '0000111'
    elsif comp == 'M-D'
      return '1000111'
    elsif comp == 'D&A'
      return '0000000'
    elsif comp == 'D&M'
      return '1000000'
    elsif comp == 'D|A'
      return '0010101'
    elsif comp == 'D|M'
      return '1010101'
    else
      return '0000000'
    end
  end

  def jump(line)
    jump = String.try_convert(line.split(';')[1])
    begin
      jump = jump.strip
    rescue
    end
    if jump == 'JGT'
      return '001'
    elsif jump == 'JEQ'
      return '010'
    elsif jump == 'JGE'
      return '011'
    elsif jump == 'JLT'
      return '100'
    elsif jump == 'JNE'
      return '101'
    elsif jump == 'JLE'
      return '110'
    elsif jump == 'JMP'
      return '111'
    else
      return '000'
    end
  end
end
