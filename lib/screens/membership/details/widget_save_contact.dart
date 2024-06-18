import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:http/http.dart' as http;

class WidgetSaveContact extends StatefulWidget {
  const WidgetSaveContact({super.key, required this.member, required this.roles});

  final Member member;
  final String roles;

  @override
  State<WidgetSaveContact> createState() => _WidgetSaveContactState();
}

class _WidgetSaveContactState extends State<WidgetSaveContact> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const iconSize = 16.0;

    return SizedBox(
      height: 30,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(const Size(80, 30)),
          padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)),
        ),
        onPressed: () async {
          setState(() {
            loading = true;
          });
          print(await generateVCard(widget.member, ''));
          setState(() {
            loading = false;
          });
        },
        icon: loading == true
            ? const SizedBox(width: iconSize, height: iconSize, child: CircularProgressIndicator())
            : const Icon(
                FontAwesomeIcons.solidFloppyDisk,
                size: iconSize,
              ),
        label: const Text(
          'Save',
          style: TextStyle(fontSize: 12),
        ),
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
