class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    puts "#{'-' * 10} Welcome to the restaurant #{'-' * 10}"
    while @running
      print_action
      action = gets.chomp.to_i
      puts "=" * 30
      dispatch(action)
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def print_action
    puts "\n"
    puts "#{'-' * 10} MEALS #{'-' * 10}"
    puts "1 - Add a new meal"
    puts "2 - List all the meals"
    puts "3 - Delete a meal"
    puts "4 - Edit a meal"

    puts "\n"

    puts "#{'-' * 10} CUSTOMERS #{'-' * 10}"
    puts "5 - Add a new customer"
    puts "6 - List all the customers"
    puts "7 - Delete a customer"
    puts "8 - Edit a customer"
    puts "\n"
    puts "9 - for Stop!"

    puts "\n"
    puts "Choose an option:"
  end

  def dispatch(action)
    case action
    when 1 then @meals_controller.add
    when 2
      puts "\n"
      puts "The Meals list is:"
      puts "\n"
      @meals_controller.list
      puts "\n"
    when 3
      puts "What meal do you want to delete?"
      puts "\n"
      @meals_controller.remove
      puts "Meal deleted!"
      puts "\n"
    when 4
      puts "What meal do you want do edit?"
      puts "\n"
      @meals_controller.edit
      puts "Meal updated successfully."

    when 5 then @customers_controller.add
    when 6
      puts "\n"
      puts "The Customers list is:"
      puts "\n"
      @customers_controller.list
      puts "\n"
    when 7
      puts "What customer do you want to delete?"
      puts "\n"
      @customers_controller.remove
      puts "Customer deleted!"
      puts "\n"
    when 8
      puts "What customer do you want do edit?"
      puts "\n"
      @customers_controller.edit
      puts "Customer updated successfully."

    when 9 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end

# rubocop:enable Metrics/MethodLength
