import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/imcl/models_imcl.dart';
import 'package:poimen/screens/duties/imcl/widget_imcl_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ChurchImclList extends StatefulWidget {
  const ChurchImclList({Key? key, required this.church}) : super(key: key);

  final ChurchForImclList church;

  @override
  ChurchImclListState createState() => ChurchImclListState();
}

class ChurchImclListState extends State<ChurchImclList> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.church.imcls
        .where((member) => '${member.firstName} ${member.lastName}'
            .toLowerCase()
            .contains(_searchText.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            'This is the list of those who were not at the last church service',
            style: TextStyle(fontSize: 16),
          ),
          Center(
            child: Text(
              'You must contact them to find out why they were absent',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: PoimenTheme.brand,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          TextField(
            decoration: InputDecoration(
              labelText: 'Search by member name',
              prefixIcon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: PoimenTheme.brand,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          ),
          const SizedBox(height: 8.0),
          const Padding(padding: EdgeInsets.all(8.0)),
          ...noDataChecker(filteredList.map((member) {
            return _memberTile(context, member);
          }).toList()),
        ],
      ),
    );
  }
}

Column _memberTile(BuildContext context, ImclForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = Provider.of<SharedState>(context);

  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  memberState.memberId = member.id;
                  memberState.member = member;
                  Navigator.pushNamed(context, '/member-details');
                },
                leading: Hero(
                  tag: 'member-${member.id}',
                  child: AvatarWithInitials(
                    foregroundImage: picture.image,
                    member: member,
                  ),
                ),
                title: Text('${member.firstName} ${member.lastName}'),
                subtitle: Text(member.status!),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  ContactIcon(
                    icon: Icons.phone,
                    color: PoimenTheme.phoneColor,
                    phoneNumber: member.phoneNumber,
                  ),
                  ContactIcon(
                    icon: FontAwesomeIcons.whatsapp,
                    color: PoimenTheme.whatsappColor,
                    whatsAppInfo:
                        WhatsAppInfo(number: member.whatsappNumber, firstName: member.firstName),
                  ),
                ]),
              ),
              member.imclChecked
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: const Color.fromARGB(130, 76, 175, 79),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            member.missedChurchComments[0].comment,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton.icon(
                      onPressed: () {
                        _bottomSheet(context, member);
                      },
                      style: _imclButtonStyle(),
                      icon: const Icon(
                        FontAwesomeIcons.pencil,
                        size: 15,
                      ),
                      label: const Text('Submit Reason'),
                    ),
            ],
          ),
        ),
      ),
    ],
  );
}

ButtonStyle _imclButtonStyle() {
  return ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

_bottomSheet(BuildContext context, MemberForList member) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return IMCLReportForm(member: member);
      });
}
