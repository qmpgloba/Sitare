import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sitare/model/astrologer_model.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.astrologer}) : super(key: key);
  static String id = 'chat-screen';
  final AstrologerModel astrologer;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  late String id, peerId, groupChatId;

  @override
  void initState() {
    // UserStore userStore = Provider.of<UserStore>(context, listen: false);
    // ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
    id = widget.astrologer.fullName;
    // peerId = currentUser!.uid;
    // groupChatId = getGroupChatId(id, peerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.astrologer.fullName),
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            PopupMenuButton(
                itemBuilder: (_) => [
                      PopupMenuItem(
                          onTap: () => FirebaseFirestore.instance
                                  .collection('Messages')
                                  .doc(groupChatId)
                                  .collection(groupChatId)
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  ds.reference.delete();
                                }
                              }),
                          child: const Text('Delete conversation'))
                    ]),
            IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          ],
        ),
        body:  SafeArea(
          child: Container(),
          // child: ChatWindow(),
        ),
      );
    
  }
}
