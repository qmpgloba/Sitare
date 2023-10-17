import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sitare/model/astrologer_model.dart';
import 'package:sitare/screens/chat%20screen/service/chat_service.dart';
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

sendNotification() async {
  // Define the FCM endpoint and headers
  const String fcmUrl = "https://fcm.googleapis.com/fcm/send";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization":
        "key=AAAA_dyVjd4:APA91bFIRolqLYn5iC55-L5tBl8D_FyA5RDeM4lr0ithT5DnWFsqJLGjXnbCfd3s9S1qYf64ZFxufndObzWVcGvvnIETJeMmduGPiWtK7Ps7v3vefxgYGvfH5aCHcukwqLnxEuUtP8uy"
  };

  // Define the request body
  final Map<String, dynamic> body = {
    "to":
        "eHeRr2o0QwKsIi3ErOLrAU:APA91bFAnvdYbnr_2SeRmLpSeIvaD1j5Kk5-Q7gixQBEa4hyMgn4zPwTsj9dk8Z2GQsnsGVbks4tS_AEdK7rAvzgmT9SHSbAYikqTg4r_0AKhkYDhsV8Zb31KikzbRRkIZtnBrYIvJkY",
    "notification": {
      "body": "User Want to contact",
      "OrganizationId": "2",
      "content_available": true,
      "priority": "high",
      "subtitle": "Elementary School",
      "title": "Astro"
    }
  };

  try {
    final dio = Dio();
    final response = await dio.post(
      fcmUrl,
      data: body,
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      // Notification sent successfully
    } else {
      // Handle errors
    }
  } catch (e) {
    // Handle network or other errors
  }
}

 void sendMessage(TextEditingController controller,ChatService chatService,AstrologerModel astrologer) async {
    if (controller.text.isNotEmpty) {
      await chatService.sendMessage(
          astrologer.uid, controller.text);

      controller.clear();
    }
  }
