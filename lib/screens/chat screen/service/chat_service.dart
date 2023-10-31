import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/model/chat_model.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    // final String currentUserPhoneNumber = _auth.currentUser!.phoneNumber!;
    final Timestamp timestamp = Timestamp.now();
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    MessageModel newMessage = MessageModel(
        senderId: currentUserId,
        chatId: chatRoomId,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());

    Map<String, dynamic> participants = {
      'participants': ids,
      // other data related to the chat room can be added here
    };

    DocumentReference chatRoomRef =
        FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomId);
    DocumentSnapshot chatRoomSnapshot = await chatRoomRef.get();

    if (chatRoomSnapshot.exists) {
      await chatRoomRef.update(participants);
    } else {
      await chatRoomRef.set(participants);
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<List<AstrologerModel>> fetchOtherParticipants() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('participants', arrayContains: currentUserId)
        .get();

    List<String> chatIds = extractChatIds(querySnapshot, currentUserId);
    List<String> userIds = [];
    for (String chatId in chatIds) {
      List<String> ids = chatId.split('_');
      ids.remove(currentUserId);
      userIds.addAll(ids);
    }

    List<AstrologerModel> astrologers = [];
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Astrologerdetails');
    for (String userId in userIds) {
       QuerySnapshot userQuerySnapshot = await usersCollection.where('uid', isEqualTo: userId).get();
      if (userQuerySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> astrologerData = userQuerySnapshot.docs.first.data() as Map<String, dynamic>;
        AstrologerModel user = AstrologerModel.fromJson(astrologerData);
        astrologers.add(user);
      }
    }
    return astrologers;
  }

  List<String> extractChatIds(QuerySnapshot querySnapshot, String currentUserId) {
    List<String> chatIds = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> participants = data['participants'];
      for (String participant in participants) {
        if (participant != currentUserId) {
          chatIds.add(doc.id);
          break;
        }
      }
    }
    return chatIds;
  }
}
