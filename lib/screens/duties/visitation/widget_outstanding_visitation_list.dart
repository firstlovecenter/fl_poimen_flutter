import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/duties/visitation/widget_visitation_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChurchOutstandingVisitationList extends StatefulWidget {
  const ChurchOutstandingVisitationList({Key? key, required this.church}) : super(key: key);

  final ChurchForOutstandingVisitationList church;

  @override
  ChurchOutstandingVisitationListState createState() => ChurchOutstandingVisitationListState();
}

class ChurchOutstandingVisitationListState extends State<ChurchOutstandingVisitationList> {
  final TextEditingController _searchController = TextEditingController();
  List<OutstandingVisitationForList> _filteredMembers = [];

  @override
  void initState() {
    super.initState();
    _filteredMembers = widget.church.outstandingVisitations;
    _searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final String query = _searchController.text.toLowerCase();
    List<OutstandingVisitationForList> filteredList = [];
    for (OutstandingVisitationForList member in widget.church.outstandingVisitations) {
      final String memberName =
          '${member.firstName} ${member.lastName} ${member.visitationArea}'.toLowerCase();
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
                'These people have not been visited during the current shepherding cycle',
                style: TextStyle(fontSize: 16),
              ),
              // a centered card with the number of outstanding visitations
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
                        leading: const Icon(FontAwesomeIcons.doorOpen),
                        trailing: TrailingCardAlertNumber(
                            number: widget.church.outstandingVisitations.length,
                            variant: TrailingCardAlertNumberVariant.red),
                        title: const Text('Visits Remaining'),
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
                            '/${widget.church.typename.toLowerCase()}/completed-visitation',
                          );
                        },
                        leading: const Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          color: Colors.green,
                        ),
                        trailing: TrailingCardAlertNumber(
                          number: widget.church.completedVisitationsCount,
                          variant: TrailingCardAlertNumberVariant.green,
                        ),
                        title: const Text('Visits Completed'),
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
                return visitationMemberTile(context, member);
              }).toList()),
            ]),
          )
        ]));
  }
}

Column visitationMemberTile(BuildContext context, OutstandingVisitationForList member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = context.watch<SharedState>();

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
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.visitationArea),
                    Text(member.status!),
                  ],
                ),
                isThreeLine: true,
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
              member.location != null
                  ? ElevatedButton.icon(
                      onPressed: () async {
                        final Uri launchUri = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${member.location?.latitude}%2C${member.location?.longitude}');

                        if (await canLaunchUrl(launchUri)) {
                          final bool nativeAppLaunchSucceeded = await launchUrl(
                            launchUri,
                            mode: LaunchMode.externalNonBrowserApplication,
                          );

                          if (!nativeAppLaunchSucceeded) {
                            await launchUrl(
                              launchUri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        } else {
                          throw 'Could not launch $launchUri';
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(PoimenTheme.whatsappColor),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.locationPin,
                        size: 15,
                      ),
                      label: const Text('Go to Location'),
                    )
                  : Container(),
              ElevatedButton.icon(
                onPressed: () {
                  _bottomSheet(context, member);
                },
                style: _outstandingVisitationButtonStyle(),
                icon: const Icon(
                  FontAwesomeIcons.pencil,
                  size: 15,
                ),
                label: const Text('Record Visit'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

ButtonStyle _outstandingVisitationButtonStyle() {
  return ButtonStyle(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    ),
    shape: WidgetStateProperty.all(
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
        return OutstandingVisitationReportForm(member: member);
      });
}
