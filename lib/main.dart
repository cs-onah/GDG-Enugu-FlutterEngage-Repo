import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.account_circle_outlined, size: 45)),
            SizedBox(height: 30),
            Text("Account Balance"),
            SizedBox(height: 5),
            Text(
              "N 0.00",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(children: [
              Expanded(
                child: Card(
                  elevation: 20,
                  color: Colors.pink[100],
                  child: Container(
                      height: 100, child: Center(child: Text("Withdraw"))),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 20,
                  color: Colors.amber[100],
                  child: Container(
                      height: 100, child: Center(child: Text("Deposit"))),
                ),
              ),
            ]),
            SizedBox(height: 10),
            Card(
              elevation: 20,
              color: Colors.blue[100],
              child: Container(
                width: double.infinity,
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle),
                      SizedBox(height: 20),
                      Text("Add Card"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
