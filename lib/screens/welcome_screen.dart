import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/padded_material_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcomeScreen";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "app_logo",
              child: SizedBox(
                child: Image.asset(
                  'images/logo.png',
                  colorBlendMode: BlendMode.hardLight,
                ),
                height: 100,
              ),
            ),
            Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Flash Chat ',
                    textStyle: kHomeHeroTitleStyle,
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.black87,
                label: "Login",
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundedButton(
                color: Colors.black.withOpacity(0.75),
                label: "Register",
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
