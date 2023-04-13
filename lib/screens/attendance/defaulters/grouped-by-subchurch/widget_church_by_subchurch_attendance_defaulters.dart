import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/helpers/global_functions.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:provider/provider.dart';

class ChurchBySubChurchAttendanceDefaulters extends StatelessWidget {
  const ChurchBySubChurchAttendanceDefaulters({Key? key, required this.church}) : super(key: key);

  final ChurchBySubChurchForAttendanceDefaulters church;

  @override
  Widget build(BuildContext context) {
    String level = church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    ChurchLevel subChurchLevel = getSubChurch(churchLevel);
    List<ChurchForAttendanceDefaulters> subChurch = [];

    if (subChurchLevel == ChurchLevel.constituency) {
      subChurch = church.constituencies ?? [];
    }

    if (subChurchLevel == ChurchLevel.council) {
      subChurch = church.councils ?? [];
    }

    if (subChurchLevel == ChurchLevel.stream) {
      subChurch = church.streams ?? [];
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          const Center(
            child: Text('Defaulters This Week',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ...subChurch.map(
            (church) => DefaulterSubChurchCard(
              church: church,
              level: subChurchLevel,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}

class DefaulterSubChurchCard extends StatelessWidget {
  const DefaulterSubChurchCard({
    Key? key,
    required this.church,
    required this.level,
  }) : super(key: key);

  final ChurchForAttendanceDefaulters church;
  final ChurchLevel level;

  @override
  Widget build(BuildContext context) {
    SharedState churchState = Provider.of<SharedState>(context);
    ChurchLevel subChurchLevel = getSubChurch(level);

    return InkWell(
      onTap: () {
        if (level == ChurchLevel.constituency) {
          churchState.constituencyId = church.id;
          Navigator.pushNamed(context, '/constituency/attendance-defaulters');
        }
        if (level == ChurchLevel.stream) {
          churchState.streamId = church.id;
          Navigator.pushNamed(
            context,
            '/${church.typename.toLowerCase()}-by-${subChurchLevel.name}/attendance-defaulters',
          );
        }

        if (level == ChurchLevel.council) {
          churchState.councilId = church.id;
          Navigator.pushNamed(
            context,
            '/${church.typename.toLowerCase()}-by-${subChurchLevel.name}/attendance-defaulters',
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${church.name} ${church.typename}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              Text(
                'Total Number of Services ${church.fellowshipServicesThisWeekCount}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Did Not Mark Service Attendance ${church.fellowshipServiceAttendanceDefaultersCount}',
                style: TextStyle(
                    fontSize: 16,
                    color:
                        _setSemanticColour(church.fellowshipServiceAttendanceDefaultersCount == 0)),
              ),
              Text(
                'Number of Fellowships Bussed This Week ${church.fellowshipBussingThisWeekCount}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Did Not Mark Bussing Attendance ${church.fellowshipBussingAttendanceDefaultersCount}',
                style: TextStyle(
                  fontSize: 16,
                  color: _setSemanticColour(church.fellowshipBussingAttendanceDefaultersCount == 0),
                ),
              ),
              const Padding(padding: EdgeInsets.all(6)),
              Text(
                churchState.roleType == ChurchRole.admin && church.admin != null
                    ? '${church.admin?.firstName} ${church.admin?.lastName}'
                    : '${church.leader?.firstName} ${church.leader?.lastName}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  ContactIconRect(
                    icon: FontAwesomeIcons.phone,
                    color: PoimenTheme.phoneColor,
                    phoneNumber: churchState.roleType == ChurchRole.admin
                        ? church.admin?.phoneNumber
                        : church.leader?.phoneNumber,
                  ),
                  ContactIconRect(
                    icon: FontAwesomeIcons.whatsapp,
                    color: PoimenTheme.whatsappColor,
                    whatsAppInfo: WhatsAppInfo(
                      firstName: churchState.roleType == ChurchRole.admin
                          ? church.admin?.firstName ?? ''
                          : church.leader?.firstName ?? '',
                      number: churchState.roleType == ChurchRole.admin
                          ? church.admin?.whatsappNumber ?? ''
                          : church.leader?.whatsappNumber ?? '',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _setSemanticColour(bool isGood, [bool? isWarning]) {
    if (isGood) {
      return PoimenTheme.good;
    }
    if (isWarning != null && isWarning) {
      return PoimenTheme.warning;
    }

    return PoimenTheme.bad;
  }
}
