import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/padded_material_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registrationScreen";

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;

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
              tag: "app_logo",
              child: SizedBox(
                height: 250.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: kTextFieldStyle1,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: kTextFieldDecoration1.copyWith(
                hintText: "Enter your email",
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              style: kTextFieldStyle1,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: kTextFieldDecoration1.copyWith(
                hintText: "Enter your password",
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              label: "Register",
              onPressed: () async {
                try {
                  await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.pushNamed(context, ChatScreen.id);
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
