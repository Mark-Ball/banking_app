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

def get_balance(input)
    for user_hash in read_users_and_balances
        if user_hash[:user] == input
            return user_hash[:balance]
        else
            puts("That user was not found")
        end
    end
end

def clear_screen
    system("clear")
end

def choice_balance
    puts("Your balance is #{get_balance}. Press enter to continue.")
    continue = gets
    clear_screen
end

def choice_deposit
    puts("How much would you like to deposit?")
    deposit_value = gets.strip.to_i
    balance = get_balance 
    p(get_balance)
    balance += deposit_value
    set_balance(balance)
    puts("Your balance is #{balance}. Press Enter to continue")
    continue = gets
    clear_screen
end

def choice_withdraw
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

puts("Welcome to the banking app")
puts("Enter Username")
user_name = gets.strip.downcase
check_user(user_name)

read_users_and_balances
loop do
    puts("What would you like to do? (options: balance, deposit, withdraw, history, exit)")
    choice = gets.strip
    @history.push(choice)

    if choice == "balance"
        choice_balance
    elsif choice == "deposit"
        choice_deposit
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