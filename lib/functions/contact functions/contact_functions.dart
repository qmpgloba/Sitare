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