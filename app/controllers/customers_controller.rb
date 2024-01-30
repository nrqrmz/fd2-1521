require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def add
    name = @view.ask_user_for('name')
    address = @view.ask_user_for('address')
    customer = Customer.new(name: name, address: address)
    @customer_repository.create(customer)

    display_customers
  end

  def list
    display_customers
  end

  private

  def display_customers
    customers = @customer_repository.all
    @view.display(customers)
  end
end
