import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final void Function(String) onChanged;
  final VoidCallback onPressed;
  final TextEditingController controller;

  const MessageInput({
    Key? key,
    required this.onChanged,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 40,
              minLines: 1,
              textInputAction: TextInputAction.send,
              controller: controller,
              onChanged: onChanged,
              onSubmitted: (_) {
                onPressed();
              },
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          MaterialButton(
            onPressed: onPressed,
            child: const Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
