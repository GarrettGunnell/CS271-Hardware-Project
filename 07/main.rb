def args_valid?
  ARGV[0] && File.extname(ARGV[0]) == '.vm' && ARGV.size == 1
end

unless args_valid?
  abort('Wrong file!')
end

File.open(ARGV[0], 'r').each do |line|
  puts line
end