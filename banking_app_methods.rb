def read_users_and_balances #creates an array of users and balances from the database
    read = []
    File.open("banking_app_balance.txt").each do |line|
        read.push(line)
    end

    users_and_balances = []
    for items in read
        hash = {}
        hash[:user] = items.split[0]
        hash[:balance] = items.split[1].to_i
        users_and_balances.push(hash)
    end
    return users_and_balances
end

def write_new_user(user, balance) #writes new users' name and balance to the database
    File.open("banking_app_balance.txt", "a") do |line|
        line.puts("\r#{user} #{balance}")
    end
end

def check_user(user_input) #checks if user already exists, creates a new user if they do not
    user_exists = false
    for user_hash in read_users_and_balances
        if user_hash[:user] == user_input
            user_exists = true
        end
    end

    if user_exists == true
        puts("Welcome back #{user_input}")
    else
        write_new_user(user_input, 0)
        puts("New user created for #{user_input}")
    end
end

def get_balance(user_name)
    read_users_and_balances
    for user_hash in read_users_and_balances
        if user_hash[:user] == user_name
            return user_hash[:balance]
        end
    end
end

def set_balance(user_name, balance)
    read = []
    File.open("banking_app_balance.txt").each do |line|
        read.push(line)
    end
    
    for i in 0...read.length
        if read[i].split[0] == user_name
            read[i] = "#{user_name} #{balance}"
        end
    end
    
    File.open("banking_app_balance.txt", "w") do |line|
        line.puts(read)
    end
end

def clear_screen
    system("clear")
end

def choice_balance(user_name)
    puts("Your balance is #{get_balance(user_name)}. Press enter to continue.")
    continue = gets
    clear_screen
end

def choice_deposit(user_name)
    puts("How much would you like to deposit?")
    deposit_value = gets.chomp.to_i
    balance = get_balance(user_name)
    balance += deposit_value
    set_balance(user_name, balance)
    puts("Your balance is #{balance}. Press Enter to continue")
    continue = gets
    clear_screen
end

def choice_withdraw(user_name)
    balance = get_balance(user_name)
    puts("How much would you like to withdraw?")
    withdraw_value = gets.chomp.to_i
    if withdraw_value > 0
        if withdraw_value <= balance
            balance -= withdraw_value
            set_balance(user_name, balance)
        else
            puts("Insufficient funds")
        end
    else
        puts("Invalid withdraw amount")
    end
    puts("Your balance is #{balance}. Press Enter to continue.")
    continue = gets
    clear_screen
end

def write_history(history_array, choice)
    history_array.push(choice)
    return history_array
end

def read_history(history_array)
    puts("You have entered the following: #{history_array}")
    puts("Press Enter to continue.")
    continue = gets
    clear_screen
end