import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/padded_material_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "loginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  String _err = "";
  final _auth = FirebaseAuth.instance;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'app_logo',
                  child: SizedBox(
                    height: 250.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: kTextFieldStyle1,
                onChanged: (value) {
                  setState(() {
                    _email = value;
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
                obscureText: true,
                style: kTextFieldStyle1,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: kTextFieldDecoration1.copyWith(
                  hintText: "Enter your password...",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Visibility(
                visible: _err.isNotEmpty,
                child: Center(
                  child: Text(
                    _err,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                label: "Log In",
                onPressed: () async {
                  setState(() {
                    _err = "";
                    _showSpinner = true;
                  });
                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                    setState(() {
                      _err = "";
                      _showSpinner = false;
                    });
                    Navigator.pushNamedAndRemoveUntil(
                        context, ChatScreen.id, (route) => false);
                  } on FirebaseAuthException catch (e) {
                    String msg;
                    switch (e.code) {
                      case 'wrong-password':
                        msg = "Incorrect Password";
                        break;
                      case 'invalid-email':
                        msg = "Email address is not registered";
                        break;
                      case 'user-disabled':
                        msg = "Your user account has been disabled";
                        break;
                      case 'user-not-found':
                        msg = "No user found for that email id";
                        break;
                      default:
                        rethrow;
                    }
                    setState(() {
                      _err = msg;
                      _showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      _err = e.toString();
                      _showSpinner = false;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
