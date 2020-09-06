

def fromRoman(roman_number)
  roman_dictionary = { 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000 }

  subtractions_dictionary = { 'IV' => 4, 'IX' => 9, 'XL' => 40, 'XC' => 90, 'CD' => 400, 'CM' => 900 }

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
  total_roman = String.new('')
  total_roman_array = roman_number.chars
  total_roman_array.each do |x|
    total_roman += x
  end
  return has_subtractions
end

def compute_subtractions(subtractions, dictionary)
  total = 0
  subtractions.each do |subtraction|
    total += dictionary.fetch(subtraction)
  end
  total
end

def compute_values(roman_number, subtractions_dictionary, roman_dictionary)
  total = 0
  subtractions = has_subtractions(roman_number, subtractions_dictionary)

  total_roman = String.new('')
  total_roman_array = roman_number.chars
  total_roman_array.each do |x|
    total_roman += x
  end

  subtractions.each do |subtraction|
    if total_roman.include? subtraction
      total_roman.slice!(subtraction)
    end
  end

  subtractions.each do |subtraction|
    total += subtractions_dictionary.fetch(subtraction)
  end

  total_roman.chars.each do |roman|
    total += roman_dictionary.fetch(roman)
  end
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
    to_roman_subtractions_check(input, roman_dictionary, subtractions_dictionary)
  end
end

def to_roman_subtractions_check(input, roman_dictionary, subtractions_dictionary)
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
  final_roman = ''
  subtraction_place_check = input.to_s.chars
  counter = 0
  subtraction_place_check.each do
    subtraction_place_check[counter] = subtraction_place_check[counter].to_i
    counter += 1
  end
  if subtraction_place_check.length.equal?(2)
    puts 'length is 2'
    final_roman = solve_subtractions_in_10(subtraction_place_check, roman_dictionary)

  elsif subtraction_place_check.length.equal?(3)
    puts 'length is 3'
    final_roman = solve_subtractions_in_100(subtraction_place_check, roman_dictionary)

  elsif subtraction_place_check.length.equal?(4)
    subtraction_place_check[0] = subtraction_place_check[0].to_s << '000'
    subtraction_place_check[0] = subtraction_place_check[0].to_i
    final_roman << solve_simple_roman(subtraction_place_check[0], roman_dictionary)
    subtraction_place_check.shift
    final_roman << solve_subtractions_in_100(subtraction_place_check, roman_dictionary)
  end

  final_roman #return final_roman
end

def solve_subtractions_in_100(subtraction_place_check, roman_dictionary)
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


original = 'MCDXCVIII'
x = fromRoman(original)
puts x
y = toRoman(x)
puts y
