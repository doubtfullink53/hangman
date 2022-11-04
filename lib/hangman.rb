require 'drawille'
require 'chunky_png'

include ChunkyPNG

class Main
  def initialize
    @number = 0
  end

  def secret_word
    words = File.read('google-10000-english-no-swears.txt').split
     @word = words.select { |w| w.size > 5 && w.size < 12 }.sample # secret word 
  end

  def draw_board
    canvas = Drawille::Canvas.new

    def draw(canvas, img, xoffset = 0)
      (0..img.dimension.width - 1).each do |x|
        (0..img.dimension.height - 1).each do |y|
          r = Color.r(img[x, y])
          g = Color.g(img[x, y])
          b = Color.b(img[x, y])
          canvas.set(x + xoffset, y) if (r + b + g) > 100
        end
      end
    end

    draw canvas, Image.from_file("./images/tile00#{@number}.png")

    puts canvas.frame
  end

  def guess
    puts 'Guess a letter.'
    @guess = STDIN.gets.chomp
    @guess_array += @guess.split
  end

  def valid_char
    if !@guess.match?(/[A-Za-z]/)
      puts 'Entered an invalid character'
      puts @hidden_word
      @number += 1
      draw_board
    elsif !@word.include?(@guess)
      puts "wrong letter"
      @number += 1
      draw_board
    else
      puts @hidden_word = @word.chars.map { |c| @guess_array.include?(c) ? c : ' _ ' }.join
    end
    guess_again
  end

  def end_of_game
    if @number == 6
      @number = 0
      puts 'You lost!'
      puts 'Do you want to play again YES (N) or NO (N)?'
      playagain = STDIN.gets.chomp

      if playagain.downcase == 'y' || playagain.downcase == 'yes'
        start
      else
        exit
      end
    end

    if @hidden_word == @word
      
      puts 'You Won!!!!'
      puts 'Do you want to play again YES (N) or NO (N)?'
      playagain = STDIN.gets.chomp

      if playagain.downcase == 'y' || playagain.downcase == 'yes'
        @number = 0
        start
      else
        exit
      end
    end
  end

  def guess_again
    # draw_board
    end_of_game
    guess
    valid_char
  end

  def start
    draw_board
    @guess_array = []
    @number_of_guesses = 0
    secret_word
    guess
    valid_char
  end
end

play = Main.new

play.start
