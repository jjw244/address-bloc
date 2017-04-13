ARGV.each do |arg|
  if arg == ARGV[0]
    next
  end
  puts "#{ARGV[0]} " + "#{arg}"
end
