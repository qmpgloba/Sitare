import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_smart_reply/google_mlkit_smart_reply.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/service/chat_service.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
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
  final smartReply = SmartReply();
  String? lastMessageFromOtherUser;
  final ValueNotifier<int> rebuildNumber = ValueNotifier<int>(0);
  List<String> suggestions = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    smartReply.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _chatService
        .getMessages(widget.astrologer.uid, _firebaseAuth.currentUser!.uid)
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['senderId'] != _firebaseAuth.currentUser!.uid) {
          addMessage(data['message']);
        }
      }
    });
  }

  void addMessage(String message) {
    lastMessageFromOtherUser = message;
    smartReply.addMessageToConversationFromRemoteUser(
        message, DateTime.now().millisecondsSinceEpoch, widget.astrologer.uid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateReplies();
    });
  }

  void generateReplies() async {
    final response = await smartReply.suggestReplies();

    suggestions.clear();

    suggestions.addAll(response.suggestions);
    rebuildNumber.value++;
  }

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
            
                // color: Colors.grey.withOpacity(0.4),
                child: _buildMessageList(size),
              ),
            ),
            Column(
              children: [
                const Divider(),
                ValueListenableBuilder(
                  valueListenable: rebuildNumber,
                  builder: (context, value, child) {
                    if (suggestions.isNotEmpty) {
                      return SizedBox(
                        height: size.width * .1,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: suggestions.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                                width: size.width /
                                    16); // Adjust the width as per your requirement
                          },
                          itemBuilder: (context, index) {
                            return SuggestionTile(
                              suggestions: suggestions,
                              index: index,
                              astrologer: widget.astrologer,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(); // Or any other widget to show when suggestions are empty
                    }
                  },
                ),
                ChatInputWidget(
                    messageController: _messageController,
                    chatService: _chatService,
                    astrologer: widget.astrologer),
              ],
            )
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
        if (snapshot.data!.docs.isEmpty) {
         _sendInitialMessageAndReply(size);

        }
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((document) => SizedBox(
                width: size.width*.7,
                child: _buildMessageItem(document, size)))
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
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width*.7),
          child: Container(
            
             
            decoration: BoxDecoration(
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? Colors.blue
                  : greyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(data['message']),
            ),
          ),
        ),
      ),
    );
  }

  
Future<void> _sendInitialMessageAndReply(Size size) async {
  await _chatService.sendMessage(
    widget.astrologer.uid,
    '''Hi, ${widget.astrologer.fullName},
    Below are my details:
    Name: ${userData!['full name']}
    Gender: ${userData!['gender']}
    DOB: ${userData!['dateofBirth']}
    TOB: ${userData!['timeofBirth']}
    POB: ${userData!['placeofBirth']}
    ''',
  );

  await _chatService.automatedReplyMessage(
    currentUser!.uid,
    'Welcome to Sitare. Consultant will take a minute to analyze your details. You may ask your question in the meanwhile.',
    widget.astrologer.uid,
  );
}
}


class SuggestionTile extends StatefulWidget {
  const SuggestionTile({
    super.key,
    required this.suggestions,
    required this.index,
    required this.astrologer,
  });

  final List<String> suggestions;
  final int index;
  final AstrologerModel astrologer;

  @override
  State<SuggestionTile> createState() => _SuggestionTileState();
}

class _SuggestionTileState extends State<SuggestionTile> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _chatService.sendMessage(
            widget.astrologer.uid, (widget.suggestions[widget.index]));
      },
      child: Container(
        decoration: BoxDecoration(
            color: greyColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.suggestions[widget.index]),
        ),
      ),
    );
  }
}
