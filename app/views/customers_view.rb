class CustomersView
  def ask_user_for(something)
    puts "What is the customer #{something}?"
    print '> '
    gets.chomp
  end

  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}. #{customer.name} - #{customer.address}"
    end
  end
end
