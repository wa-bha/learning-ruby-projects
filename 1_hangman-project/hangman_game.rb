require_relative 'words'

class HangmanGame
    def initialize
        @word = words.sample.upcase # Selecting a random word from the array of words
        @lives = 8;
        @word_teaser = ""

        # Fill the word_teaser with underscores
        @word.size.times do 
            @word_teaser += "_ "
        end
    end

    # Update the word_teaser with the last guess
    def update_word_teaser last_guess
        new_teaser = @word_teaser.split

        new_teaser.each_with_index do |letter, index|
            if letter == "_" && @word[index] == last_guess
                new_teaser[index] = last_guess
            end
        end
        @word_teaser = new_teaser.join(" ")
    end

    # Check if the word has been found
    def check_word_match
        current_word_guess = @word_teaser.split.join

        if @word == current_word_guess
            puts
            puts "You won! 🎉🎉🎉 The word was #{@word}"
            exit
        end
    end

    # Returns a validated letter guess
    def get_validated_guess
        puts
        puts "Enter a new letter to guess:"
        guess = gets.chomp.upcase

        # Validate user input is a single valid letter
        unless guess.match?(/[A-Za-z]/) && guess.length == 1
            puts "Invalid guess! Please enter a single valid letter."
            get_guess
        end

        guess
    end

    # Checks if the guessed letter is correct and returns the appropriate message
    def handle_guess last_guess 
        is_guess_correct = @word.include? last_guess

        if is_guess_correct
            puts "You guessed '#{last_guess}' correctly!"
        else
            @lives -= 1
            puts "You've guessed '#{last_guess}' incorrectly, you have #{@lives} lives left."
        end

        puts @word_teaser
    end

    def start
        puts "A new game has started! You have #{@lives} lives."
        
        puts
        puts @word_teaser
        puts "Your word is #{@word.size} letters long."
        
        while @lives > 0
            guess = get_validated_guess
            update_word_teaser(guess)
            check_word_match
            handle_guess(guess)        
        end
            
        puts
        puts "You've run out of lives, the word was #{@word}"
    end
end