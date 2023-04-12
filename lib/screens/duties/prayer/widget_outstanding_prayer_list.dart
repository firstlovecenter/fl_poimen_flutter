import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/prayer/models_prayer.dart';
import 'package:poimen/screens/duties/prayer/widget_prayer_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';

class ChurchOutstandingPrayerList extends StatefulWidget {
  const ChurchOutstandingPrayerList({Key? key, required this.church}) : super(key: key);

  final ChurchForOutstandingPrayerList church;

  @override
  ChurchOutstandingPrayerListState createState() => ChurchOutstandingPrayerListState();
}

class ChurchOutstandingPrayerListState extends State<ChurchOutstandingPrayerList> {
  final TextEditingController _searchController = TextEditingController();
  List<OutstandingPrayerForList> _filteredMembers = [];

  @override
  void initState() {
    super.initState();
    _filteredMembers = widget.church.outstandingPrayer;
    _searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final String query = _searchController.text.toLowerCase();
    List<OutstandingPrayerForList> filteredList = [];
    for (OutstandingPrayerForList member in widget.church.outstandingPrayer) {
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
                'These people have not been prayed for during the current sheperding cycle',
                style: TextStyle(fontSize: 16),
              ),
              // a centered card with the number of outstanding prayers
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
                        leading: const Icon(FontAwesomeIcons.personPraying),
                        trailing: TrailingCardAlertNumber(
                            number: widget.church.outstandingPrayer.length,
                            variant: TrailingCardAlertNumberVariant.red),
                        title: const Text('Prayers Remaining'),
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
                            '/${widget.church.typename.toLowerCase()}/completed-prayer',
                          );
                        },
                        leading: const Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          color: Colors.green,
                        ),
                        trailing: TrailingCardAlertNumber(
                          number: widget.church.completedPrayerCount,
                          variant: TrailingCardAlertNumberVariant.green,
                        ),
                        title: const Text('Prayers Completed'),
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
                return prayerMemberTile(context, member);
              }).toList()),
            ]),
          )
        ]));
  }
}

Column prayerMemberTile(BuildContext context, OutstandingPrayerForList member) {
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
                style: _outstandingPrayerButtonStyle(),
                icon: const Icon(
                  FontAwesomeIcons.pencil,
                  size: 15,
                ),
                label: const Text('Record Prayer'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

ButtonStyle _outstandingPrayerButtonStyle() {
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
        return OutstandingPrayerReportForm(member: member);
      });
}
