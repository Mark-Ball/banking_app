require "./BankAccount.rb"

def read_users_and_balances #creates an array of users and balances from the database
    read = []
    File.open("banking_app_balance.rb").each do |line|
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
    File.open("banking_app_balance.rb", "a") do |line|
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
    File.open("banking_app_balance.rb").each do |line|
        read.push(line)
    end
    
    for i in 0...read.length
        if read[i].split[0] == user_name
            read[i] = "#{user_name} #{balance}"
        end
    end
    
    File.open("banking_app_balance.rb", "w") do |line|
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
    balance = get_balance
    puts("How much would you like to withdraw?")
    withdraw_value = gets.strip.to_i
    if withdraw_value <= balance
        balance -= withdraw_value
        set_balance(balance)
    else
        puts("Insufficient funds")
    end
    puts("Your balance is #{@balance}. Press Enter to continue.")
    continue = gets
    clear_screen
end

#initializing variables
@balance = 0
@history = Array.new
@users = Hash.new
#end initializing variables


puts("Enter Username")

user_name = gets.strip.downcase

check_user(user_name)

loop do
    read_users_and_balances

    puts("What would you like to do? (options: balance, deposit, withdraw, history, exit)")
    choice = gets.strip
    @history.push(choice)

    if choice == "balance"
        choice_balance(user_name)
    elsif choice == "deposit"
        choice_deposit(user_name)
    elsif choice == "withdraw"
        choice_withdraw
        # puts("How much would you like to withdraw?")
        # withdraw_value = gets.strip.to_i
        # if withdraw_value <= @balance
        #     @balance -= withdraw_value
        #     set_balance(@balance)
        # else
        #     puts("Insufficient funds")
        # end
        # puts("Your balance is #{@balance}. Press Enter to continue.")
        # continue = gets
        # clear_screen
    elsif choice == "history"
        puts("You have typed the following: \n #{@history}")
        puts("Press Enter to continue.")
        continue = gets
        clear_screen
    elsif choice == "exit"
        break
    else
        puts("Invalid selection")
    end
end
#end declaring methods



# puts("Welcome to the banking app")
# #first challenge: write a hash to the txt file
# puts("Enter Username")
# @username = gets.strip.downcase

# def write_user_to_hash(user)
#     File.open("banking_app_hash.txt", "w") {
#         |line| line.puts("{#{user} => #{@balance}}")
#     }
# end

# #reading from the hash
# def read_from_hash
#     File.open("banking_app_hash.txt", "r") {
#         |file| @balances_hash = file.read
#     }
# end
# puts(@balances_hash)

# #puts("Enter User name:")
# #username = gets.strip.downcase

# write_user_to_hash(@username)
# read_from_hash