import 'package:flutter/material.dart';


class SuccessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image/hi-five.png', height: 200),
              SizedBox(height: 20),
              Text(
                'Success!',
                style: TextStyle(
                    fontFamily: "Gotik",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Transaction successfully completed.',
                style: TextStyle(
                    fontFamily: "Popins",
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Transaction #: AX3RT',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Back to home',
                      style: TextStyle(
                        fontFamily: "Gotik",
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}