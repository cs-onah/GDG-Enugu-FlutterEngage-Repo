class BankAccountModel{
  static double accountBalance = 0;

  static void withdraw(double amount){
    if(amount > accountBalance) throw InsufficientFundsException();
    if(amount.isNegative) throw NegativeException();
    accountBalance = accountBalance - amount;
  }

  static void deposit(double amount){
    // if(amount <= 0) throw InvalidEntry();
    if(amount.isNegative) throw NegativeException();
    accountBalance = accountBalance + amount;
  }
}


//Exceptions
class InsufficientFundsException implements Exception {
  String message;

  InsufficientFundsException({this.message = "Insufficient Balance"});
}

class NegativeException implements Exception {
  String message;

  NegativeException({this.message = "Negative value"});
}

class InvalidEntry implements Exception {
  String message;

  InvalidEntry({this.message = "Invalid Entry"});
}