import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/telepastoring/models_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/widget_telepastoring_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';

class ChurchOutstandingTelepastoringList extends StatefulWidget {
  const ChurchOutstandingTelepastoringList({Key? key, required this.church}) : super(key: key);

  final ChurchForOutstandingTelepastoringList church;

  @override
  ChurchOutstandingTelepastoringListState createState() =>
      ChurchOutstandingTelepastoringListState();
}

class ChurchOutstandingTelepastoringListState extends State<ChurchOutstandingTelepastoringList> {
  final TextEditingController _searchController = TextEditingController();
  List<OutstandingTelepastoringForList> _filteredMembers = [];

  @override
  void initState() {
    super.initState();
    _filteredMembers = widget.church.outstandingTelepastoring;
    _searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final String query = _searchController.text.toLowerCase();
    List<OutstandingTelepastoringForList> filteredList = [];
    for (OutstandingTelepastoringForList member in widget.church.outstandingTelepastoring) {
      final String memberName = '${member.firstName} ${member.lastName}'.toLowerCase();
      if (memberName.contains(query)) {
        filteredList.add(member);
      }
    }
    setState(() {
      _filteredMembers = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Expanded(
            child: ListView(children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Text(
                'These people have not been called during the current sheperding cycle',
                style: TextStyle(fontSize: 16),
              ),
              // a centered card with the number of outstanding telepastorings
              const Padding(padding: EdgeInsets.all(10)),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(FontAwesomeIcons.phone),
                        trailing: TrailingCardAlertNumber(
                            number: widget.church.outstandingTelepastoring.length,
                            variant: TrailingCardAlertNumberVariant.red),
                        title: const Text('Calls Remaining'),
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/${widget.church.typename.toLowerCase()}/completed-telepastoring',
                          );
                        },
                        leading: const Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          color: Colors.green,
                        ),
                        trailing: TrailingCardAlertNumber(
                          number: widget.church.completedTelepastoringCount,
                          variant: TrailingCardAlertNumberVariant.green,
                        ),
                        title: const Text('Calls Completed'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _searchController,
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
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              ...noDataChecker(_filteredMembers.map((member) {
                return telepastoringMemberTile(context, member);
              }).toList()),
            ]),
          )
        ]));
  }
}

Column telepastoringMemberTile(BuildContext context, OutstandingTelepastoringForList member) {
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
              ElevatedButton.icon(
                onPressed: () {
                  _bottomSheet(context, member);
                },
                style: _outstandingTelepastoringButtonStyle(),
                icon: const Icon(
                  FontAwesomeIcons.pencil,
                  size: 15,
                ),
                label: const Text('Record Telepastoring'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

ButtonStyle _outstandingTelepastoringButtonStyle() {
  return ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        return OutstandingTelepastoringReportForm(member: member);
      });
}
