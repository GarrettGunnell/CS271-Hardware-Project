class SymbolTable
  @@SYMBOLS = {"SP" => 0, "LCL" => 1, "ARG" => 2, "THIS" => 3, "THAT" => 4, "R0" => 0, "R1" => 1, "R2" => 2, "R3" => 3, "R4" => 4, "R5" => 5, "R6" => 6, "R7" => 7, "R8" => 8,
   "R9" => 9, "R10" => 10, "R11" => 11, "R12" => 12, "R13" => 13, "R14" => 14, "R15" => 15, "SCREEN" => 16384, "KBD" => 24576}

  def initialize()
    @address = 16
  end

  def add_entry(symbol, address=@address)
    symbol = symbol.strip
    @@SYMBOLS[symbol] = address
    if address == @address
      @address += 1
    end
  end

  def contains(symbol)
    symbol = symbol.strip
    @@SYMBOLS.has_key?(symbol)
  end

  def get_address(symbol)
    symbol = symbol.strip
    @@SYMBOLS[symbol]
  end
end
