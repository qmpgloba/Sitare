import 'package:dio/dio.dart';
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
  // Define the FCM endpoint and headers
  final String fcmUrl = "https://fcm.googleapis.com/fcm/send";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization":
        "key=AAAA_dyVjd4:APA91bFIRolqLYn5iC55-L5tBl8D_FyA5RDeM4lr0ithT5DnWFsqJLGjXnbCfd3s9S1qYf64ZFxufndObzWVcGvvnIETJeMmduGPiWtK7Ps7v3vefxgYGvfH5aCHcukwqLnxEuUtP8uy"
  };

  // Define the request body
  final Map<String, dynamic> body = {
    "to": fcmToken,
    "notification": {
      "body": "${userData!['full name']}Want to contact",
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
      print("Notification sent successfully");
    } else {
      print("Failed to send notification. Status code: ${response.statusCode}");
      print("Response data: ${response.data}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
