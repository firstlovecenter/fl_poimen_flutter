import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactIcon extends StatelessWidget {
  const ContactIcon({
    Key? key,
    required this.icon,
    required this.color,
    this.phoneNumber,
    this.whatsappNumber,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String? phoneNumber;
  final String? whatsappNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: CircleAvatar(
        backgroundColor: color,
        child: IconButton(
          onPressed: () async {
            if (whatsappNumber != null) {
              await _sendWhatsappMessage(whatsappNumber);
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

  await launchUrl(launchUri);
}

Future<void> _sendWhatsappMessage(String? whatsappNumber) async {
  if (whatsappNumber == null) {
    return;
  }
  final Uri launchUri = Uri(
    scheme: 'https',
    path: 'wa.me/$whatsappNumber',
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }

  await launchUrl(launchUri);
}
