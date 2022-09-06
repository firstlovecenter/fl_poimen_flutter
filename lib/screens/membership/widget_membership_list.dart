import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/widgets/no_data.dart';

class ChurchMembershipList extends StatelessWidget {
  const ChurchMembershipList({
    Key? key,
    required this.church,
  }) : super(key: key);

  final ChurchForMemberList church;

  @override
  Widget build(BuildContext context) {
    const headerStyle =
        TextStyle(color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);

    const double accordionHeight = 450;
    int memberCount = church.sheep.length + church.goats.length + church.deer.length;

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        Text('Total Members: $memberCount'),
        Accordion(
          maxOpenSections: 1,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          paddingListHorizontal: 0,
          headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          headerBackgroundColor: Colors.black,
          headerBackgroundColorOpened: const Color(0xFF1A1A1A),
          contentBackgroundColor: const Color(0xFF090909),
          headerBorderRadius: 0,
          contentHorizontalPadding: 5,
          contentBorderWidth: 1,
          // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          // sectionClosingHapticFeedback: SectionHapticFeedback.light,

          children: [
            AccordionSection(
              isOpen: true,
              contentBorderRadius: 0,
              leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
              header: const Text('Sheep', style: headerStyle),
              content: SizedBox(
                height: accordionHeight,
                child: ListView(
                  children: noDataChecker(
                    church.sheep.map((member) {
                      return _memberTile(context, member);
                    }).toList(),
                  ),
                ),
              ),
            ),
            AccordionSection(
              leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
              contentBorderRadius: 0,
              header: const Text('Goats', style: headerStyle),
              content: SizedBox(
                height: accordionHeight,
                child: ListView(
                  children: noDataChecker(church.goats.map((member) {
                    return _memberTile(context, member);
                  }).toList()),
                ),
              ),
            ),
            AccordionSection(
              leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
              contentBorderRadius: 0,
              header: const Text('Deer', style: headerStyle),
              content: SizedBox(
                height: accordionHeight,
                child: ListView(
                  children: noDataChecker(church.deer.map((member) {
                    return _memberTile(context, member);
                  }).toList()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Column _memberTile(BuildContext context, Member member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  return Column(
    children: [
      ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/member-details');
        },
        title: Text('${member.firstName} ${member.lastName}'),
        subtitle: Text(member.typename),
        leading: CircleAvatar(
          foregroundImage: NetworkImage(picture.imageUrl),
        ),
      ),
      const Divider(thickness: 1)
    ],
  );
}
