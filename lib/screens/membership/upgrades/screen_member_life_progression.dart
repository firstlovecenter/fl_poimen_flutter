import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/details/widget_member_avatar_screen_header.dart';
import 'package:poimen/screens/membership/upgrades/utils_member_upgrades.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/color_block_tile.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class MemberLifeProgressionsScreen extends StatelessWidget {
  const MemberLifeProgressionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getMemberLifeProgression,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Membership Upgrades Details',
      bodyFunction: (data) {
        final member = MemberWithLifeProgression.fromJson(data?['members'][0]);
        final memberPicture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
        double progressionPercentage =
            calculateProgressionPercentage(member.lifeProgression?.toJson());

        return GQLQueryContainerReturnValue(
            pageTitle: const PageTitle(pageTitle: 'Member Life Progression'),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const Padding(padding: EdgeInsets.all(15)),
                  MemberAvatarScreenHeader(member: member, memberPicture: memberPicture),
                  const Padding(padding: EdgeInsets.all(15.0)),
                  Center(
                    child: Text('Life Progression - $progressionPercentage%',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: PoimenTheme.brandTextPrimary)),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  LinearProgressIndicator(
                    minHeight: 20,
                    value: progressionPercentage / 100,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    semanticsLabel: 'Progress: $progressionPercentage%',
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/membership-upgrades/life-progression');
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Update Life Progression'),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  ...lifeProgressionList.map(
                    (item) => Column(
                      children: [
                        ColorBlockTile(
                          leadingColor: member.lifeProgression?.toJson()[item.property] == true
                              ? const Color(0xFF00450F)
                              : Colors.grey,
                          icon: item.icon,
                          title: item.title,
                          to: '',
                        ),
                        const Padding(padding: EdgeInsets.all(8.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
