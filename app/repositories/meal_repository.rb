require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1

    load_csv if File.exist?(@csv_file)
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.select { |meal| meal.id == id }.first
  end

  def delete(meal_index)
    @meals.delete_at(meal_index)
    save_csv
  end

  def update(index, new_name, new_price)
    meal = @meals[index]
    if meal
      meal.name = new_name
      meal.price = new_price
      save_csv
    else
      puts "Invalid index [#{index}], try again."
    end
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |csv|
      csv << %i[id name price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      meal = Meal.new(id: row[:id].to_i, name: row[:name], price: row[:price].to_i)
      @meals << meal
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end
end

# csv_file_path = 'data/meals.csv'
# repo = MealRepository.new(csv_file_path)

# rice = Meal.new(name: 'rice', price: 300)
# beans = Meal.new(name: 'beans', price: 200)
# chocolate = Meal.new(name: 'chocolate', price: 100)
# rucola_meal = Meal.new(price: 12, name: "Rucola")


# repo.create(rice)
# repo.create(beans)
# repo.create(chocolate)
# repo.create(rucola_meal)

# # repo = MealRepository.new(csv_file_path)
#       new_meal = Meal.new(price: 12, name: "Hawaii")
#       repo.create(new_meal)
# puts repo.all.length

# new_meal.id
