#declaring methods
def get_balance
    File.open("banking_app_balance.txt").each do |line|
        @balance = line.to_i
    end
end

def set_balance(new_balance)
    File.open("banking_app_balance.txt","w") do |line|
        line.puts(new_balance)
    end
end

def clear_screen
    system("clear")
end

def banking
    puts("What would you like to do? (options: balance, deposit, withdraw, history, exit)")
    choice = gets.strip
    @history.push(choice)

    if choice == "balance"
        puts("Your balance is #{@balance}. Press Enter to continue.")
        continue = gets
        clear_screen
    elsif choice == "deposit"
        puts("How much would you like to deposit?")
        deposit_value = gets.strip.to_i
        @balance += deposit_value
        set_balance(@balance)
        puts("Your balance is #{@balance}. Press Enter to continue")
        continue = gets
        clear_screen
    elsif choice == "withdraw"
        puts("How much would you like to withdraw?")
        withdraw_value = gets.strip.to_i
        if withdraw_value <= @balance
            @balance -= withdraw_value
            set_balance(@balance)
        else
            puts("Insufficient funds")
        end
        puts("Your balance is #{@balance}. Press Enter to continue.")
        continue = gets
        clear_screen
    elsif choice == "history"
        puts("You have typed the following: \n #{@history}")
        puts("Press Enter to continue.")
        continue = gets
        clear_screen
    elsif choice == "exit"
        return
    else
        puts("Invalid selection")
    end

    banking
end
#end declaring methods

#initializing variables
@balance = 0
@history = Array.new
@users = Hash.new
#end initializing variables

puts("Welcome to the banking app")
#first challenge: write a hash to the txt file
puts("Enter Username")
@username = gets.strip.downcase

def write_user_to_hash(user)
    File.open("banking_app_hash.txt", "w") {
        |line| line.puts("{#{user} => #{@balance}}")
    }
end

#reading from the hash
def read_from_hash
    File.open("banking_app_hash.txt", "r") {
        |file| @balances_hash = file.read
    }
end
puts(@balances_hash)

#puts("Enter User name:")
#username = gets.strip.downcase

write_user_to_hash(@username)
read_from_hash

banking