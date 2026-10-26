class Game
  def initialize(word = Dictionary.random_word, correct = [], incorrect = [])
    @word = word
    @correct_guesses = correct
    @incorrect_guesses = incorrect
  end

  def play
    puts "\nYou have 7 tries to guess the word"
    while @incorrect_guesses.length < 7
      remaining_tries = 7 - @incorrect_guesses.length
      puts "\nYou have #{remaining_tries} tries left"

      display_board(remaining_tries)

      return false if player_turn

      if check_win
        display_win
        return true
      end
    end
    display_loss
    true
  end

  def self.load_game(file)
    f = File.new("saves/#{file}")
    save_data = JSON.parse(f.gets.chomp)
    new(save_data["word"], save_data["correct_guesses"], save_data["incorrect_guesses"])
  end

  private

  def save_and_quit
    puts "Choose a name to save this game as:"
    name = gets.chomp.strip.downcase

    Dir.mkdir("saves") unless Dir.exist? "saves"

    json_obj = JSON.dump({
                           word: @word,
                           correct_guesses: @correct_guesses,
                           incorrect_guesses: @incorrect_guesses
                         })

    File.open("saves/#{name}.json", "w") { |file| file.puts json_obj }
  end

  def display_board(remaining_tries)
    if remaining_tries == 1
      puts "      ____________"
      puts "      |          |"
      puts "    /---\\        |"
      puts "   |     |       |"
      puts "    \\---/        |"
      puts "      |          |"
      puts "     \\|/         |"
      puts "      |          |"
      puts "     /           |"
      puts "                 |"

    end
    if remaining_tries == 2
      puts "      ____________"
      puts "      |          |"
      puts "    /---\\        |"
      puts "   |     |       |"
      puts "    \\---/        |"
      puts "      |          |"
      puts "     \\|/         |"
      puts "      |          |"
      puts "                 |"
      puts "                 |"
    end
    if remaining_tries == 3
      puts "      ____________"
      puts "      |          |"
      puts "    /---\\        |"
      puts "   |     |       |"
      puts "    \\---/        |"
      puts "      |          |"
      puts "     \\|          |"
      puts "      |          |"
      puts "                 |"
      puts "                 |"
    end
    if remaining_tries == 4
      puts "      ____________"
      puts "      |          |"
      puts "    /---\\        |"
      puts "   |     |       |"
      puts "    \\---/        |"
      puts "      |          |"
      puts "      |          |"
      puts "      |          |"
      puts "                 |"
      puts "                 |"
    end
    if remaining_tries == 5
      puts "      ____________"
      puts "      |          |"
      puts "    /---\\        |"
      puts "   |     |       |"
      puts "    \\---/        |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
    end
    if remaining_tries == 6
      puts "      ____________"
      puts "      |          |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
      puts "                 |"
    end

    display_word

    puts "\n#{@incorrect_guesses.join(' ')}"
  end

  def display_word
    puts ""
    @word.each_char do |letter|
      if @correct_guesses.include?(letter)
        print letter
      else
        print "_"
      end
    end
    puts ""
  end

  def player_turn
    puts "\nguess a letter or type \"save\" to save and quit"
    loop do
      letter = gets.chomp.downcase
      if letter == "save"
        save_and_quit
        return true
      end

      if valid_letter?(letter)
        if @word.include?(letter)
          @correct_guesses.push(letter)
        else
          @incorrect_guesses.push(letter)
        end
        return false
      end
      puts "Not a letter, try again."
    end
  end

  def valid_letter?(letter)
    return false unless letter.length == 1
    return false unless "abcdefghijklmnopqrstuvwxyz".include?(letter)

    true
  end

  def check_win
    @word.chars.all? { |char| @correct_guesses.include?(char) }
  end

  def display_win
    puts "\nCongratulations, You win!!"
    puts "#{@word.capitalize} is the word."
  end

  def display_loss
    puts "\n /-----\\"
    puts " | x x |"
    puts " \\-----/"

    puts "\nYou lost. He's dead."
    puts "The word was #{@word.capitalize}."
  end
end
