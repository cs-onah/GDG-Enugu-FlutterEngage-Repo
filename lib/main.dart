import 'package:flutter/material.dart';

import 'account_model.dart';

void main() {
  runApp(TechoCraft());
}

class TechoCraft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BankAccount(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BankAccount extends StatefulWidget {
  @override
  _BankAccountState createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 45,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Account Balance",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'N ${BankAccountModel.accountBalance.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ActionCard(
                      icon: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      text: 'Withdraw',
                      color: Colors.pink[50],
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WithdrawScreen()));
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ActionCard(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                        size: 30,
                      ),
                      text: 'Deposit',
                      color: Colors.amber[50],
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepositScreen()));
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("...Still Under Construction")),
                ),
                child: Card(
                  elevation: 10,
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Container(
                    height: 300,
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle,
                            size: 45,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Add Card',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(
          'Withdrawal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Enter Amount:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) => int.tryParse(val) == null
                      ? "Please Enter a valid number"
                      : null,
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: TextButton(
                          onPressed: () {
                            if (!_formKey.currentState.validate()) return;
                            try {
                              BankAccountModel.withdraw(
                                  double.parse(_controller.text));
                              Navigator.pop(context);
                            } on NegativeException {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Negative values not allowed")),
                              );
                            } on InsufficientFundsException {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "You do not have sufficient balance")),
                              );
                            }
                          },
                          child: Text(
                            'Withdraw',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.pink[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DepositScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(
          'Deposit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Enter Amount:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) => int.tryParse(val) == null
                      ? "Please Enter a valid number"
                      : null,
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: TextButton(
                          onPressed: () {
                            if (!_formKey.currentState.validate()) return;
                            try {
                              BankAccountModel.deposit(
                                  double.parse(_controller.text));
                              Navigator.pop(context);
                            } on NegativeException {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Negative values not allowed")),
                              );
                            } on InvalidEntry {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Please enter a valid positive value")),
                              );
                            }
                          },
                          child: Text(
                            'Deposit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.amber[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  Function onPressed;
  String text;
  Icon icon;
  Color color;
  ActionCard({Key key, this.color, this.text, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 20,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Container(
          height: 150,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                height: 20,
              ),
              Text('$text',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
