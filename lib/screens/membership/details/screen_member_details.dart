import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/duties/imcl/models_imcl.dart';
import 'package:poimen/screens/membership/details/gql_member_details.dart';
import 'package:poimen/screens/membership/details/screen_member_pastoral_comments.dart';
import 'package:poimen/screens/membership/details/widget_add_pastoral_comment.dart';
import 'package:poimen/screens/membership/details/widget_save_contact.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/member_status_chip.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getMemberDetails,
      variables: {'id': state.memberId},
      defaultPageTitle: 'Member Details',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        final member = Member.fromJson(data?['members'][0]);
        final picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.lg);

        // Responsive sizing
        final size = MediaQuery.of(context).size;
        final isTablet = size.width >= 600;
        final isDesktop = size.width >= 900;

        // Theme detection
        final brightness = MediaQuery.of(context).platformBrightness;
        final isDarkMode = brightness == Brightness.dark;

        // Derived styling variables
        final backgroundColor = isDarkMode ? Colors.black12 : Colors.grey.shade50;
        final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
        final headerBackgroundColor =
            isDarkMode ? PoimenTheme.darkBrand : PoimenTheme.brand.withOpacity(0.05);
        final shadowColor = isDarkMode ? Colors.black54 : Colors.black12;
        final textColor = isDarkMode ? Colors.white : Colors.black87;
        final subtitleColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700;
        final borderColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;
        final stickyNoteColor = isDarkMode ? Colors.amber.shade700 : Colors.yellow.shade200;
        final stickyNoteTextColor = isDarkMode ? Colors.white : Colors.black87;

        // Spacing scale
        final double baseSpacing = isTablet ? 16.0 : 12.0;
        final double headerSpacing = baseSpacing * 1.5;
        final double sectionSpacing = baseSpacing * 2;

        // Font sizes
        final double nameFontSize = isDesktop ? 30 : (isTablet ? 26 : 22);
        final double sectionHeaderSize = isDesktop ? 20 : (isTablet ? 18 : 16);
        final double contentFontSize = isDesktop ? 16 : 14;

        final headerStyle = TextStyle(
          fontSize: nameFontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
        );

        final sectionHeaderStyle = TextStyle(
          fontSize: sectionHeaderSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        );

        DateFormat formatter = DateFormat('yMMMEd');
        String lastAttendedServiceDate = member.lastAttendedServiceDate != null
            ? formatter.format(DateTime.parse(member.lastAttendedServiceDate.toString()))
            : '';

        // Calculate content width for responsive layout
        final double contentMaxWidth = isDesktop ? 1100 : double.infinity;
        final double contentPadding = isDesktop ? 24.0 : (isTablet ? 16.0 : 8.0);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Member Details',
            trailing: WidgetSaveContact(
              member: member,
            ),
          ),
          body: Container(
            color: backgroundColor,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: ListView(
                  padding: EdgeInsets.all(contentPadding),
                  children: [
                    // Profile header card with avatar, name, and status
                    Card(
                      elevation: isDarkMode ? 4 : 2,
                      shadowColor: shadowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: borderColor,
                          width: 1,
                        ),
                      ),
                      color: headerBackgroundColor,
                      child: Padding(
                        padding: EdgeInsets.all(headerSpacing),
                        child: Column(
                          children: [
                            Hero(
                              tag: 'member-${member.id}',
                              child: AvatarWithInitials(
                                foregroundImage: picture.image,
                                member: member,
                                radius: isDesktop ? 100 : (isTablet ? 90 : 80),
                              ),
                            ),
                            SizedBox(height: baseSpacing),
                            MemberStatusChip(member: member),
                            SizedBox(height: baseSpacing),
                            Text(
                              '${member.firstName} ${member.lastName}',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                            if (member.lastAttendedServiceDate != null) ...[
                              SizedBox(height: baseSpacing),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: baseSpacing, vertical: baseSpacing / 2),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? PoimenTheme.brand.withOpacity(0.2)
                                      : PoimenTheme.brand.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.calendarCheck,
                                      size: 14,
                                      color: PoimenTheme.brand,
                                    ),
                                    SizedBox(width: baseSpacing / 2),
                                    Text(
                                      'Last Attended: ',
                                      style: TextStyle(
                                        fontSize: contentFontSize,
                                        color: subtitleColor,
                                      ),
                                    ),
                                    Text(
                                      lastAttendedServiceDate,
                                      style: TextStyle(
                                        color: PoimenTheme.brand,
                                        fontWeight: FontWeight.bold,
                                        fontSize: contentFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: baseSpacing),

                    // Sticky note section
                    if (member.stickyNote != null && member.stickyNote?.trim() != '') ...[
                      Card(
                        elevation: isDarkMode ? 4 : 2,
                        shadowColor: shadowColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: stickyNoteColor,
                        child: Padding(
                          padding: EdgeInsets.all(headerSpacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.noteSticky,
                                    color: stickyNoteTextColor,
                                    size: sectionHeaderSize,
                                  ),
                                  SizedBox(width: baseSpacing),
                                  Text(
                                    'Sticky Note',
                                    style: TextStyle(
                                      color: stickyNoteTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: sectionHeaderSize,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: baseSpacing),
                              Text(
                                member.stickyNote ?? '',
                                style: TextStyle(
                                  color: stickyNoteTextColor,
                                  fontSize: contentFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: baseSpacing),
                    ],

                    // Church Attendance Section (Only for mobile view)
                    if (!isTablet && !isDesktop)
                      _buildSectionCard(
                        context: context,
                        title: 'Church Attendance',
                        icon: FontAwesomeIcons.chartLine,
                        isDarkMode: isDarkMode,
                        cardColor: cardColor,
                        textColor: textColor,
                        borderColor: borderColor,
                        shadowColor: shadowColor,
                        baseSpacing: baseSpacing,
                        headerSpacing: headerSpacing,
                        sectionHeaderStyle: sectionHeaderStyle,
                        content: Padding(
                          padding: EdgeInsets.all(baseSpacing),
                          child: Column(
                            children: [
                              // Attendance record visualization
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildAttendanceSection(
                                      title: 'WEEKDAY',
                                      services: member.lastFourWeekdayServices,
                                      isDarkMode: isDarkMode,
                                      isTablet: isTablet,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: baseSpacing),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildAttendanceSection(
                                      title: 'WEEKEND',
                                      services: member.lastFourWeekendServices,
                                      isDarkMode: isDarkMode,
                                      isTablet: isTablet,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (!isTablet && !isDesktop) SizedBox(height: baseSpacing),

                    // Member Growth Section (Only for mobile view)
                    if (!isTablet && !isDesktop)
                      _buildSectionCard(
                        context: context,
                        title: 'Member Growth',
                        icon: FontAwesomeIcons.personRays,
                        isDarkMode: isDarkMode,
                        cardColor: cardColor,
                        textColor: textColor,
                        borderColor: borderColor,
                        shadowColor: shadowColor,
                        baseSpacing: baseSpacing,
                        headerSpacing: headerSpacing,
                        sectionHeaderStyle: sectionHeaderStyle,
                        content: Padding(
                          padding: EdgeInsets.all(baseSpacing),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  _buildNavigationTile(
                                    context: context,
                                    title: 'Spiritual Progression',
                                    icon: FontAwesomeIcons.book,
                                    route: '/member-spiritual-progression',
                                    isDarkMode: isDarkMode,
                                  ),
                                  SizedBox(height: baseSpacing),
                                  _buildNavigationTile(
                                    context: context,
                                    title: 'Life Progression',
                                    icon: FontAwesomeIcons.baby,
                                    route: '/member-life-progression',
                                    isDarkMode: isDarkMode,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (!isTablet && !isDesktop) SizedBox(height: baseSpacing),

                    // Implement responsive multi-column layout for larger screens
                    if (isTablet || isDesktop)
                      _buildTabletLayout(
                        context: context,
                        member: member,
                        state: state,
                        isDarkMode: isDarkMode,
                        cardColor: cardColor,
                        textColor: textColor,
                        borderColor: borderColor,
                        shadowColor: shadowColor,
                        baseSpacing: baseSpacing,
                        headerSpacing: headerSpacing,
                        sectionHeaderStyle: sectionHeaderStyle,
                        contentFontSize: contentFontSize,
                      )
                    else
                      _buildMobileLayout(
                        context: context,
                        member: member,
                        state: state,
                        isDarkMode: isDarkMode,
                        cardColor: cardColor,
                        textColor: textColor,
                        borderColor: borderColor,
                        shadowColor: shadowColor,
                        baseSpacing: baseSpacing,
                        headerSpacing: headerSpacing,
                        sectionHeaderStyle: sectionHeaderStyle,
                        contentFontSize: contentFontSize,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );

        return returnValues;
      },
    );
  }

  // Helper method to build a consistent section card
  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isDarkMode,
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
    required Color shadowColor,
    required double baseSpacing,
    required double headerSpacing,
    required TextStyle sectionHeaderStyle,
    required Widget content,
  }) {
    return Card(
      elevation: isDarkMode ? 4 : 2,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(headerSpacing),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: PoimenTheme.brand,
                  size: sectionHeaderStyle.fontSize! * 1.2,
                ),
                SizedBox(width: baseSpacing),
                Text(
                  title,
                  style: sectionHeaderStyle,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: borderColor,
          ),
          content,
        ],
      ),
    );
  }

  // Build attendance visualization section
  Widget _buildAttendanceSection({
    required String title,
    required List<Last4Services> services,
    required bool isDarkMode,
    required bool isTablet,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: isDarkMode ? Colors.grey.shade800.withOpacity(0.5) : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 14 : 12,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            // Attendance dots
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: services.map((service) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    backgroundColor: service.present ? PoimenTheme.good : PoimenTheme.bad,
                    radius: isTablet ? 18 : 15,
                    child: Icon(
                      service.present ? FontAwesomeIcons.check : FontAwesomeIcons.xmark,
                      color: Colors.white,
                      size: isTablet ? 14 : 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Build consistent navigation tile
  Widget _buildNavigationTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
    required bool isDarkMode,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: isDarkMode ? PoimenTheme.brand.withOpacity(0.2) : PoimenTheme.brand.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isDarkMode ? PoimenTheme.brand.withOpacity(0.4) : PoimenTheme.brand.withOpacity(0.2),
          width: 1,
        ),
      ),
      elevation: isDarkMode ? 4 : 2,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: PoimenTheme.brand,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: PoimenTheme.brand,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create responsive tablet/desktop layout with two columns
  Widget _buildTabletLayout({
    required BuildContext context,
    required Member member,
    required SharedState state,
    required bool isDarkMode,
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
    required Color shadowColor,
    required double baseSpacing,
    required double headerSpacing,
    required TextStyle sectionHeaderStyle,
    required double contentFontSize,
  }) {
    // For tablet and desktop, use a more sophisticated layout with multiple columns
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    // Adjust spacing for larger screens
    final double columnSpacing = isDesktop ? baseSpacing * 2 : baseSpacing;

    // Custom card styles for larger screens
    final cardElevation = isDarkMode ? 4.0 : 2.0;
    final desktopRadius = isDesktop ? 16.0 : 12.0;

    return Column(
      children: [
        // First row - Attendance Statistics and Member Growth in a horizontal layout
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left card - Attendance Statistics (compact)
            Expanded(
              flex: 1,
              child: Card(
                elevation: cardElevation,
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(desktopRadius),
                  side: BorderSide(color: borderColor, width: 1),
                ),
                color: cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Padding(
                      padding: EdgeInsets.all(headerSpacing * 0.7),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.chartLine,
                            color: PoimenTheme.brand,
                            size: sectionHeaderStyle.fontSize! * 1.2,
                          ),
                          SizedBox(width: baseSpacing),
                          Text(
                            'Attendance Statistics',
                            style: sectionHeaderStyle,
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: borderColor),

                    // Compact attendance stats content
                    Padding(
                      padding: EdgeInsets.all(baseSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status and last attended row
                          Row(
                            children: [
                              // Status badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: baseSpacing,
                                  vertical: baseSpacing * 0.5,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(member.status, isDarkMode),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getStatusIcon(member.status),
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      member.status ?? 'No Status',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: contentFontSize - 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: baseSpacing),

                              // Last attended compact badge
                              if (member.lastAttendedServiceDate != null)
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: baseSpacing * 0.8,
                                      vertical: baseSpacing * 0.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? PoimenTheme.brand.withOpacity(0.2)
                                          : PoimenTheme.brand.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? PoimenTheme.brand.withOpacity(0.3)
                                            : PoimenTheme.brand.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.calendarCheck,
                                          size: 14,
                                          color: PoimenTheme.brand,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            'Last: ${DateFormat('MMM d, yyyy').format(DateTime.parse(member.lastAttendedServiceDate.toString()))}',
                                            style: TextStyle(
                                              color: PoimenTheme.brand,
                                              fontWeight: FontWeight.bold,
                                              fontSize: contentFontSize - 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(height: baseSpacing * 0.8),

                          // Compact attendance visualization
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Weekday attendance
                              Expanded(
                                child: _buildCompactAttendanceRow(
                                  title: 'WEEKDAY',
                                  services: member.lastFourWeekdayServices,
                                  isDarkMode: isDarkMode,
                                  baseSpacing: baseSpacing,
                                  fontSize: contentFontSize - 2,
                                ),
                              ),

                              SizedBox(width: baseSpacing * 0.5),

                              // Weekend attendance
                              Expanded(
                                child: _buildCompactAttendanceRow(
                                  title: 'WEEKEND',
                                  services: member.lastFourWeekendServices,
                                  isDarkMode: isDarkMode,
                                  baseSpacing: baseSpacing,
                                  fontSize: contentFontSize - 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: columnSpacing),

            // Right card - Member Growth (compact)
            Expanded(
              flex: 1,
              child: Card(
                elevation: cardElevation,
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(desktopRadius),
                  side: BorderSide(color: borderColor, width: 1),
                ),
                color: cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Padding(
                      padding: EdgeInsets.all(headerSpacing * 0.7),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.personRays,
                            color: PoimenTheme.brand,
                            size: sectionHeaderStyle.fontSize! * 1.2,
                          ),
                          SizedBox(width: baseSpacing),
                          Text(
                            'Member Growth',
                            style: sectionHeaderStyle,
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: borderColor),

                    // Compact growth content
                    Padding(
                      padding: EdgeInsets.all(baseSpacing),
                      child: Row(
                        children: [
                          // Spiritual Progression
                          Expanded(
                            child: _buildCompactNavigationTile(
                              context: context,
                              title: 'Spiritual Progression',
                              icon: FontAwesomeIcons.book,
                              route: '/member-spiritual-progression',
                              isDarkMode: isDarkMode,
                              baseSpacing: baseSpacing,
                            ),
                          ),

                          SizedBox(width: baseSpacing),

                          // Life Progression
                          Expanded(
                            child: _buildCompactNavigationTile(
                              context: context,
                              title: 'Life Progression',
                              icon: FontAwesomeIcons.baby,
                              route: '/member-life-progression',
                              isDarkMode: isDarkMode,
                              baseSpacing: baseSpacing,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: columnSpacing),

        // Second row - Bio Data and Contact in first column, Church Info and Pastoral Comments in second
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column (Bio + Contact)
            Expanded(
              flex: isDesktop ? 5 : 1,
              child: Column(
                children: [
                  // Bio Data
                  Card(
                    elevation: cardElevation,
                    shadowColor: shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(desktopRadius),
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                    color: cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header
                        Padding(
                          padding: EdgeInsets.all(headerSpacing),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.idCard,
                                color: PoimenTheme.brand,
                                size: sectionHeaderStyle.fontSize! * 1.2,
                              ),
                              SizedBox(width: baseSpacing),
                              Text(
                                'Bio Data',
                                style: sectionHeaderStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1, thickness: 1, color: borderColor),

                        // Bio data content
                        Padding(
                          padding: EdgeInsets.all(baseSpacing),
                          child: Column(
                            children: [
                              BioDetailsCard(
                                title: 'First Name',
                                detail: member.firstName,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Middle Name',
                                detail: member.middleName,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Last Name',
                                detail: member.lastName,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Sex',
                                detail: member.gender.gender.name,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Date of Birth',
                                detail: member.dob.humanReadable,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: baseSpacing),

                  // Contact Information
                  Card(
                    elevation: cardElevation,
                    shadowColor: shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(desktopRadius),
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                    color: cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header with save contact button
                        Padding(
                          padding: EdgeInsets.all(headerSpacing),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.addressBook,
                                    color: PoimenTheme.brand,
                                    size: sectionHeaderStyle.fontSize! * 1.2,
                                  ),
                                  SizedBox(width: baseSpacing),
                                  Text(
                                    'Contact Information',
                                    style: sectionHeaderStyle,
                                  ),
                                ],
                              ),
                              WidgetSaveContact(member: member),
                            ],
                          ),
                        ),
                        Divider(height: 1, thickness: 1, color: borderColor),

                        // Contact data content
                        Padding(
                          padding: EdgeInsets.all(baseSpacing),
                          child: Column(
                            children: [
                              BioDetailsCard(
                                title: 'Phone Number',
                                detail: '+${member.phoneNumber}',
                                phoneNumber: member.phoneNumber,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Whatsapp Number',
                                detail: '+${member.whatsappNumber}',
                                whatsAppInfo: WhatsAppInfo(
                                    firstName: member.firstName, number: member.whatsappNumber),
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: columnSpacing),

            // Right column (Church Information + Pastoral Comments)
            Expanded(
              flex: isDesktop ? 5 : 1,
              child: Column(
                children: [
                  // Church Information
                  Card(
                    elevation: cardElevation,
                    shadowColor: shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(desktopRadius),
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                    color: cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header
                        Padding(
                          padding: EdgeInsets.all(headerSpacing),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.church,
                                color: PoimenTheme.brand,
                                size: sectionHeaderStyle.fontSize! * 1.2,
                              ),
                              SizedBox(width: baseSpacing),
                              Text(
                                'Church Information',
                                style: sectionHeaderStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1, thickness: 1, color: borderColor),

                        // Church info content
                        Padding(
                          padding: EdgeInsets.all(baseSpacing),
                          child: Column(
                            children: [
                              BioDetailsCard(
                                title: 'Council',
                                detail: member.council.name,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Bacenta',
                                detail: member.bacenta.name,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              if (member.bacenta.leader != null &&
                                  member.bacenta.leader!.id != member.id)
                                InkWell(
                                  onTap: () {
                                    state.memberId = member.bacenta.leader!.id;
                                    Navigator.pushNamed(
                                      context,
                                      '/member-details',
                                      arguments: member.bacenta.leader,
                                    );
                                  },
                                  child: BioDetailsCard(
                                    title: 'Bacenta Leader',
                                    detail:
                                        '${member.bacenta.leader!.firstName} ${member.bacenta.leader!.lastName}',
                                    phoneNumber: member.bacenta.leader!.phoneNumber,
                                    whatsAppInfo: WhatsAppInfo(
                                        firstName: member.bacenta.leader!.firstName,
                                        number: member.bacenta.leader!.whatsappNumber),
                                    isDarkMode: isDarkMode,
                                    fontSize: contentFontSize,
                                  ),
                                ),
                              BioDetailsCard(
                                title: 'Ministry',
                                detail: member.ministry?.name ?? '',
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                              BioDetailsCard(
                                title: 'Visitation Area',
                                detail: member.visitationArea,
                                isDarkMode: isDarkMode,
                                fontSize: contentFontSize,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: baseSpacing),

                  // Pastoral Comments
                  if (member.pastoralComments != null && member.pastoralComments!.isNotEmpty)
                    Card(
                      elevation: cardElevation,
                      shadowColor: shadowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(desktopRadius),
                        side: BorderSide(color: borderColor, width: 1),
                      ),
                      color: cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section header with add comment button
                          Padding(
                            padding: EdgeInsets.all(headerSpacing),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.commentDots,
                                      color: PoimenTheme.brand,
                                      size: sectionHeaderStyle.fontSize! * 1.2,
                                    ),
                                    SizedBox(width: baseSpacing),
                                    Text(
                                      'Pastoral Comments',
                                      style: sectionHeaderStyle,
                                    ),
                                  ],
                                ),
                                WidgetAddPastoralComment(member: member),
                              ],
                            ),
                          ),
                          Divider(height: 1, thickness: 1, color: borderColor),

                          // Comments content
                          Padding(
                            padding: EdgeInsets.all(baseSpacing),
                            child: Column(
                              children: [
                                ...member.pastoralComments!.take(isDesktop ? 4 : 3).map((comment) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: baseSpacing),
                                    child: PastoralCommentCard(
                                      comment: comment,
                                      isDarkMode: isDarkMode,
                                    ),
                                  );
                                }).toList(),
                                if (member.pastoralComments!.length > (isDesktop ? 4 : 3))
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: baseSpacing),
                                    child: Center(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/member-pastoral-comments',
                                            arguments: member,
                                          );
                                        },
                                        icon: const Icon(FontAwesomeIcons.clipboardList),
                                        label: Text(
                                            'View All ${member.pastoralComments!.length} Comments'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: PoimenTheme.brand,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: baseSpacing * 1.5,
                                            vertical: baseSpacing,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    _buildEmptyCommentsCard(
                      context: context,
                      member: member,
                      isDarkMode: isDarkMode,
                      cardColor: cardColor,
                      borderColor: borderColor,
                      headerSpacing: headerSpacing,
                      baseSpacing: baseSpacing,
                      sectionHeaderStyle: sectionHeaderStyle,
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper method for compact attendance visualization
  Widget _buildCompactAttendanceRow({
    required String title,
    required List<Last4Services> services,
    required bool isDarkMode,
    required double baseSpacing,
    required double fontSize,
  }) {
    // Calculate attendance percentage
    final int presentCount = services.where((service) => service.present).length;
    final double attendanceRate = services.isEmpty ? 0 : (presentCount / services.length) * 100;

    return Container(
      padding: EdgeInsets.all(baseSpacing * 0.6),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800.withOpacity(0.5) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row with attendance rate
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize - 1,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Text(
                '${attendanceRate.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize - 1,
                  color: _getAttendanceColor(attendanceRate, isDarkMode),
                ),
              ),
            ],
          ),

          SizedBox(height: baseSpacing * 0.4),

          // Compact attendance dots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: services.map((service) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundColor: service.present ? PoimenTheme.good : PoimenTheme.bad,
                    radius: 12,
                    child: Icon(
                      service.present ? FontAwesomeIcons.check : FontAwesomeIcons.xmark,
                      color: Colors.white,
                      size: 9,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    DateFormat('d MMM').format(service.date),
                    style: TextStyle(
                      fontSize: fontSize - 4,
                      color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Compact navigation tile for the horizontal layout
  Widget _buildCompactNavigationTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
    required bool isDarkMode,
    required double baseSpacing,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: isDarkMode ? PoimenTheme.brand.withOpacity(0.2) : PoimenTheme.brand.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isDarkMode ? PoimenTheme.brand.withOpacity(0.4) : PoimenTheme.brand.withOpacity(0.2),
          width: 1,
        ),
      ),
      elevation: isDarkMode ? 4 : 2,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(baseSpacing * 0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(baseSpacing * 0.5),
                decoration: BoxDecoration(
                  color: PoimenTheme.brand,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              SizedBox(width: baseSpacing * 0.5),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: PoimenTheme.brand,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Compact coming soon tile for the horizontal layout
  Widget _buildCompactComingSoonTile({
    required String title,
    required IconData icon,
    required bool isDarkMode,
    required double baseSpacing,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: isDarkMode ? Colors.grey.shade800.withOpacity(0.6) : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      elevation: isDarkMode ? 4 : 2,
      child: Padding(
        padding: EdgeInsets.all(baseSpacing * 0.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(baseSpacing * 0.5),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                size: 15,
              ),
            ),
            SizedBox(width: baseSpacing * 0.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Coming soon',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper for getting status color
  Color _getStatusColor(String? status, bool isDarkMode) {
    if (status == null) return Colors.grey;

    switch (status.toLowerCase()) {
      case 'sheep':
        return Colors.green;
      case 'goat':
        return Colors.orange;
      case 'deer':
        return Colors.red;
      default:
        return isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500;
    }
  }

  // Helper for getting status icon
  IconData _getStatusIcon(String? status) {
    if (status == null) return FontAwesomeIcons.question;

    switch (status.toLowerCase()) {
      case 'sheep':
        return FontAwesomeIcons.faceSmile;
      case 'goat':
        return FontAwesomeIcons.faceMeh;
      case 'deer':
        return FontAwesomeIcons.faceSadTear;
      default:
        return FontAwesomeIcons.question;
    }
  }

  // Helper for getting attendance color
  Color _getAttendanceColor(double rate, bool isDarkMode) {
    if (rate >= 75) {
      return Colors.green;
    } else if (rate >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  // Empty comments card with call to action
  Widget _buildEmptyCommentsCard({
    required BuildContext context,
    required Member member,
    required bool isDarkMode,
    required Color cardColor,
    required Color borderColor,
    required double headerSpacing,
    required double baseSpacing,
    required TextStyle sectionHeaderStyle,
  }) {
    return Card(
      elevation: isDarkMode ? 4 : 2,
      shadowColor: isDarkMode ? Colors.black54 : Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 1),
      ),
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: EdgeInsets.all(headerSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.commentDots,
                      color: PoimenTheme.brand,
                      size: sectionHeaderStyle.fontSize! * 1.2,
                    ),
                    SizedBox(width: baseSpacing),
                    Text(
                      'Pastoral Comments',
                      style: sectionHeaderStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: borderColor),

          // Empty state with call to action
          Padding(
            padding: EdgeInsets.all(baseSpacing * 2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.comments,
                    size: 40,
                    color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                  ),
                  SizedBox(height: baseSpacing),
                  Text(
                    'No pastoral comments yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: baseSpacing / 2),
                  Text(
                    'Add the first pastoral comment for this member',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: baseSpacing * 1.5),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Show the add comment modal
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(baseSpacing * 2),
                              child: WidgetAddPastoralComment(member: member),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.plus),
                    label: const Text('Add Comment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PoimenTheme.brand,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: baseSpacing * 1.5,
                        vertical: baseSpacing,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create mobile layout with stacked sections
  Widget _buildMobileLayout({
    required BuildContext context,
    required Member member,
    required SharedState state,
    required bool isDarkMode,
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
    required Color shadowColor,
    required double baseSpacing,
    required double headerSpacing,
    required TextStyle sectionHeaderStyle,
    required double contentFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio Data Section
        _buildSectionCard(
          context: context,
          title: 'Bio Data',
          icon: FontAwesomeIcons.idCard,
          isDarkMode: isDarkMode,
          cardColor: cardColor,
          textColor: textColor,
          borderColor: borderColor,
          shadowColor: shadowColor,
          baseSpacing: baseSpacing,
          headerSpacing: headerSpacing,
          sectionHeaderStyle: sectionHeaderStyle,
          content: Padding(
            padding: EdgeInsets.all(baseSpacing),
            child: Column(
              children: [
                BioDetailsCard(
                  title: 'First Name',
                  detail: member.firstName,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Middle Name',
                  detail: member.middleName,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Last Name',
                  detail: member.lastName,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Sex',
                  detail: member.gender.gender.name,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Date of Birth',
                  detail: member.dob.humanReadable,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: baseSpacing),

        // Contact Information Section
        _buildSectionCard(
          context: context,
          title: 'Contact Information',
          icon: FontAwesomeIcons.addressBook,
          isDarkMode: isDarkMode,
          cardColor: cardColor,
          textColor: textColor,
          borderColor: borderColor,
          shadowColor: shadowColor,
          baseSpacing: baseSpacing,
          headerSpacing: headerSpacing,
          sectionHeaderStyle: sectionHeaderStyle,
          content: Padding(
            padding: EdgeInsets.all(baseSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: baseSpacing, bottom: baseSpacing),
                  child: WidgetSaveContact(member: member),
                ),
                BioDetailsCard(
                  title: 'Phone Number',
                  detail: '+${member.phoneNumber}',
                  phoneNumber: member.phoneNumber,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Whatsapp Number',
                  detail: '+${member.whatsappNumber}',
                  whatsAppInfo:
                      WhatsAppInfo(firstName: member.firstName, number: member.whatsappNumber),
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: baseSpacing),

        // Church Information Section
        _buildSectionCard(
          context: context,
          title: 'Church Information',
          icon: FontAwesomeIcons.church,
          isDarkMode: isDarkMode,
          cardColor: cardColor,
          textColor: textColor,
          borderColor: borderColor,
          shadowColor: shadowColor,
          baseSpacing: baseSpacing,
          headerSpacing: headerSpacing,
          sectionHeaderStyle: sectionHeaderStyle,
          content: Padding(
            padding: EdgeInsets.all(baseSpacing),
            child: Column(
              children: [
                BioDetailsCard(
                  title: 'Council',
                  detail: member.council.name,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Bacenta',
                  detail: member.bacenta.name,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                if (member.bacenta.leader != null && member.bacenta.leader!.id != member.id)
                  InkWell(
                    onTap: () {
                      state.memberId = member.bacenta.leader!.id;
                      Navigator.pushNamed(
                        context,
                        '/member-details',
                        arguments: member.bacenta.leader,
                      );
                    },
                    child: BioDetailsCard(
                      title: 'Bacenta Leader',
                      detail:
                          '${member.bacenta.leader!.firstName} ${member.bacenta.leader!.lastName}',
                      phoneNumber: member.bacenta.leader!.phoneNumber,
                      whatsAppInfo: WhatsAppInfo(
                          firstName: member.bacenta.leader!.firstName,
                          number: member.bacenta.leader!.whatsappNumber),
                      isDarkMode: isDarkMode,
                      fontSize: contentFontSize,
                    ),
                  ),
                BioDetailsCard(
                  title: 'Ministry',
                  detail: member.ministry?.name ?? '',
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
                BioDetailsCard(
                  title: 'Visitation Area',
                  detail: member.visitationArea,
                  isDarkMode: isDarkMode,
                  fontSize: contentFontSize,
                ),
              ],
            ),
          ),
        ),

        // Display Pastoral Comments Section if available
        if (member.pastoralComments != null && member.pastoralComments!.isNotEmpty) ...[
          SizedBox(height: baseSpacing),
          _buildSectionCard(
            context: context,
            title: 'Pastoral Comments',
            icon: FontAwesomeIcons.commentDots,
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            textColor: textColor,
            borderColor: borderColor,
            shadowColor: shadowColor,
            baseSpacing: baseSpacing,
            headerSpacing: headerSpacing,
            sectionHeaderStyle: sectionHeaderStyle,
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(baseSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WidgetAddPastoralComment(member: member),
                    ],
                  ),
                ),
                ...member.pastoralComments!.take(2).map((comment) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: baseSpacing, vertical: baseSpacing / 2),
                    child: PastoralCommentCard(
                      comment: comment,
                      isDarkMode: isDarkMode,
                    ),
                  );
                }).toList(),
                if (member.pastoralComments!.length > 2)
                  Padding(
                    padding: EdgeInsets.all(baseSpacing * 1.5),
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/member-pastoral-comments',
                            arguments: member,
                          );
                        },
                        icon: const Icon(FontAwesomeIcons.angleRight),
                        label: const Text('View All Comments'),
                        style: TextButton.styleFrom(
                          foregroundColor: PoimenTheme.brand,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ] else ...[
          SizedBox(height: baseSpacing),
          _buildSectionCard(
            context: context,
            title: 'Pastoral Comments',
            icon: FontAwesomeIcons.commentDots,
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            textColor: textColor,
            borderColor: borderColor,
            shadowColor: shadowColor,
            baseSpacing: baseSpacing,
            headerSpacing: headerSpacing,
            sectionHeaderStyle: sectionHeaderStyle,
            content: Padding(
              padding: EdgeInsets.all(baseSpacing * 1.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.comments,
                      size: 32,
                      color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                    ),
                    SizedBox(height: baseSpacing),
                    Text(
                      'No pastoral comments yet',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: baseSpacing),
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(baseSpacing * 1.5),
                                child: WidgetAddPastoralComment(member: member),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.plus),
                      label: const Text('Add Comment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PoimenTheme.brand,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: baseSpacing,
                          vertical: baseSpacing / 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class WeekendCard extends StatelessWidget {
  const WeekendCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Card(
      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class BioDetailsCard extends StatelessWidget {
  const BioDetailsCard({
    Key? key,
    required this.title,
    required this.detail,
    this.phoneNumber,
    this.whatsAppInfo,
    this.isDarkMode = false,
    this.fontSize = 15,
  }) : super(key: key);

  final String title;
  final String detail;
  final String? phoneNumber;
  final WhatsAppInfo? whatsAppInfo;
  final bool isDarkMode;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    if (detail == '') {
      return Container();
    }

    final titleStyle = TextStyle(
      fontSize: fontSize,
      color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
    );

    final detailStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: isDarkMode ? Colors.white : Colors.black87,
    );

    List<Widget> contacts = [];

    if (phoneNumber != null) {
      contacts.add(ContactIcon(
        icon: Icons.phone,
        color: PoimenTheme.phoneColor,
        phoneNumber: phoneNumber,
      ));
    }

    if (whatsAppInfo != null) {
      contacts.add(
        ContactIcon(
          icon: FontAwesomeIcons.whatsapp,
          color: PoimenTheme.whatsappColor,
          whatsAppInfo: whatsAppInfo,
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isDarkMode ? 2 : 1,
      shadowColor: isDarkMode ? Colors.black54 : Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: ListTile(
        title: Text(title, style: titleStyle),
        subtitle: Text(detail, style: detailStyle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: contacts,
        ),
      ),
    );
  }
}

class PastoralCommentCard extends StatelessWidget {
  final PastoralComments comment;
  final bool isDarkMode;

  const PastoralCommentCard({
    Key? key,
    required this.comment,
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date for display
    final commentDate = comment.timestamp;
    final dateFormatted = DateFormat('MMM d, yyyy').format(commentDate);

    return Card(
      elevation: isDarkMode ? 2 : 1,
      shadowColor: isDarkMode ? Colors.black54 : Colors.black12,
      color: isDarkMode ? Colors.grey.shade800.withOpacity(0.6) : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: PoimenTheme.brand.withOpacity(0.2),
                  child: Icon(
                    FontAwesomeIcons.userPen,
                    size: 16,
                    color: PoimenTheme.brand,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${comment.author.firstName} ${comment.author.lastName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        dateFormatted,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              comment.comment,
              style: TextStyle(
                color: isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
