import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert_box.dart';

class FellowshipMembershipList extends StatelessWidget {
  const FellowshipMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return Query(
      options: QueryOptions(document: getFellowshipMembers, variables: {
        'id': churchState.fellowshipId,
      }),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        Widget body;
        String pageTitle = 'Fellowship Members';

        if (result.hasException) {
          body = AlertBox(
            type: AlertType.error,
            text: result.exception.toString(),
            onRetry: () => refetch!(),
          );
        } else if (result.isLoading && result.data != null) {
          body = const LoadingScreen();
        } else {
          final fellowship =
              ChurchForMemberList.fromJson(result.data!['fellowships'][0]);

          pageTitle = '${fellowship.name} Fellowship Membership';

          const headerStyle = TextStyle(
              color: Color(0xffffffff),
              fontSize: 15,
              fontWeight: FontWeight.bold);
          const contentStyleHeader = TextStyle(
              color: Color(0xff999999),
              fontSize: 14,
              fontWeight: FontWeight.w700);
          const contentStyle = TextStyle(
              color: Color(0xff999999),
              fontSize: 14,
              fontWeight: FontWeight.normal);

          body = Column(children: [
            Accordion(
              maxOpenSections: 1,
              headerBackgroundColorOpened: Colors.black54,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,

              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              // sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  isOpen: true,
                  leftIcon:
                      const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black,
                  headerBackgroundColorOpened: const Color(0x003a3a3a),
                  contentBackgroundColor: Colors.black,
                  header: const Text('Sheep', style: headerStyle),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: noDataChecker(fellowship.sheep.map((member) {
                      return _memberTile(member);
                    }).toList()),
                  ),
                  contentHorizontalPadding: 5,
                  contentBorderWidth: 1,
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black,
                  headerBackgroundColorOpened: const Color(0x003a3a3a),
                  contentBackgroundColor: Colors.black,
                  header: const Text('Goats', style: headerStyle),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: noDataChecker(fellowship.goats.map((member) {
                      return _memberTile(member);
                    }).toList()),
                  ),
                  contentHorizontalPadding: 5,
                  contentBorderWidth: 1,
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black,
                  headerBackgroundColorOpened: const Color(0x003a3a3a),
                  contentBackgroundColor: Colors.black,
                  header: const Text('Deer', style: headerStyle),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: noDataChecker(fellowship.deer.map((member) {
                      return _memberTile(member);
                    }).toList()),
                  ),
                  contentHorizontalPadding: 5,
                  contentBorderWidth: 1,
                ),
              ],
            ),
          ]);
        }

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pageTitle),
              ],
            ),
          ),
          body: body,
        );
      },
    );
  }
}

ListTile _memberTile(Member member) {
  CloudinaryImage picture =
      CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);

  return ListTile(
    title: Text('${member.firstName} ${member.lastName}'),
    subtitle: Text(member.typename),
    leading: CircleAvatar(
      foregroundImage: NetworkImage(picture.imageUrl),
    ),
  );
}
