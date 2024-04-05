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
  finished = false
  user_response = ""
  until finished == true
    puts "#{data[:info][:word_progress]}"
    puts "Lives Left: #{data[:info][:lives_left]}"
    until user_response.length == 1 || user_response == "save"
      user_response = gets.downcase.strip
    end
    if user_response == "save"
      num_files = 0
      Dir.new('./saves').each do |file|
        if file == "." || file == ".."
          next
        end
        num_files += 1
      end
      File.open("./saves/save_#{num_files+1}.yaml", "w") {|file| file.write(data.to_yaml)}
      puts "Game Saved under file 'save_#{num_files+1}'"
    elsif !data[:info][:guesses].include?(user_response)
      data[:info][:guesses] += user_response
      if $fits[data[:info][:word_index]].include?(user_response)
        $fits[data[:info][:word_index]].each_char.with_index do |letter, index|
          if letter == user_response
            data[:info][:word_progress][index] = user_response
          end
        end
      elsif
        data[:info][:lives_left] -= 1
        puts "errr! wrong"
        if data[:info][:lives_left] == 0
          puts "Game Over"
          finished = true
        end
      end
    else
      puts "You've guessed this before!"
    end
    user_response = ""
  end
end

start
