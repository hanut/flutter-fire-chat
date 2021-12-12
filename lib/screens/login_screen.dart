import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "loginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'app_logo',
              child: SizedBox(
                height: 250.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              style: kTextFieldStyle1,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: kTextFieldDecoration1.copyWith(
                hintText: "Enter your email...",
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              style: kTextFieldStyle1,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: kTextFieldDecoration1.copyWith(
                hintText: "Enter your password...",
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Implement login functionality.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text('Log In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
