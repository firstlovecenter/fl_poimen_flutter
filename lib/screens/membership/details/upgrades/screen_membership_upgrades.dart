import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/details/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/details/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/details/widget_member_avatar_screen_header.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/color_block_tile.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class MembershipUpgradesScreen extends StatelessWidget {
  const MembershipUpgradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);
    return GQLQueryContainer(
      query: getMemberUpgradesDetails,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Membership Upgrades Details',
      bodyFunction: (data) {
        final member = MemberWithUpgrades.fromJson(data?['members'][0]);
        final memberPicture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);

        return GQLQueryContainerReturnValue(
            pageTitle: const PageTitle(pageTitle: 'Membership Upgrades'),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(15)),
                  MemberAvatarScreenHeader(member: member, memberPicture: memberPicture),
                  const Padding(padding: EdgeInsets.all(15.0)),
                  ColorBlockTile(
                    leadingColor:
                        member.hasHolyGhostBaptism ? const Color(0xFF1C4AC0) : Colors.grey,
                    icon: FontAwesomeIcons.wind,
                    title: 'Holy Ghost Baptism',
                    to: !member.hasHolyGhostBaptism
                        ? '/membership-upgrades/holy-ghost-baptism'
                        : '#',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.hasWaterBaptism ? const Color(0xFF330045) : Colors.grey,
                    icon: FontAwesomeIcons.water,
                    title: 'Water Baptism',
                    to: !member.hasWaterBaptism ? '/membership-upgrades/water-baptism' : '#',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.graduatedUnderstandingSchools.isNotEmpty
                        ? const Color(0xFF000745)
                        : Colors.grey,
                    icon: FontAwesomeIcons.school,
                    title: 'Understanding Campaign',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.attendedCampsWithProphet.isNotEmpty
                        ? const Color(0xFF00450F)
                        : Colors.grey,
                    icon: FontAwesomeIcons.tent,
                    title: 'Camps with the Prophet',
                    to: member.attendedCampsWithProphet.isNotEmpty
                        ? '/membership-upgrades/camps-with-prophet'
                        : '#',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.attendedCampsWithOtherBishops.isNotEmpty
                        ? const Color(0xFF00450F)
                        : Colors.grey,
                    icon: FontAwesomeIcons.tents,
                    title: 'Camps with Other Bishops',
                    to: member.attendedCampsWithOtherBishops.isNotEmpty
                        ? '/membership-upgrades/camps-with-other-bishops'
                        : '#',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor:
                        member.hasAudioCollections ? const Color(0xFF452E00) : Colors.grey,
                    icon: FontAwesomeIcons.music,
                    title: 'Audio Collections',
                    to: !member.hasAudioCollections
                        ? '/membership-upgrades/audio-collections'
                        : '#',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.hasBibleTranslations.isNotEmpty
                        ? const Color(0xFF003445)
                        : Colors.grey,
                    icon: FontAwesomeIcons.book,
                    title: 'Bible Translations',
                    to: !member.hasBibleTranslations.isNotEmpty
                        ? '/membership-upgrades/bible-translations'
                        : '#',
                  ),
                ],
              ),
            ));
      },
    );
  }
}
