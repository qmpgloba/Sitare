
import 'package:flutter/material.dart';
import 'package:sitare/functions/contact%20functions/contact_functions.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/service/chat_service.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({
    super.key,
    required TextEditingController messageController, required this.chatService, required this.astrologer,
  }) : _messageController = messageController;

  final TextEditingController _messageController;
  final ChatService chatService;
  final AstrologerModel astrologer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
            Expanded(child: TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Type message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            
              )
            ),
            )),
            IconButton(onPressed: () {
            sendMessage(_messageController, chatService, astrologer);
            }, icon: const Icon(Icons.send,size: 35,))
                ],),
    );
  }
}
