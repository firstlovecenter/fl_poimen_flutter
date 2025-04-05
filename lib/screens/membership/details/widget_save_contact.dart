import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:http/http.dart' as http;

class WidgetSaveContact extends StatefulWidget {
  const WidgetSaveContact({super.key, required this.member});

  final Member member;

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
          fixedSize: MaterialStateProperty.all<Size>(const Size(80, 30)),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)),
        ),
        onPressed: () async {
          try {
            setState(() {
              loading = true;
            });
            await downloadAndOpenVCard(widget.member);
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

Future<String> generateVCard(Member member) async {
  String base64Image = '';
  final response = await http.get(Uri.parse(member.pictureUrl));
  final bytes = response.bodyBytes;
  base64Image = base64Encode(bytes);

  final vCard = '''BEGIN:VCARD
VERSION:3.0
N:${member.lastName};${member.firstName};${member.middleName.trim() != '' ? '${member.middleName};' : ''}${member.currentTitle != null ? '${member.currentTitle};' : ''}
FN:${member.nameWithTitle}
ORG:FLC ${member.council.name} Council;${member.email != null ? '\nEMAIL;type=INTERNET;type=HOME;type=pref:${member.email}' : ''}
TEL;type=CELL;type=VOICE;type=pref:+${member.phoneNumber}
${member.whatsappNumber != member.phoneNumber ? ';TYPE=HOME:+${member.whatsappNumber}' : ''}
NOTE:Visitation Landmark: ${member.visitationArea}\\nOccupation: ${member.occupation?.occupation.trim() == '' ? 'None' : member.occupation?.occupation}\\nMarital Status: ${member.maritalStatus.status.name}\\n${member.roles != '' ? '\\nRoles in Church\\n${member.roles}\\n' : ''}\n${base64Image != '' ? 'PHOTO;ENCODING=b;TYPE=JPEG:$base64Image\n' : ''}BDAY:${member.dob.date.toIso8601String().substring(0, 10)}
ADR;TYPE=HOME:;;;;${member.visitationArea};;\nEND:VCARD''';

  return vCard;
}

Future<void> downloadAndOpenVCard(Member member) async {
  try {
    String vCard = await generateVCard(member);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/vCard.vcf');
    await file.writeAsString(vCard);
    // await FlutterContacts.openExternalInsert(Contact.fromVCard(vCard));
    await OpenFile.open(file.path);
  } catch (e) {
    rethrow;
  }
}

const _roleTypes = [
  'Bacenta',
  'Governorship',
  'Council',
  'Stream',
  'Campus',
  'CreativeArts',
  'Ministry',
  'Hub',
  'HubCouncil',
];

const _adminTypes = [
  'Governorship',
  'Council',
  'Stream',
  'Campus',
  'Oversight',
  'CreativeArts',
  'Ministry',
];
