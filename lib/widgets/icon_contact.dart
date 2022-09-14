import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppInfo {
  final String number;
  final String firstName;

  WhatsAppInfo({required this.number, required this.firstName});
}

class ContactIcon extends StatelessWidget {
  const ContactIcon({
    Key? key,
    required this.icon,
    required this.color,
    this.phoneNumber,
    this.whatsAppInfo,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String? phoneNumber;
  final WhatsAppInfo? whatsAppInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: CircleAvatar(
        backgroundColor: color,
        child: IconButton(
          onPressed: () async {
            if (whatsAppInfo?.number != null) {
              await _sendWhatsappMessage(whatsAppInfo);
            } else if (phoneNumber != null) {
              await _makePhoneCall(phoneNumber);
            }

            return;
          },
          icon: Icon(
            icon,
            color: Colors.black,
          ),
          iconSize: 20,
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(String? phoneNumber) async {
  if (phoneNumber == null) {
    return;
  }
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }
}

Future<void> _sendWhatsappMessage(WhatsAppInfo? whatsapp) async {
  if (whatsapp == null) {
    return;
  }
  final Uri launchUri = Uri(
    scheme: 'https',
    path: 'api.whatsapp.com/send',
    queryParameters: {
      'phone': whatsapp.number,
      'text': 'Hey there ${whatsapp.firstName}',
      'app_absent': '0',
    },
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }
}
