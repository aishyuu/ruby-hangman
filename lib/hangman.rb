require 'psych'
require 'yaml'

$fits = []
File.foreach("hangman_words.txt") do |line|
  fixed = line.chomp
  if fixed.length.between?(5, 12)
    $fits.push(fixed)
  end
end

def start
  puts File.read("./lib/ascii_text.txt")
  puts "Type 'start' to begin New Game"
  puts "Type 'continue' to Load Game"
  puts "Type 'exit' to Exit Game"

  usr_response = ""
  until usr_response == "start" || usr_response == "continue" || usr_response == "exit" do
    usr_response = gets.downcase.strip
  end

  if usr_response == "start"
    fresh = new_game_setup
    play_game(fresh)
  elsif usr_response == "continue"
    load_file
  elsif usr_response == "exit"
    exit
  end
end

def get_file_info(file_name)
  return YAML.load(File.read("./saves/#{file_name}"))
end

def new_game_setup
  prng = Random.new()
  index = prng.rand($fits.length)
  play_data = {info: {guesses:"", lives_left:6, word_progress:"_"*$fits[index].length, word_index:index}}
end

def load_file
  puts "\nType in the file name you wish to continue from\n\n"
  all_files = []
  Dir.new('./saves').each do |file|
    if file == "." || file == ".."
      next
    end
    current_file = file.gsub(".yaml", "")
    all_files.push(current_file)
    puts current_file
  end

  usr_response = ""
  until all_files.include?(usr_response)
    usr_response = gets.downcase.strip
  end

  play_data = get_file_info("#{usr_response}.yaml")
  play_game(play_data)
end

def play_game(data = {})
  puts data
  puts data["info"]
end

start
