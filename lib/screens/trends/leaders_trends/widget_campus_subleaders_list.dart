import 'package:flutter/material.dart';
import 'package:poimen/screens/trends/leaders_trends/models_my_leaders_trends.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_header_widget.dart';
import 'package:provider/provider.dart';

class CampusSubLeadersListWidget extends StatelessWidget {
  const CampusSubLeadersListWidget({Key? key, required this.church}) : super(key: key);
  final CampusWithSubChurchList church;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color kPrimaryColor =
        isDark ? const Color.fromARGB(255, 251, 192, 192) : const Color.fromARGB(255, 104, 28, 22);
    var churchState = Provider.of<SharedState>(context);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            '${church.name} ${church.typename} Leaders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
        ...church.subChurches.map(
          (church) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MemberHeaderWidget(
                          member: church.leader!,
                          secondaryHeading: '${church.name} ${church.typename}',
                          role: Role.values.byName('leader${church.typename}'),
                          avatarRadius: 30,
                        ),
                      ],
                    ),
                    const Divider(thickness: 3),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(padding: EdgeInsets.all(5.0)),
                        ElevatedButton(
                          onPressed: () {
                            if (church.typename == 'Fellowship') {
                              churchState.fellowshipId = church.id;
                            } else if (church.typename == 'Constituency') {
                              churchState.constituencyId = church.id;
                            } else if (church.typename == 'Council') {
                              churchState.councilId = church.id;
                            } else if (church.typename == 'Stream') {
                              churchState.streamId = church.id;
                            } else if (church.typename == 'Campus') {
                              churchState.campusId = church.id;
                            }

                            Navigator.pushNamed(
                              context,
                              '/trends/${church.typename.toLowerCase()}/membership-attendance',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PoimenTheme.whatsappColor,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: const Text(
                            'Membership',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        church.typename != 'Fellowship'
                            ? ElevatedButton(
                                onPressed: () {
                                  if (church.typename == 'Fellowship') {
                                    churchState.fellowshipId = church.id;
                                  } else if (church.typename == 'Constituency') {
                                    churchState.constituencyId = church.id;
                                  } else if (church.typename == 'Council') {
                                    churchState.councilId = church.id;
                                  } else if (church.typename == 'Stream') {
                                    churchState.streamId = church.id;
                                  } else if (church.typename == 'Campus') {
                                    churchState.campusId = church.id;
                                  }

                                  Navigator.pushNamed(
                                    context,
                                    '/${church.typename.toLowerCase()}-subleaders-trends',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 245, 133, 183),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: const Text(
                                  'Sub Leaders',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
