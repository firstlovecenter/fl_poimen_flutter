import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_tile.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChurchMeetingsReport extends StatelessWidget {
  const ChurchMeetingsReport({Key? key, required this.church, required this.record})
      : super(key: key);

  final Church church;
  final MeetingsForReport record;

  @override
  Widget build(BuildContext context) {
    final int totalMembership = record.membersAbsent.length + record.membersPresent.length;
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    final bool isLargeScreen = screenSize.width > 1200;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    // Calculate attendance percentage
    final int presentCount = record.membersPresent.length;
    final double attendancePercentage =
        totalMembership > 0 ? (presentCount / totalMembership) * 100 : 0;

    // Define colors based on theme mode
    final Color cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final Color shadowColor = isDarkMode ? Colors.black54 : Colors.black12;
    final Color summaryCardColor =
        isDarkMode ? PoimenTheme.darkBrand : PoimenTheme.brand.withOpacity(0.05);
    final Color dividerColor = isDarkMode ? Colors.white24 : Colors.black12;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive layout setup
          final double contentWidth =
              isLargeScreen ? constraints.maxWidth * 0.7 : constraints.maxWidth;

          return Center(
            child: SizedBox(
              width: contentWidth,
              child: ListView(
                children: [
                  // Summary section with attendance statistics
                  Container(
                    margin: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
                    padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                    decoration: BoxDecoration(
                      color: summaryCardColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: isDarkMode ? Colors.white70 : PoimenTheme.brand,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Summary for ${record.serviceDate.humanReadable}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 16.0 : 20.0,
                                      color: isDarkMode ? Colors.white : PoimenTheme.brand,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    timeago.format(record.serviceDate.date),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : PoimenTheme.brandTextPrimary,
                                      fontSize: isSmallScreen ? 14.0 : 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatisticCard(
                              title: 'Total',
                              value: '$totalMembership',
                              icon: Icons.people,
                              isDarkMode: isDarkMode,
                              isSmallScreen: isSmallScreen,
                            ),
                            _StatisticCard(
                              title: 'Present',
                              value: '$presentCount',
                              icon: Icons.check_circle,
                              color: PoimenTheme.good,
                              isDarkMode: isDarkMode,
                              isSmallScreen: isSmallScreen,
                            ),
                            _StatisticCard(
                              title: 'Absent',
                              value: '${record.membersAbsent.length}',
                              icon: Icons.remove_circle,
                              color: PoimenTheme.bad,
                              isDarkMode: isDarkMode,
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: attendancePercentage / 100,
                            minHeight: 10,
                            backgroundColor: isDarkMode ? Colors.white24 : Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              attendancePercentage > 70
                                  ? PoimenTheme.good
                                  : attendancePercentage > 40
                                      ? PoimenTheme.warning
                                      : PoimenTheme.bad,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Attendance: ${attendancePercentage.toStringAsFixed(1)}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14.0 : 16.0,
                            color: isDarkMode ? Colors.white70 : PoimenTheme.brandTextPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Adaptive layout for member lists
                  _buildMemberSections(
                    context: context,
                    record: record,
                    totalMembership: totalMembership,
                    isSmallScreen: isSmallScreen,
                    cardColor: cardColor,
                    shadowColor: shadowColor,
                    dividerColor: dividerColor,
                    isDarkMode: isDarkMode,
                  ),

                  // Action buttons section
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/record-attendance', (route) => false);
                          },
                          icon: const Icon(Icons.list),
                          label: const Text('Go to Meetings List'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? PoimenTheme.darkBrand : PoimenTheme.brand,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 16.0 : 24.0,
                              vertical: 12.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMemberSections({
    required BuildContext context,
    required MeetingsForReport record,
    required int totalMembership,
    required bool isSmallScreen,
    required Color cardColor,
    required Color shadowColor,
    required Color dividerColor,
    required bool isDarkMode,
  }) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTabletOrLarger = screenSize.width >= 768;

    if (isTabletOrLarger) {
      // Tablet and desktop layout with two columns
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12.0 : 20.0,
          vertical: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _AttendanceCard(
                status: AttendanceStatus.absent,
                members: record.membersAbsent,
                title: 'Members Who Were Absent',
                count: '${record.membersAbsent.length}/$totalMembership',
                cardColor: cardColor,
                shadowColor: shadowColor,
                dividerColor: dividerColor,
                isDarkMode: isDarkMode,
                isSmallScreen: isSmallScreen,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _AttendanceCard(
                status: AttendanceStatus.present,
                members: record.membersPresent,
                title: 'Members Who Were Present',
                count: '${record.membersPresent.length}/$totalMembership',
                cardColor: cardColor,
                shadowColor: shadowColor,
                dividerColor: dividerColor,
                isDarkMode: isDarkMode,
                isSmallScreen: isSmallScreen,
              ),
            ),
          ],
        ),
      );
    } else {
      // Mobile layout with stacked cards
      return Column(
        children: [
          _AttendanceCard(
            status: AttendanceStatus.absent,
            members: record.membersAbsent,
            title: 'Members Who Were Absent',
            count: '${record.membersAbsent.length}/$totalMembership',
            cardColor: cardColor,
            shadowColor: shadowColor,
            dividerColor: dividerColor,
            isDarkMode: isDarkMode,
            isSmallScreen: isSmallScreen,
          ),
          const SizedBox(height: 16),
          _AttendanceCard(
            status: AttendanceStatus.present,
            members: record.membersPresent,
            title: 'Members Who Were Present',
            count: '${record.membersPresent.length}/$totalMembership',
            cardColor: cardColor,
            shadowColor: shadowColor,
            dividerColor: dividerColor,
            isDarkMode: isDarkMode,
            isSmallScreen: isSmallScreen,
          ),
        ],
      );
    }
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final bool isDarkMode;
  final bool isSmallScreen;

  const _StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    required this.isDarkMode,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = color ?? (isDarkMode ? Colors.white70 : PoimenTheme.brand);
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;

    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: isSmallScreen ? 28 : 36,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 18 : 22,
            color: textColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
}

enum AttendanceStatus { present, absent }

class _AttendanceCard extends StatelessWidget {
  final List<MemberForListWithBacenta> members;
  final String title;
  final String count;
  final AttendanceStatus status;
  final Color cardColor;
  final Color shadowColor;
  final Color dividerColor;
  final bool isDarkMode;
  final bool isSmallScreen;

  const _AttendanceCard({
    required this.members,
    required this.title,
    required this.count,
    required this.status,
    required this.cardColor,
    required this.shadowColor,
    required this.dividerColor,
    required this.isDarkMode,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor =
        status == AttendanceStatus.present ? PoimenTheme.good : PoimenTheme.bad;

    final IconData statusIcon =
        status == AttendanceStatus.present ? Icons.check_circle : Icons.remove_circle;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12.0 : 20.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and count
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Color.lerp(cardColor, statusColor, 0.2)
                  : Color.lerp(cardColor, statusColor, 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: isSmallScreen ? 20 : 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 14.0 : 16.0,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        count,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12.0 : 14.0,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(height: 1, thickness: 1, color: dividerColor),

          // Member list
          members.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'No members in this category',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: isDarkMode ? Colors.white54 : Colors.black38,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: members.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: dividerColor,
                  ),
                  itemBuilder: (context, index) {
                    return memberTile(context, members[index], members[index].bacenta);
                  },
                ),
        ],
      ),
    );
  }
}
