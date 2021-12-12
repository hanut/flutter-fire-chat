import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashChat());

final theme = ThemeData.dark().copyWith(
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Colors.black54),
    bodyText1: TextStyle(color: Colors.black54),
  ),
);

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const SafeArea(child: WelcomeScreen()),
        ChatScreen.id: (context) => const SafeArea(child: ChatScreen()),
        RegistrationScreen.id: (context) =>
            const SafeArea(child: RegistrationScreen()),
        LoginScreen.id: (context) => const SafeArea(child: LoginScreen()),
      },
    );
  }
}
