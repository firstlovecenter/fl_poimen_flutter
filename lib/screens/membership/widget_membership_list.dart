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
    const contentStyleHeader =
        TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    const contentStyle =
        TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

    return Accordion(
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
            height: 500,
            child: ListView(
              children: noDataChecker(
                church.sheep.map((member) {
                  return _memberTile(member);
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
            height: 500,
            child: ListView(
              children: noDataChecker(church.goats.map((member) {
                return _memberTile(member);
              }).toList()),
            ),
          ),
        ),
        AccordionSection(
          leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
          contentBorderRadius: 0,
          header: const Text('Deer', style: headerStyle),
          content: SizedBox(
            height: 500,
            child: ListView(
              children: noDataChecker(church.deer.map((member) {
                return _memberTile(member);
              }).toList()),
            ),
          ),
        ),
      ],
    );
  }
}

Column _memberTile(Member member) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);

  return Column(
    children: [
      ListTile(
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
