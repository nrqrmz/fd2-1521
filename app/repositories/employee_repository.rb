class EmployeeRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @employees = []

    load_csv if File.exist?(@csv_filepath)
  end

  def all_riders
    @employees.select(&:rider?)
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath, headers: :fist_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      employee = Employee.new(row)
      @employees << employee
    end
  end
end
