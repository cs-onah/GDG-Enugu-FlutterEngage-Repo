class BankAccountModel{
  static double accountBalance = 0;

  static void withdraw(double amount){
    if(amount > accountBalance) throw InsufficientFundsException();
    accountBalance = accountBalance - amount;
  }

  static void deposit(double amount){
    if(amount <= 0) throw InvalidEntry();
    accountBalance = accountBalance + amount;
  }
}


//Exceptions
class InsufficientFundsException implements Exception {
  String message;

  InsufficientFundsException({this.message = "Insufficient Balance"});
}

class InvalidEntry implements Exception {
  String message;

  InvalidEntry({this.message = "Invalid Entry"});
}