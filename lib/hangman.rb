fits = []
File.foreach("hangman_words.txt") do |line|
  fixed = line.chomp
  if fixed.length.between?(5, 12)
    fits.push(fixed)
  end
end

prng = Random.new()
index = prng.rand(fits.length)
puts fits[index]
