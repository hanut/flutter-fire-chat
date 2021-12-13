import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String content;
  final String sentAt;
  final bool isSender;

  const MessageBubble({
    Key? key,
    required this.content,
    required this.sender,
    required this.sentAt,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isSender ? 60 : 5,
        right: isSender ? 5 : 60,
        top: 5,
        bottom: 5,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "${isSender ? "You" : sender} sent at $sentAt",
                textAlign: isSender ? TextAlign.end : TextAlign.start,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.white24,
                ),
              ),
            ),
            Material(
              elevation: 6,
              borderRadius: isSender
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
              color: isSender ? kMessageBubbleBg : kMessageBubbleBgOther,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 25,
                ),
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
