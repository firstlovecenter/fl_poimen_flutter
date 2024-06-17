import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:http/http.dart' as http;

class WidgetSaveContact extends StatelessWidget {
  const WidgetSaveContact({super.key, required this.member, required this.roles});

  final Member member;
  final String roles;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0)),
      ),
      onPressed: () async {
        print(await generateVCard(member, ''));
      },
      icon: const Icon(
        FontAwesomeIcons.solidFloppyDisk,
        size: 16,
      ),
      label: const Text(
        'Save Contact',
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

Future<String> generateVCard(Member member, String roles) async {
  String base64Image = '';
  final response = await http.get(Uri.parse(member.pictureUrl));
  final bytes = response.bodyBytes;
  base64Image = base64Encode(bytes);

  final vCard = '''BEGIN:VCARD
VERSION:3.0
N:${member.lastName};${member.firstName};${member.middleName.trim() != '' ? '${member.middleName};' : ''}${member.currentTitle != null ? '${member.currentTitle};' : ''}
FN:${member.nameWithTitle}
ORG:FLC ${member.council.name} Council;${member.email != null ? '\nEMAIL;type=INTERNET;type=HOME;type=pref:${member.email}' : ''}
TEL;type=CELL;type=VOICE;type=pref:${member.phoneNumber}
TEL;TYPE=HOME:${member.whatsappNumber}
NOTE:Visitation Landmark: ${member.visitationArea}\\nOccupation: ${member.occupation?.occupation ?? 'None'}\\nMarital Status: ${member.maritalStatus.status}\\nRoles in Church:\\n$roles\n${base64Image != '' ? 'PHOTO;ENCODING=b;TYPE=JPEG:$base64Image\n' : ''}BDAY:${member.dob.date}
ADR;TYPE=HOME:;;;;${member.visitationArea};;\nEND:VCARD''';

  return vCard;
}

const _roleTypes = [
  'Bacenta',
  'Constituency',
  'Council',
  'Stream',
  'Campus',
  'CreativeArts',
  'Ministry',
  'Hub',
  'HubCouncil',
];

const _adminTypes = [
  'Constituency',
  'Council',
  'Stream',
  'Campus',
  'Oversight',
  'CreativeArts',
  'Ministry',
];
