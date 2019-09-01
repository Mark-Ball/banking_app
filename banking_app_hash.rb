require_relative "./banking_app_methods.rb"

history = []

puts("Enter Username")
user_name = gets.chomp.downcase
check_user(user_name)

loop do
    read_users_and_balances

    puts("What would you like to do? (options: balance, deposit, withdraw, history, exit)")
    choice = gets.strip
    write_history(history, choice)

    if choice == "balance"
        choice_balance(user_name)
    elsif choice == "deposit"
        choice_deposit(user_name)
    elsif choice == "withdraw"
        choice_withdraw(user_name)
    elsif choice == "history"
        read_history(history)
    elsif choice == "exit"
        break
    else
        puts("Invalid selection")
    end
end