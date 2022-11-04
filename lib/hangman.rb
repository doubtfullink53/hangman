class Main
  def secret_word
    words = File.read('google-10000-english-no-swears.txt').split
    puts @word = words.select { |w| w.size > 5 && w.size < 12 }.sample
  end

  def draw_board
    puts '  --------'
    puts '  |      ' ' '
    puts '  |'
    puts '  |'
    puts '  |'
    puts '  |'
    puts '  |'
    puts '  |'
    puts '--------'
  end

  def guess
    puts 'Guess a letter.'
    #  @guessed_letters = gets.chomp
    @guess_array = Array.new
    @guess_array << gets.chomp
    p @guess_array
  end

  def valid_char
    if @guessed_letters == '' || @guessed_letters.nil? || !@guessed_letters.match?(/[A-Za-z]/)
      puts 'Entered an invalid character'
      guess_again

    else
      # @indexes = @word.chars.each_with_index.select { |x, _i| x == @letter }.map(&:last)

      # puts @hidden_word = @word.chars.map { |c| @guessed_letters.include?(c) ? c : ' _ ' }.join

      guess_again
    end
  end

  def guess_again
    draw_board
    guess
    valid_char
  end

  def start
    secret_word
    draw_board
    guess
    valid_char
  end
end

play = Main.new

play.start
