import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/membership/upgrades/gql_member_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/models_membership_upgrades.dart';
import 'package:poimen/screens/membership/details/widget_member_avatar_screen_header.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/color_block_tile.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class MemberSpiritualProgressionsScreen extends StatelessWidget {
  const MemberSpiritualProgressionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SharedState>(context);
    return GQLQueryContainer(
      query: getMemberSpiritualProgression,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Membership Upgrades Details',
      bodyFunction: (data) {
        final member = MemberWithSpiritualProgression.fromJson(data?['members'][0]);
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
                    leadingColor: member.spiritualProgression?.salvation != null
                        ? const Color(0xFF00450F)
                        : Colors.grey,
                    icon: FontAwesomeIcons.tent,
                    title: 'Salvation',
                    to: '',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.spiritualProgression?.waterBaptism != null
                        ? const Color(0xFF452E00)
                        : Colors.grey,
                    icon: FontAwesomeIcons.music,
                    title: 'Water Baptism',
                    to: '',
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  ColorBlockTile(
                    leadingColor: member.spiritualProgression?.holyGhostBaptism != null
                        ? const Color(0xFF003445)
                        : Colors.grey,
                    icon: FontAwesomeIcons.book,
                    title: 'Holy Ghost Baptism',
                    to: '',
                  ),
                ],
              ),
            ));
      },
    );
  }
}
