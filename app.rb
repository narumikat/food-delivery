# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb
require 'csv'

require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'


require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'

require_relative 'router'

meal_repository = MealRepository.new('data/meals.csv')
customer_repository = CustomerRepository.new('data/customers.csv')

meals_controller = MealsController.new(meal_repository)
customers_controller = CustomersController.new(customer_repository)

router = Router.new(meals_controller, customers_controller)

router.run
