

def fromRoman(roman_number)
  original = roman_number
  roman_dictionary = { 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000 }

  subtractions_dictionary = { 'IV' => 4, 'IX' => 9, 'XL' => 40, 'XC' => 90, 'CD' => 400, 'CM' => 900 }

  # puts 'input is ' + roman_number
  check_for_allowed(roman_number, roman_dictionary)
  compute_values(roman_number, subtractions_dictionary, roman_dictionary)



end

def check_for_allowed(input, dictonary)
  character_array = input.chars
  character_array.each do |char|
    unless dictonary.include? char
      raise TypeError
    end
  end
end

def has_subtractions(roman_number, subtractions_dictionary)
  duplicate = roman_number
  x = 0
  y = 1
  has_subtractions = %w[]
  until y == roman_number.length
    if subtractions_dictionary.include? roman_number[x] + roman_number[y]
      has_subtractions.push(roman_number[x]+roman_number[y])
      x += 1
      y += 1
    else
      x += 1
      y += 1
    end
  end
  #the problem is because this .slice code is screwing up the orignial somehow
  has_subtractions.each do |subtraction|
    puts has_subtractions.inspect
    if roman_number.include? subtraction
      roman_number.slice!(subtraction)
      puts 'roman number after slice ' + roman_number
    end
  end
  # puts 'string is now ' + roman_number
  puts 'the subtractions are ' + has_subtractions.inspect
  return compute_subtractions(has_subtractions, subtractions_dictionary)
end

def compute_subtractions(subtractions, dictionary)
  # puts 'computing subtractions'
  # puts subtractions.inspect
  total = 0
  subtractions.each do |subtraction|
    total += dictionary.fetch(subtraction)
  end
  # puts 'subtractions total is ' + total.to_s
  total
end

def compute_values(roman_number, subtractions_dictionary, roman_dictionary)
  total = 0
  # puts 'right before adding subtractions the array is ' + roman_number.to_s
  total += has_subtractions(roman_number, subtractions_dictionary)
  puts 'roman number during final compute is ' + roman_number
  roman_number.chars.each do |roman|
    total += roman_dictionary.fetch(roman)
  end
  # puts 'total is ' + total.to_s
  return total
end

def toRoman(arabic_number)
  roman_dictionary = { 1 => 'I', 5 => 'V', 10 => 'X', 50 => 'L', 100 => 'C', 500 => 'D', 1000 => 'M' }

  subtractions_dictionary = { 4 => 'IV', 9 => 'IX', 40 => 'XL', 90 => 'XC', 400 => 'CD', 900 => 'CM' }
  to_roman_check_range(arabic_number)
  compute_to_roman(arabic_number, roman_dictionary, subtractions_dictionary)
end

def to_roman_check_range(input)
  if input.negative? || input > 3999 || input.equal?(0)
    raise RangeError
  end
end

def compute_to_roman(input, roman_dictionary, subtractions_dictionary)
  if roman_dictionary.include? input
    puts 'already in dictionary '
    roman_dictionary.fetch(input)
  elsif subtractions_dictionary.include? input
    subtractions_dictionary.fetch(input)
  else
    # puts 'running the else case because it is a complex roman'
    to_roman_subtractions_check(input, roman_dictionary, subtractions_dictionary)
  end
end

def to_roman_subtractions_check(input, roman_dictionary, subtractions_dictionary)
  # puts 'Checking for subtraction cases'
  split_number_array = input.to_s.chars
  subtractions_case = false
  index = 0
  split_number_array.each do
    if split_number_array[index].to_i.equal?(4) || split_number_array[index].to_i.equal?(9)
      subtractions_case = true
    else
      index += 1
    end
  end

  if subtractions_case
    solve_subtractions_case(input, subtractions_dictionary, roman_dictionary)
  else
    solve_simple_roman(input, roman_dictionary)
  end
end

