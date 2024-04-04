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
    load_file
  end
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

  puts "File chosen is #{usr_response}"
end

start
