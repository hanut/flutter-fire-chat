import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/widgets/message_input.dart';
import 'package:flash_chat/widgets/messages_stream.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = "chatScreen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  String messageText = "";
  late User loggedInUser;
  final messageTextController = TextEditingController();
  // List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getMessages();
    // messageStream();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  // void getMessages() async {
  //   var snapshot = await _store.collection("messages").get();
  //   for (var msgSnap in snapshot.docs) {
  //     messages.add(Message.fromSnapshot(msgSnap));
  //   }
  //   _isLoading = false;
  //   setState(() {});
  // }

  // void messageStream() {
  //   _store
  //       .collection("messages")
  //       .snapshots(includeMetadataChanges: false)
  //       .forEach((changes) {
  //     List<Message> newMessages = [];
  //     for (var msgSnap in changes.docs) {
  //       newMessages.add(Message.fromSnapshot(msgSnap));
  //     }
  //     setState(() {
  //       messages = newMessages;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.power_settings_new_rounded),
              onPressed: () async {
                try {
                  await _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomeScreen.id, (route) => false);
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: const Hero(tag: 'app_logo', child: Text('⚡️ Chat')),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(
              store: _store,
              me: loggedInUser.email ?? "",
            ),
            MessageInput(
              controller: messageTextController,
              onChanged: (value) {
                setState(() {
                  messageText = value;
                });
              },
              onPressed: () async {
                try {
                  await _store.collection("messages").add({
                    'text': messageText,
                    'sender': loggedInUser.email,
                    'sentAt': Timestamp.now(),
                  });
                  messageTextController.clear();
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
