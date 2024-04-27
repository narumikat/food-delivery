require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1

    load_csv if File.exist?(@csv_file)
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.select { |customer| customer.id == id }.first
  end

  def delete(customer_index)
    @customers.delete_at(customer_index)
    save_csv
  end

  def update(index, new_name, new_address)
    customer = @customers[index]
    if customer
      customer.name = new_name
      customer.address = new_address
      save_csv
    else
      puts "Invalid index [#{index}], try again."
    end
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |csv|
      csv << %i[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      customer = Customer.new(id: row[:id].to_i, name: row[:name], address: row[:address])
      @customers << customer
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end
end
