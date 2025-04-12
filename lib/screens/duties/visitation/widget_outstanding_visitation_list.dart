import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/duties/visitation/widget_visitation_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChurchOutstandingVisitationList extends StatefulWidget {
  const ChurchOutstandingVisitationList({Key? key, required this.church}) : super(key: key);

  final ChurchForOutstandingVisitationList church;

  @override
  ChurchOutstandingVisitationListState createState() => ChurchOutstandingVisitationListState();
}

class ChurchOutstandingVisitationListState extends State<ChurchOutstandingVisitationList> {
  final TextEditingController _searchController = TextEditingController();
  List<OutstandingVisitationForList> _filteredMembers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _filteredMembers = widget.church.outstandingVisitations;
    _searchController.addListener(_filterMembers);

    // Simulate loading for better UX
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final String query = _searchController.text.toLowerCase();
    List<OutstandingVisitationForList> filteredList = [];
    for (OutstandingVisitationForList member in widget.church.outstandingVisitations) {
      final String memberName =
          '${member.firstName} ${member.lastName} ${member.visitationArea}'.toLowerCase();
      if (memberName.contains(query)) {
        filteredList.add(member);
      }
    }
    setState(() {
      _filteredMembers = filteredList;
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
    final subtitleColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                  child: Text(
                    'These people have not been visited during the current shepherding cycle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by name or location',
                      hintText: 'Name or location',
                      prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
                          size: 16, color: PoimenTheme.brand),
                      filled: true,
                      fillColor: searchBarColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),

                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AnimationLimiter(
                          child: ListView(
                            children: [
                              // Stats cards
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
                                    count: widget.church.outstandingVisitations.length,
                                    variant: TrailingCardAlertNumberVariant.red,
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
                                    count: widget.church.completedVisitationsCount,
                                    variant: TrailingCardAlertNumberVariant.green,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/${widget.church.typename.toLowerCase()}/completed-visitation',
                                      );
                                    },
                                    backgroundColor: cardColor,
                                    textColor: textColor,
                                    isDarkMode: isDarkMode,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Show empty state or member list
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
                                ...AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 375),
                                  childAnimationBuilder: (widget) => SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: noDataChecker(_filteredMembers.map((member) {
                                    return _buildVisitationMemberTile(
                                      context,
                                      member,
                                      cardColor: cardColor,
                                      textColor: textColor,
                                      subtitleColor: subtitleColor,
                                      isDarkMode: isDarkMode,
                                    );
                                  }).toList()),
                                ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _buildVisitationMemberTile(
    BuildContext context,
    OutstandingVisitationForList member, {
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required bool isDarkMode,
  }) {
    CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
    var memberState = context.watch<SharedState>();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Member information row
              InkWell(
                onTap: () {
                  memberState.memberId = member.id;
                  memberState.member = member;
                  Navigator.pushNamed(context, '/member-details');
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  if (member.location != null)
                    ElevatedButton.icon(
                      onPressed: () async {
                        final Uri launchUri = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${member.location?.latitude}%2C${member.location?.longitude}');

                        if (await canLaunchUrl(launchUri)) {
                          final bool nativeAppLaunchSucceeded = await launchUrl(
                            launchUri,
                            mode: LaunchMode.externalNonBrowserApplication,
                          );

                          if (!nativeAppLaunchSucceeded) {
                            await launchUrl(
                              launchUri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not launch map application'),
                              ),
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(PoimenTheme.whatsappColor),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(0),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.locationPin,
                        size: 16,
                      ),
                      label: const Text('Go to Location'),
                    ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showVisitationReportBottomSheet(context, member);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(PoimenTheme.brand),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.pencil,
                      size: 16,
                    ),
                    label: const Text('Record Visit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVisitationReportBottomSheet(BuildContext context, MemberForList member) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: OutstandingVisitationReportForm(member: member),
        );
      },
    );
  }
}
