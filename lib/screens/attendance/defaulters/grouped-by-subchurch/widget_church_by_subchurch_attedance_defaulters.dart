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
    SharedState churchState = Provider.of<SharedState>(context);
    String level = churchState.church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    ChurchLevel subChurchLevel = getSubChurch(churchLevel);
    String subChurchState = churchState.constituencyId;
    List<ChurchForAttendanceDefaulters> subChurch = [];

    if (subChurchLevel == ChurchLevel.constituency) {
      subChurch = church.constituencies ?? [];
    }

    if (subChurchLevel == ChurchLevel.council) {
      subChurchState = churchState.councilId;
      subChurch = church.councils ?? [];
    }

    if (subChurchLevel == ChurchLevel.stream) {
      subChurchState = churchState.streamId;
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
          ...subChurch
              .map((church) => DefaulterSubChurchCard(churchState: subChurchState, church: church)),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}

class DefaulterSubChurchCard extends StatelessWidget {
  DefaulterSubChurchCard({
    Key? key,
    required this.church,
    required this.churchState,
  }) : super(key: key);

  final ChurchForAttendanceDefaulters church;
  String churchState;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {churchState = church.id, Navigator.of(context).pushNamed('')},
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
                style: TextStyle(
                    color: _setSemanticColour(church.fellowshipServicesThisWeekCount != 0)),
              ),
              Text(
                'Did Not Mark Fellowship Attendance ${church.fellowshipAttendanceDefaultersCount}',
                style: TextStyle(
                    color: _setSemanticColour(church.fellowshipAttendanceDefaultersCount == 0)),
              ),
              Text(
                'Number of Bacentas Bussed ${church.bacentaBussingThisWeekCount}',
                style: TextStyle(
                  color: _setSemanticColour(church.bacentaBussingThisWeekCount != 0),
                ),
              ),
              Text(
                'Did Not Mark Bacenta Attendance ${church.bacentaAttendanceDefaultersCount}',
                style: TextStyle(
                  color: _setSemanticColour(church.bacentaAttendanceDefaultersCount == 0),
                ),
              ),
              const Padding(padding: EdgeInsets.all(6)),
              Text('${church.leader?.firstName} ${church.leader?.lastName}'),
              Row(
                children: [
                  ContactIconRect(
                    icon: FontAwesomeIcons.phone,
                    color: PoimenTheme.phoneColor,
                    phoneNumber: church.leader?.phoneNumber,
                  ),
                  ContactIconRect(
                    icon: FontAwesomeIcons.whatsapp,
                    color: PoimenTheme.whatsappColor,
                    whatsAppInfo: WhatsAppInfo(
                      firstName: church.leader?.firstName ?? '',
                      number: church.leader?.whatsappNumber ?? '',
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
