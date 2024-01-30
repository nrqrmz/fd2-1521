class SessionsView
  def ask_user_for(smth)
    puts "What is the #{smth}?"
    print '> '
    gets.chomp
  end

  def wrong_credentials
    puts 'Wrong credentials... Try again!'
  end

  def user_signed_in_successfully(username)
    puts "Welcome #{username}!"
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end
end
