import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/service/chat_service.dart';

import 'widgets/chat_input_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.astrologer});

  final AstrologerModel astrologer;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Column(
          children: [
            Text(widget.astrologer.fullName),
            Text(
              widget.astrologer.skills.take(2).join(','),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.astrologer.profilePic),
          ),
          SizedBox(
            width: size.width / 16,
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.withOpacity(0.4),
                child: _buildMessageList(size),
              ),
            ),
            ChatInputWidget(
                messageController: _messageController,
                chatService: _chatService,
                astrologer: widget.astrologer)
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(Size size) {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.astrologer.uid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading...'));
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document, size))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document, Size size) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color:(data['senderId'] == _firebaseAuth.currentUser!.uid)? Colors.blue:greyColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(data['message']),
          ),
        ),
      ),
    );
  }
}
