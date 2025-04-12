import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/membership/idl/models_idl.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ChurchIdlList extends StatefulWidget {
  const ChurchIdlList({Key? key, required this.church}) : super(key: key);

  final ChurchForIdlList church;

  @override
  State<ChurchIdlList> createState() => _ChurchIdlListState();
}

class _ChurchIdlListState extends State<ChurchIdlList> {
  @override
  Widget build(BuildContext context) {
    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Colors based on theme
    final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final backgroundColor = isDarkMode ? Colors.black12 : Colors.grey.shade50;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: noDataChecker(widget.church.idls.map((member) {
            return _buildMemberTile(context, member);
          }).toList()),
        ),
      ),
    );
  }

  Widget _buildMemberTile(BuildContext context, OutstandingVisitationForList member) {
    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Colors based on theme
    final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700;

    CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
    var memberState = context.watch<SharedState>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        color: cardColor,
        elevation: isDarkMode ? 2 : 1,
        shadowColor: isDarkMode ? Colors.black : Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () {
            memberState.memberId = member.id;
            memberState.member = member;
            Navigator.pushNamed(context, '/member-details');
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Avatar
                    Hero(
                      tag: 'member-${member.id}',
                      child: AvatarWithInitials(
                        foregroundImage: picture.image,
                        member: member,
                        radius: 30,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Member details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${member.firstName} ${member.lastName}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (member.visitationArea.isNotEmpty)
                            Text(
                              member.visitationArea,
                              style: TextStyle(
                                fontSize: 14,
                                color: subtitleColor,
                              ),
                            ),
                          if (member.status != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              member.status!,
                              style: TextStyle(
                                fontSize: 13,
                                color: subtitleColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Contact buttons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ContactIcon(
                          icon: Icons.phone,
                          color: PoimenTheme.phoneColor,
                          phoneNumber: member.phoneNumber,
                        ),
                        const SizedBox(width: 8),
                        ContactIcon(
                          icon: FontAwesomeIcons.whatsapp,
                          color: PoimenTheme.whatsappColor,
                          whatsAppInfo: WhatsAppInfo(
                            number: member.whatsappNumber,
                            firstName: member.firstName,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
