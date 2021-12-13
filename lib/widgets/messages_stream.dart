import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  final FirebaseFirestore store;
  final String me;

  const MessagesStream({
    Key? key,
    required this.store,
    required this.me,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: store
          .collection("messages")
          .orderBy("sentAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageWidgets = [];
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
                color: Colors.white,
              ),
            ),
          );
        }

        final messages = snapshot.data!.docs;
        if (messages.isEmpty) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: const Center(
              child: Text(
                "No messages yet !",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
        for (var message in messages) {
          var content = message.get('text');
          var sender = message.get('sender');
          var sentAt = (message.get('sentAt') as Timestamp).toDate();
          var messageBubble = MessageBubble(
            content: content,
            sender: sender,
            sentAt: sentAt.toString(),
            isSender: me == sender,
          );
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            restorationId: "ChatList",
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 5,
            ),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
