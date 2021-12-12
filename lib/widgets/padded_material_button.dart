import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
