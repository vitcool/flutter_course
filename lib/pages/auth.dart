import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Log in'),
        ),
        body: Center(
            child: RaisedButton(
          child: Text("LOGIN"),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        )));
  }
}
