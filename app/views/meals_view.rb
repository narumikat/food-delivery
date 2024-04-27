class MealsView
  def ask_user_for(element)
    puts "What is the #{element}?"
    return gets.chomp
  end

  def ask_user_for_number
    puts "Insert the index number"
    return gets.chomp.to_i - 1
  end

  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} $#{meal.price}"
    end
  end
end
