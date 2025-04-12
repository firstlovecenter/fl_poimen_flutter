import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';

class ChurchCompletedVisitationList extends StatefulWidget {
  const ChurchCompletedVisitationList({Key? key, required this.church}) : super(key: key);

  final ChurchForCompletedVisitationList church;

  @override
  State<ChurchCompletedVisitationList> createState() => _ChurchCompletedVisitationListState();
}

class _ChurchCompletedVisitationListState extends State<ChurchCompletedVisitationList> {
  final TextEditingController _searchController = TextEditingController();
  List<CompletedVisitationForList> _filteredMembers = [];

  @override
  void initState() {
    super.initState();
    _filteredMembers = widget.church.completedVisitations;
    _searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMembers = widget.church.completedVisitations.where((member) {
        final String memberName = '${member.firstName} ${member.lastName}'.toLowerCase();
        return memberName.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design variables
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Colors based on theme
    final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final backgroundColor = isDarkMode ? Colors.black12 : Colors.grey.shade50;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final searchBarColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

    // Calculate content width for larger screens
    final contentWidth = isDesktop
        ? size.width * 0.7
        : isTablet
            ? size.width * 0.9
            : size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: contentWidth,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Search bar
                if (widget.church.completedVisitations.length > 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search by name',
                        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
                            size: 16, color: PoimenTheme.brand),
                        filled: true,
                        fillColor: searchBarColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),

                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 8),

                      // Stats cards - using Wrap for responsive layout
                      Wrap(
                        spacing: 12.0,
                        runSpacing: 12.0,
                        alignment: WrapAlignment.center,
                        children: [
                          // Visits Remaining Card
                          _buildStatsCard(
                            context: context,
                            icon: FontAwesomeIcons.doorOpen,
                            iconColor: Colors.red,
                            title: 'Visits Remaining',
                            count: widget.church.outstandingVisitationsCount,
                            variant: TrailingCardAlertNumberVariant.red,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/${widget.church.typename.toLowerCase()}/outstanding-visitation',
                              );
                            },
                            backgroundColor: cardColor,
                            textColor: textColor,
                            isDarkMode: isDarkMode,
                          ),

                          // Visits Completed Card
                          _buildStatsCard(
                            context: context,
                            icon: FontAwesomeIcons.solidThumbsUp,
                            iconColor: Colors.green,
                            title: 'Visits Completed',
                            count: widget.church.completedVisitations.length,
                            variant: TrailingCardAlertNumberVariant.green,
                            backgroundColor: cardColor,
                            textColor: textColor,
                            isDarkMode: isDarkMode,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Section title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        child: Text(
                          'Completed Visitations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Member tiles
                      if (_filteredMembers.isEmpty && _searchController.text.isNotEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              'No members found matching "${_searchController.text}"',
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      else
                        ...noDataChecker(_filteredMembers.map((member) {
                          return _memberTile(context, member,
                              cardColor: cardColor, textColor: textColor, isDarkMode: isDarkMode);
                        }).toList()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildStatsCard({
  required BuildContext context,
  required IconData icon,
  required String title,
  required int count,
  required TrailingCardAlertNumberVariant variant,
  required Color backgroundColor,
  required Color textColor,
  required bool isDarkMode,
  Color? iconColor,
  VoidCallback? onTap,
}) {
  final size = MediaQuery.of(context).size;
  final isTablet = size.width >= 600;

  // Adjust card width based on screen size
  final cardWidth = isTablet ? 280.0 : size.width * 0.44;

  return SizedBox(
    width: cardWidth,
    child: Card(
      color: backgroundColor,
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
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: iconColor, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  TrailingCardAlertNumber(
                    number: count,
                    variant: variant,
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

Widget _memberTile(
  BuildContext context,
  CompletedVisitationForList member, {
  required Color cardColor,
  required Color textColor,
  required bool isDarkMode,
}) {
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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Hero(
                  tag: 'member-${member.id}',
                  child: AvatarWithInitials(
                    foregroundImage: picture.image,
                    member: member,
                    radius: 28,
                  ),
                ),
                title: Text(
                  '${member.firstName} ${member.lastName}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                subtitle: member.status != null
                    ? Text(
                        member.status!,
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                        ),
                      )
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ContactIcon(
                      icon: Icons.phone,
                      color: PoimenTheme.phoneColor,
                      phoneNumber: member.phoneNumber,
                    ),
                    const SizedBox(width: 6),
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
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
