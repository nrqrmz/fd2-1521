class OrderRepository
  def initialize(csv_filepath, meal_repository, customer_repository, employee_repository)
    @csv_filepath = csv_filepath
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1

    load_csv if File.exist?(@csv_filepath)
  end

  def undelivered_orders
    @orders.reject(&:delivered?)
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order

    save_csv
  end

  def mark(order)
    order.deliver!

    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << %w[id delivered meal_id customer_id employee_id]

      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_filepath, headers: :fist_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      order = Order.new(row)
      @orders << order
    end

    @next_id = @orders.last.id + 1 unless @orders.empty?
  end
end
