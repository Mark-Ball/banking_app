class BankAccount
    attr_accessor :balance

    def initialize(user_name, balance)
        @user_name = user_name
        @balance = balance
    end
end