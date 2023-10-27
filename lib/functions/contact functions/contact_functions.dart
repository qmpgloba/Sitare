import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  
import 'package:flutter/material.dart';
import 'package:sitare/functions/auth%20function/auth_function.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/service/chat_service.dart';
import 'package:sitare/screens/home%20screen/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

launchWhatsAppUri(String phoneNumber) async {
  final link = WhatsAppUnilink(
    phoneNumber: phoneNumber,
    // text: "Hey! I'm inquiring about the apartment listing",
  );
  // Convert the WhatsAppUnilink instance to a Uri.
  // The "launch" method is part of "url_launcher".
  await launchUrl(Uri.parse(link.toString()));
}

sendNotification(String? fcmToken) async {
  print(fcmToken);
  // Define the FCM endpoint and headers
  const String fcmUrl = "https://fcm.googleapis.com/fcm/send";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization":
        "key=AAAA_dyVjd4:APA91bFIRolqLYn5iC55-L5tBl8D_FyA5RDeM4lr0ithT5DnWFsqJLGjXnbCfd3s9S1qYf64ZFxufndObzWVcGvvnIETJeMmduGPiWtK7Ps7v3vefxgYGvfH5aCHcukwqLnxEuUtP8uy"
  };

  // Define the request body
  final Map<String, dynamic> body = {
    "to": fcmToken,
     "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "uid": FirebaseAuth.instance.currentUser!.uid,
    },
    "notification": {
     
      "body": "${userData!['full name']} wants to contact",
      "OrganizationId": "2",
      "content_available": true,
      "priority": "high",
      "subtitle": "Elementary School",
      "title": "Astro",
      
    }
  };

 try {
    final response = await http.post(Uri.parse(fcmUrl),
        headers: headers, body: jsonEncode(body));
        print(response.body);
    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification. Error: ${response.reasonPhrase}");
    }
  } catch (e) {
    print("Failed to send notification. Error: $e");
  }
}

 void sendMessage(TextEditingController controller,ChatService chatService,AstrologerModel astrologer) async {
    if (controller.text.isNotEmpty) {
      await chatService.sendMessage(
          astrologer.uid, controller.text);

      controller.clear();
    }
  }
