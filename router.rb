class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.role == 'manager'
          print_manager_menu
          user_input = gets.chomp.to_i
          print `clear`
          route_manager_action(user_input)
        else
          print_rider_menu
          user_input = gets.chomp.to_i
          print `clear`
          route_rider_action(user_input)
        end
      end
    end
  end

  def print_manager_menu
    puts "-" * 25
    puts "[Food Delivery 2.0]"
    puts "Manager dashboard"
    puts "-" * 25
    puts "What do you want to do?"
    puts "1. Add a new meal"
    puts "2. List all meals"
    puts "3. Add a new customer"
    puts "4. List all customers"
    puts "5. Add a new order"
    puts "6. List all undelivered orders"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def print_rider_menu
    puts "-" * 25 # ctrl + shift + d
    puts "[Food Delivery 2.0]"
    puts "Rider Dashboard"
    puts "-" * 25
    puts "What do you want to do?"
    puts "1. Mark order as delivered"
    puts "2. List all my undelivered orders"
    puts "3. Logout"
    puts "4. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then logout!
    when 8 then stop!
    else
      puts 'Please select a valid option'
    end
  end

  def route_rider_action(choice)
    case choice
    when 1 then @orders_controller.mark_as_delivered(@current_user)
    when 2 then @orders_controller.list_my_orders(@current_user)
    when 3 then logout!
    when 4 then stop!
    else
      puts 'Please select a valid option'
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
