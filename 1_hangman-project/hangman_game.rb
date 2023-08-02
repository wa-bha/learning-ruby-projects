require_relative 'words'

class HangmanGame
    UNDERSCORE = "_"

    def initialize
        @word = words.sample.upcase # Selecting a random word from the array of words
        @lives = 8
        @word_teaser = Array.new(@word.size, UNDERSCORE)
        @guessed_letters = []

        # Update the word_teaser with the last guess
        def update_word_teaser(last_guess)
            @word.each_char.with_index do |letter, index|
                if letter == last_guess
                    @word_teaser[index] = last_guess
                end
            end
        end

        # Check if the word has been found
        def check_word_match
            current_word_guess = @word_teaser.join

            if @word == current_word_guess
                puts
                puts "You won! 🎉🎉🎉 The word was #{@word}"
                exit
            end
        end

        # Returns a validated letter guess
        def get_validated_guess
            loop do
                puts
                puts "Enter a new letter to guess:"
                guess = gets.chomp.upcase

                # Validate user input is a single valid uppercase letter which has not already been guessed
                if guess.match?(/[A-Z]/) && guess.length == 1
                    if @guessed_letters.include?(guess)
                        puts "You've already guessed '#{guess}'. Please guess a new letter."
                        redo
                    else
                        @guessed_letters << guess
                        return guess
                    end
                else
                    puts "Invalid guess! Please enter a single valid uppercase letter."
                end
            end
        end

        # Checks if the guessed letter is correct and returns the appropriate message
        def handle_guess(last_guess)
            is_guess_correct = @word.include? last_guess

            if is_guess_correct
                puts "You guessed '#{last_guess}' correctly!"
            else
                @lives -= 1
                puts "You've guessed '#{last_guess}' incorrectly, you have #{@lives} lives left."
            end

            puts @word_teaser.join(" ")
        end
    end

    def start
        puts "A new game has started! You have #{@lives} lives."
        
        puts
        puts @word_teaser.join(" ")
        puts "Your word is #{@word.size} letters long."
        
        while @lives > 0
            guess = get_validated_guess
            update_word_teaser(guess)
            handle_guess(guess)
            check_word_match
        end
            
        puts
        puts "You've run out of lives, the word was #{@word}"
    end
end