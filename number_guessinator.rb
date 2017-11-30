require 'colorize'

#Initialize hash of numbers from 1 to 100. 
#decimal contains the decimal representation while by binary contains the binary representation of each number.
def init_ary(ary)
  (1..100).each do |num|
    ary.push( { decimal: num, binary: num.to_s(2).rjust(7,"0")} )
  end
  ary
end

#Fill arrays with numbers that have a specified bit as either zero or one.
def fill_ary(ary, i)
  zeroary = []
  oneary = []
  ary.each do |number|
    if number[:binary][i] == "0"
      zeroary.push(number[:decimal])
    else 
      oneary.push(number[:decimal])
    end
  end
  [zeroary, oneary]
end

#Asks if the number is on the screen. Builds the mistery number
def question_and_answer(with_error, zero_or_one, mistery_num)
  message = "Do you see your number here: (y)(n). To exit the game enter the letter e.".colorize(:blue)
  if with_error == true
    puts "\nIncorrect Answer. " + message
  else 
    puts "\n#{message}"
  end 
  answer = gets.chomp.upcase
  case answer
    when "Y", "YES"
      if zero_or_one % 2 == 0
        mistery_num +="0"
      else
        mistery_num +="1"
      end
      return mistery_num
    when "N", "NO"
      if zero_or_one % 2 == 0
        mistery_num +="1"
      else
        mistery_num +="0"
      end
      return mistery_num
    when "E"
      return "break"
    else
      question_and_answer(true, zero_or_one, mistery_num)
  end 
end

#Plays the game.
def play()

  ary = []
  mistery_num = ""
  #answer = ""
  #zeroary = []
  #oneary = []
  #twoary = []

  init_ary(ary)

  6.downto(0) do |i|
    
    twoary = fill_ary(ary, i)
    
    zeroary = twoary[0]

    oneary = twoary[1]

    zero_or_one = rand(0..99).to_int
    if zero_or_one % 2 == 0
      puts
      p zeroary
    else
      puts
      p oneary
    end  
    
    answer = question_and_answer(false, zero_or_one, mistery_num)
    if answer == "break"
      return
    else 
      mistery_num = answer
      zeroary.clear
      oneary.clear
    end

  end

  mistery_num = mistery_num.reverse
  found = false
  i = 0
  while found == false
    if ary[i][:binary] == mistery_num
      puts "\nYour number is: #{ary[i][:decimal]}\n".colorize(:blue)
      found = true
    else
      i += 1
    end
  end 

  puts "Wanna play again? (Y) or (N).\n"
  answer = gets.chomp.upcase
  case answer_u
    when "Y", "YES" 
      puts
      puts "Fantastic! Lets play!!\n"
      play()
    when "N", "NO"
      puts "Goodbye!!" 
  else
    puts "Not Nice!!! Goodbye..."
  end

end

puts <<HEREDOC

Number Guessing

In this simple game, the ruby program does all the work. You only have to answer "Yes" or "No". This is how you play. 
Think of a positive integer between 1 and 100. At any time, the computer will display a set of numbers. 
In response, enter either "Yes" or "No" depending on whether your number is on the screen or not. 
After a while the computer will guess your number. See for yourself. 

HEREDOC

play()






