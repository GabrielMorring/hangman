class Game
  def initialize(word = Dictionary.random_word)
    @word = word
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def play
    puts "You have 7 tries to guess the word"
    while @incorrect_guesses.length < 7
      remaining_tries = 7 - @incorrect_guesses.length
      puts "\nYou have #{remaining_tries} tries left"

      display_board(remaining_tries)

      player_turn

      if check_win
        display_win
        return
      end
    end
    display_loss
  end

  private

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
    puts "\nguess a letter"
    loop do
      letter = gets.chomp.downcase
      if valid_letter?(letter)
        if @word.include?(letter)
          @correct_guesses.push(letter)
        else
          @incorrect_guesses.push(letter)
        end
        return
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
