class MealRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @meals = []
    @next_id = 1

    load_csv if File.exist?(@csv_filepath)
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal

    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      meal = Meal.new(row)
      @meals << meal
    end

    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << %w[id name price]

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