def solve_subtractions_case(input, subtractions_dictionary, roman_dictionary)
  # puts 'solving for subtractions case'
  final_roman = ''
  subtraction_place_check = input.to_s.chars
  counter = 0
  subtraction_place_check.each do
    subtraction_place_check[counter] = subtraction_place_check[counter].to_i
    counter += 1
  end
  # puts subtraction_place_check.inspect

  if subtraction_place_check.length.equal?(2)
    puts 'length is 2'
    final_roman = solve_subtractions_in_10(subtraction_place_check, roman_dictionary)

  elsif subtraction_place_check.length.equal?(3)
    puts 'length is 3'
    final_roman = solve_subtractions_in_100(subtraction_place_check, roman_dictionary)

  elsif subtraction_place_check.length.equal?(4)
    # puts 'length is 4'
    subtraction_place_check[0] = subtraction_place_check[0].to_s << '000'
    subtraction_place_check[0] = subtraction_place_check[0].to_i
    final_roman << solve_simple_roman(subtraction_place_check[0], roman_dictionary)
    subtraction_place_check.shift
    # puts subtraction_place_check.inspect
    final_roman << solve_subtractions_in_100(subtraction_place_check, roman_dictionary)
  end

  final_roman #return final_roman
end

def solve_subtractions_in_100(subtraction_place_check, roman_dictionary)
  # puts 'solving in 100 position'
  final_roman = ''
  if subtraction_place_check[0].equal?(4) || subtraction_place_check[0].equal?(9)
    if subtraction_place_check[0].equal?(4)
      final_roman << 'CD'
    else
      final_roman << 'CM'
    end
  else
    subtraction_place_check[0] = subtraction_place_check[0].to_s << '00'
    subtraction_place_check[0] = subtraction_place_check[0].to_i
    final_roman << solve_simple_roman(subtraction_place_check[0], roman_dictionary)
  end
  if subtraction_place_check[1].equal?(4) || subtraction_place_check[1].equal?(9)
    if subtraction_place_check[1].equal?(4)
      final_roman << 'XL'
    else
      final_roman << 'XC'
    end
  else
    subtraction_place_check[1] = subtraction_place_check[1].to_s << '0'
    subtraction_place_check[1] = subtraction_place_check[1].to_i
    final_roman << solve_simple_roman(subtraction_place_check[1], roman_dictionary)
  end
  if subtraction_place_check[2].equal?(4) || subtraction_place_check[2].equal?(9)
    if subtraction_place_check[2].equal?(4)
      final_roman << 'IV'
    else
      final_roman << 'IX'
    end
  else
    final_roman << solve_simple_roman(subtraction_place_check[2], roman_dictionary)
  end
  final_roman
end

def solve_subtractions_in_10(subtraction_place_check, roman_dictionary)
  final_roman = ''
  # puts 'solving in 10 position'
  if subtraction_place_check[0].equal?(4) || subtraction_place_check[0].equal?(9)
    if subtraction_place_check[0].equal?(4)
      final_roman << 'XL'
    else
      final_roman << 'XC'
    end
  else
    subtraction_place_check[0] = subtraction_place_check[0].to_s << '0'
    subtraction_place_check[0] = subtraction_place_check[0].to_i
    final_roman << solve_simple_roman(subtraction_place_check[0], roman_dictionary)
  end
  if subtraction_place_check[1].equal?(4) || subtraction_place_check[1].equal?(9)
    if subtraction_place_check[1].equal?(4)
      final_roman << 'IV'
    else
      final_roman << 'IX'
    end
  end
  final_roman
end

def solve_simple_roman(input, roman_dictionary)
  roman_string = ''
  solve_simple_maths(input, roman_dictionary, roman_string)
end

def solve_simple_maths(input, roman_dictionary, roman_string)
  if input >= 1000
    roman_string << roman_dictionary.fetch(1000)
    input -= 1000
  elsif input >= 500
    roman_string << roman_dictionary.fetch(500)
    input -= 500
  elsif input >= 100
    roman_string << roman_dictionary.fetch(100)
    input -= 100
  elsif input >= 50
    roman_string << roman_dictionary.fetch(50)
    input -= 50
  elsif input >= 10
    roman_string << roman_dictionary.fetch(10)
    input -= 10
  elsif input >= 5
    roman_string << roman_dictionary.fetch(5)
    input -= 5
  elsif input >= 1
    roman_string << roman_dictionary.fetch(1)
    input -= 1
  else
    puts 'something has gone horribly wrong'
  end
  unless input.equal?(0)
    solve_simple_maths(input, roman_dictionary, roman_string)
  end
  roman_string
end




# fromRoman('MCDXCVIII')
# fromRoman('III')

# x = toRoman(1999)
# puts x
# y = fromRoman(x)
# puts y
#
original = 'MCDXCVIII'
# original = 'IV'
puts 'original ' + original
x = fromRoman(original)
puts 'original ' + original
puts x
