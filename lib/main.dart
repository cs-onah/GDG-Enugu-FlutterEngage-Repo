import 'package:flutter/material.dart';

void main() {
  runApp(TechoCraft());
}


class TechoCraft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _checkBoxValue = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Login Screen"),
        centerTitle: false,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 35,),
                Icon(Icons.agriculture, color: Colors.blue, size: 65,),
                SizedBox(height: 30,),
                Text("Agrico", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.blue),),
                SizedBox(height: 30,),
                //Username
                TextFormField(
                  controller: _usernameController,
                  validator: (val) => val.length < 4 ? "Username too short" : null,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Username",
                  ),
                ),
                SizedBox(height: 15,),
                //Password
                TextFormField(
                  controller: _passwordController,
                  validator: (val) => val.length < 4 ? "Password too short" : null,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: _obscureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      onPressed: (){

                        setState(() {
                          _obscureText = !_obscureText;
                        });

                      },
                    )
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: ()=> setState(() {
                    _checkBoxValue = !_checkBoxValue;
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: _checkBoxValue,
                          onChanged: (val){setState(() {
                        _checkBoxValue = val;
                      });}),
                      Text("I am Human"),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: (){

                            if (!_formKey.currentState.validate()) return;

                            if(_checkBoxValue == false){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Please verify your are a human."),));
                              return;
                            }

                            //Form validation passed
                            String data = "username: ${_usernameController.text} \npassword: ${_passwordController.text} \nI am human: $_checkBoxValue";
                            _showLoginInfoDialog(content: data);
                          },
                          child: Text("Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                Text("Forgot Password?",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                )

              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLoginInfoDialog({String content}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Login details"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$content"),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                child: Text("Okay", style: TextStyle(color: Colors.white),),
                onPressed: ()=> Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}





