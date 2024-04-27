class CustomersView
  def ask_user_for(element)
    puts "What is the #{element}?"
    return gets.chomp
  end

  def ask_user_for_number
    puts "Insert the index number"
    return gets.chomp.to_i - 1
  end

  def display(costumers)
    costumers.each_with_index do |costumer, index|
      puts "#{index + 1} - name: #{costumer.name}, adress: #{costumer.address}"
    end
  end
end
