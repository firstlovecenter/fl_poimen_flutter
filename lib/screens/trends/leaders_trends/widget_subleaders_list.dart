import 'package:flutter/material.dart';
import 'package:poimen/screens/trends/leaders_trends/models_my_leaders_trends.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_header_widget.dart';

class SubLeadersListWidget extends StatelessWidget {
  const SubLeadersListWidget({Key? key, required this.church}) : super(key: key);
  final ChurchWithSubChurchList church;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color kPrimaryColor =
        isDark ? const Color.fromARGB(255, 251, 192, 192) : const Color.fromARGB(255, 104, 28, 22);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            'My Leaders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
        ...church.subChurches
            .map(
              (church) => Card(
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
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '98%',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Pastoral Cycle');
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5.0)),
                          ElevatedButton(
                            onPressed: () {
                              print('Pastoral Cycle');
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
