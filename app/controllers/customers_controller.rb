require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def add
    name = @customers_view.ask_user_for(:name)
    address = @customers_view.ask_user_for(:address)

    customer = Customer.new(name: name, address: address)
    @customer_repository.create(customer)
  end

  def list
    display_customers
  end

  def remove
    display_customers
    puts "\n"
    index = @customers_view.ask_user_for_number
    @customer_repository.delete(index)
  end

  def edit
    display_customers
    puts "\n"
    index = @customers_view.ask_user_for_number

    new_name = @customers_view.ask_user_for(:name)
    new_address = @customers_view.ask_user_for(:address)

    @customer_repository.update(index, new_name, new_address)
  end

  private

  def display_customers
    customers = @customer_repository.all
    @customers_view.display(customers)
  end
end
