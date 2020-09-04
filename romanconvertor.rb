

def fromRoman(roman_number)
  # Replace the following line with the actual code!
  allowed_romans = Array.[]('I', 'V', 'X', 'L', 'C', 'D', 'M')
  subtractions = Array.[]('IV', 'IX', 'XL', 'CD', 'XC', 'CM')
  special_case = false
  puts 'fromRoman has input of ' + roman_number
  character_array = roman_number.chars

  puts 'character array is ' + character_array.inspect
  subtractions.each do |x|
    if roman_number.include? x
      special_case = true
      puts 'special case is ' + special_case.to_s
      puts 'this is a special case with ' + x
      subtractive_notation_case(character_array, roman_number, subtractions, allowed_romans)
      break
    end
  end

  if special_case == false
    non_subtractive_case(character_array, allowed_romans, 0)
  end
end

def non_subtractive_case(character_array, allowed_romans, additional)
  total = 0
  character_array.each do |char|
    if allowed_romans.include? char
      puts char + ' is in array'
      total += convert_roman_to_number(char)
    else
      puts char + ' is not in the array'
      raise TypeError
    end
  end
  total += additional
  puts total
  puts 'The Class of the return value is '
  puts total.class
  total
end

def subtractive_notation_case(character_array, roman_number, subtractions, allowed_romans)
  puts 'running subtractive case'
  puts character_array.inspect
  subtraction_cases = Array.[]

  subtractions.each do |x|
    if roman_number.include? x
      puts 'this is a special case with ' + x
      subtraction_cases.push(x)
      roman_number.slice! x
    end
  end
  character_array = roman_number.chars
  puts 'our cases are now ' + subtraction_cases.inspect
  puts 'our string is now ' + roman_number
  subtractive_total = 0

  #'IV', 'IX', 'XL', 'CD', 'XC', 'CM'
  subtraction_cases.each do |y|
    if y == 'IV'
      subtractive_total += 4
    elsif y == 'IX'
      subtractive_total += 9
    elsif y == 'XL'
      subtractive_total += 40
    elsif y == 'CD'
      subtractive_total += 400
    elsif y == 'XC'
      subtractive_total += 90
    elsif y == 'CM'
      subtractive_total += 900
    end
  end

  non_subtractive_case(character_array, allowed_romans, subtractive_total)

end

def convert_roman_to_number(roman_character)
  if roman_character == 'I'
    puts 'the character is I'
    value = 1
    return value
  elsif roman_character == 'V'
    puts 'the character is V'
    value = 5
    return value
  elsif roman_character == 'X'
    puts 'the character is X'
    value = 10
    return value
  elsif roman_character == 'L'
    puts 'the character is L'
    value = 50
    return value
  elsif roman_character == 'C'
    puts 'the character is C'
    value = 100
    return value
  elsif roman_character == 'D'
    puts 'the character is D'
    value = 500
    return value
  elsif roman_character == 'M'
    puts 'the character is M'
    value = 1000
    return value
  else
    abort("guess I'll just die")
  end
end

def toRoman(arabic_number)
  # Replace the following line with the actual code!
  puts 'toRoman has input of ' + arabic_number.to_s

  if arabic_number.negative? || arabic_number > 3999 || arabic_number.zero?
    puts 'Number is outside of range'
    raise RangeError
  else
    puts 'number is in range'
    convert_number_to_roman(arabic_number)
  end

end

def convert_number_to_roman(number)
  puts 'new function with input of ' + number.to_s
  if number < 5
    roman_string = ''
    number.times do
      roman_string += 'I'
    end

  elsif number == 5
    roman_string = 'V'

  elsif number == 10
    roman_string = 'X'

  elsif number == 50
    roman_string = 'L'

  elsif number == 100
    roman_string = 'C'

  elsif number == 500
    roman_string = 'D'

  elsif number == 1000
    roman_string = 'M'

  else
    roman_string = ''
    if (number - 1000).positive? || (number - 1000).zero?
      number = number - 1000
      next_roman = 'M'
      roman_string += next_roman
      puts 'adding M string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    until (number - 900).negative? || (number - 900).zero?
      number = number - 900
      next_roman = 'CM'
      roman_string += next_roman
      puts 'adding CM string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    until (number - 500).negative? || (number - 500).zero?
        number = number - 500
        next_roman = 'D'
        roman_string += next_roman
        puts 'adding D string is now ' + roman_string
        puts 'number is now ' + number.to_s
    end

    until (number - 400).negative? || (number - 400).zero?
      number = number - 400
      next_roman = 'CD'
      roman_string += next_roman
      puts 'adding CD string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    until (number - 100).negative? || (number - 100).zero?
        number = number - 100
        next_roman = 'C'
        roman_string += next_roman
        puts 'adding C string is now ' + roman_string
        puts 'number is now ' + number.to_s
    end

    until (number - 90).negative? || (number - 90).zero?
      number = number - 90
      next_roman = 'XC'
      roman_string += next_roman
      puts 'adding XC string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    until (number - 50).negative? || (number - 50).zero?
        number = number - 50
        next_roman = 'L'
        roman_string += next_roman
        puts 'adding L string is now ' + roman_string
        puts 'number is now ' + number.to_s
    end

    until (number - 40).negative? || (number - 40).zero?
      number = number - 40
      next_roman = 'XL'
      roman_string += next_roman
      puts 'adding XL string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    until (number - 10).negative? || (number - 10).zero?
        number = number - 10
        next_roman = 'X'
        roman_string += next_roman
        puts 'adding X string is now ' + roman_string
        puts 'number is now ' + number.to_s
    end

    until (number - 9).negative? || (number - 9).zero?
      number = number - 9
      next_roman = 'IX'
      roman_string += next_roman
      puts 'adding IX string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    until (number - 5).negative?
        number = number - 5
        next_roman = 'V'
        roman_string += next_roman
        puts 'adding V string is now ' + roman_string
        puts 'number is now ' + number.to_s
    end

    until (number - 4).negative? || (number - 4).zero?
      number = number - 4
      next_roman = 'IV'
      roman_string += next_roman
      puts 'adding IV string is now ' + roman_string
      puts 'number is now ' + number.to_s
    end

    puts number
    number.times do
      roman_string += 'I'
    end
    puts 'adding I string is now ' + roman_string



  end
  puts roman_string
  roman_string
end





# fromRoman('XV')
# fromRoman('VI')
# fromRoman('LXXVIII')
# fromRoman('CIII')
#         15 => "XV",
#         6 => "VI",
#         78 => "LXXVIII",
#         103 => "CIII"
# toRoman(1498)
fromRoman('MCDXCVIII')
