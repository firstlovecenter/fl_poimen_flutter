import 'package:flutter/material.dart';
import 'package:poimen/screens/trends/leaders_trends/models_my_leaders_trends.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_header_widget.dart';
import 'package:provider/provider.dart';

class SubLeadersListWidget extends StatelessWidget {
  const SubLeadersListWidget({Key? key, required this.church}) : super(key: key);
  final ChurchWithSubChurchList church;

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
            double leaderPercentage = (church.completedVisitationsCount / church.memberCount +
                church.completedTelepastoringCount / church.memberCount +
                church.completedPrayersCount / church.memberCount);

            if (leaderPercentage.isNaN || leaderPercentage.isInfinite) {
              leaderPercentage = 0;
            }

            leaderPercentage = (leaderPercentage * 10).round() / 10;

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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '$leaderPercentage%',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: leaderPercentage < 80 ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                              '/trends/${church.typename.toLowerCase()}/pastoral-work-cycles',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PoimenTheme.phoneColor,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: const Text(
                            'Pastoral Cycle',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
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
                      ],
                    )
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
