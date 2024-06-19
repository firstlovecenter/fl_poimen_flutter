import 'dart:convert';
import 'package:flutter_contacts/flutter_contacts.dart';
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
          try {
            setState(() {
              loading = true;
            });
            await downloadAndOpenVCard(widget.member, '');
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                ),
              );
            }
          } finally {
            setState(() {
              loading = false;
            });
          }
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
${member.whatsappNumber != member.phoneNumber ? ';TYPE=HOME:${member.whatsappNumber}' : ''}
NOTE:Visitation Landmark: ${member.visitationArea}\\nOccupation: ${member.occupation?.occupation ?? 'None'}\\nMarital Status: ${member.maritalStatus.status.name}\\nRoles in Church:\\n$roles\n${base64Image != '' ? 'PHOTO;ENCODING=b;TYPE=JPEG:$base64Image\n' : ''}BDAY:${member.dob.date}
ADR;TYPE=HOME:;;;;${member.visitationArea};;\nEND:VCARD''';

  return vCard;
}

Future<void> downloadAndOpenVCard(Member member, String roles) async {
  try {
    FlutterContacts.config.includeNotesOnIos13AndAbove = true;
    final response = await http.get(Uri.parse(member.pictureUrl));
    final bytes = response.bodyBytes;

    final contact = Contact()
      ..name.first = member.firstName
      ..name.last = member.lastName
      ..name.prefix = member.currentTitle ?? ''
      ..photo = bytes
      ..addresses = [
        Address(
          member.visitationArea,
          street: member.visitationArea,
          city: member.visitationArea,
          label: AddressLabel.home,
        )
      ]
      ..events = [
        Event(
          month: member.dob.date.month,
          day: member.dob.date.day,
          label: EventLabel.birthday,
        )
      ]
      ..organizations = [
        Organization(company: 'FLC ${member.council.name} Council'),
      ]
      ..emails = [
        Email(member.email ?? '', label: EmailLabel.work),
      ]
      ..phones = [
        Phone(member.phoneNumber, label: PhoneLabel.mobile),
        if (member.phoneNumber != member.whatsappNumber)
          Phone(member.whatsappNumber, label: PhoneLabel.custom, customLabel: 'WhatsApp')
      ]
      ..notes = [
        Note('Visit me')
        // Note(
        //   'Visitation Landmark: ${member.visitationArea}\nOccupation: ${member.occupation?.occupation ?? 'None'}\nMarital Status: ${member.maritalStatus.status.name}\nRoles in Church:\n$roles',
        // ),
      ];
    final newContact = await FlutterContacts.openExternalInsert(contact);
    print(newContact?.toJson());
  } catch (e) {
    rethrow;
  }
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
