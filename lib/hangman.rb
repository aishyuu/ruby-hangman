require 'psych'

def start
  puts File.read("./lib/ascii_text.txt")
  puts "Type 'start' to begin New Game"
  puts "Type 'continue' to Load Game"

  usr_response = ""
  until usr_response == "start" || usr_response == "continue" do
    usr_response = gets.downcase.strip
  end

  if usr_response == "start"
    puts "Starting game..."
  elsif usr_response == "continue"
    puts "Loading Save Files..."
  end
end

# fits = []
# File.foreach("hangman_words.txt") do |line|
#   fixed = line.chomp
#   if fixed.length.between?(5, 12)
#     fits.push(fixed)
#   end
# end

# test = Psych.load_file("./saves/save_1.yaml")
# puts test["data"]["guesses"]

# puts File.read("./lib/ascii_text.txt")

start
