import 'package:poimen/screens/attendance/defaulters/service-attendance/council_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/campus_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/stream_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/report/screen_governorship_report.dart';
import 'package:poimen/screens/attendance/report/screen_rehearsal_report.dart';
import 'package:poimen/screens/attendance/screen_hub_services.dart';
import 'package:poimen/screens/attendance/screen_record_attendance.dart';
import 'package:poimen/screens/attendance/ticker/screen_governorship_ticker.dart';
import 'package:poimen/screens/attendance/ticker/screen_rehearsal_ticker.dart';
import 'package:poimen/screens/duties/imcl/screen_bacenta_imcls.dart';
import 'package:poimen/screens/duties/imcl/screen_governorship_imcls.dart';
import 'package:poimen/screens/duties/imcl/screen_hub_imcls.dart';
import 'package:poimen/screens/duties/prayer/bacenta_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/bacenta_outstanding_prayer.dart';
import 'package:poimen/screens/duties/prayer/governorship_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/governorship_outstanding_prayer.dart';
import 'package:poimen/screens/duties/prayer/council_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/council_outstanding_prayer.dart';
import 'package:poimen/screens/duties/telepastoring/bacenta_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/governorship_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/bacenta_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/governorship_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/council_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/council_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/fellowship_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/fellowship_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/visitation/bacenta_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/bacenta_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/governorship_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/governorship_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/council_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/council_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/fellowship_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/fellowship_outstanding_visitations.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/governorship_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/council_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/stream_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/campus_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/governorship_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/council_by_governorship_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/campus_by_stream_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/stream_by_council_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_governorship_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_council_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_stream_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_campus_defaulters.dart';
import 'package:poimen/screens/attendance/report/screen_bacenta_report.dart';
import 'package:poimen/screens/attendance/report/screen_sunday_bussing_report.dart';
import 'package:poimen/screens/attendance/screen_sunday_bussing.dart';
import 'package:poimen/screens/attendance/screen_bacenta_services.dart';
import 'package:poimen/screens/attendance/ticker/screen_sunday_bussing_ticker.dart';
import 'package:poimen/screens/attendance/ticker/screen_bacenta_ticker.dart';
import 'package:poimen/screens/home/home.dart';
import 'package:poimen/screens/login_screen.dart';
import 'package:poimen/screens/membership/details/screen_member_pastoral_comments.dart';
import 'package:poimen/screens/membership/screen_hub_list.dart';
import 'package:poimen/screens/membership/upgrades/screen_member_spiritual_progresion.dart';
import 'package:poimen/screens/membership/upgrades/screen_member_life_progression.dart';
import 'package:poimen/screens/membership/upgrades/screen_update_life_progression.dart';
import 'package:poimen/screens/membership/idl/screen_bacenta_idls.dart';
import 'package:poimen/screens/membership/screen_bacenta_list.dart';
import 'package:poimen/screens/membership/screen_governorship_list.dart';
import 'package:poimen/screens/membership/screen_council_list.dart';
import 'package:poimen/screens/membership/screen_fellowship_list.dart';
import 'package:poimen/screens/membership/screen_campus_list.dart';
import 'package:poimen/screens/membership/details/screen_member_details.dart';
import 'package:poimen/screens/membership/screen_stream_list.dart';
import 'package:poimen/screens/membership/upgrades/screen_update_spiritual_progression.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';
import 'package:poimen/screens/search/search_screen.dart';
import 'package:poimen/screens/trends/membership/screen_council_membership_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/screen_governorship_pastoral_work_cycles.dart';
import 'package:poimen/screens/trends/screen_fellowship_trends_menu.dart';
import 'package:poimen/screens/trends/screen_governorship_trends_menu.dart';
import 'package:poimen/screens/trends/screen_council_trends_menu.dart';
import 'package:poimen/screens/trends/screen_stream_trends_menu.dart';
import 'package:poimen/screens/trends/screen_campus_trends_menu.dart';
import 'package:poimen/screens/trends/membership/screen_fellowship_membership_trends.dart';
import 'package:poimen/screens/trends/membership/screen_governorship_membership_trends.dart';
import 'package:poimen/screens/trends/membership/screen_stream_membership_trends.dart';
import 'package:poimen/screens/trends/membership/screen_campus_membership_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/screen_fellowship_pastoral_work_cycles.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_governorship_subleaders.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_council_subleaders.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_stream_subleaders.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_campus_subleaders.dart';

var appRoutes = {
  '/login': (context) => const LoginScreen(
        currentVersion: "1.3.0",
      ),
  '/home': (context) => const Home(),
  '/search': (context) => const SearchScreen(),
  '/profile-choose': (context) => const ProfileChooseScreen(),

  // Display Member Details
  '/member-details': (context) => const MemberDetailsScreen(),
  '/member-pastoral-comments': (context) =>
      const MemberPastoralCommentsScreen(),
  '/member-spiritual-progression': (context) =>
      const MemberSpiritualProgressionsScreen(),
  '/member-life-progression': (context) => const MemberLifeProgressionsScreen(),
  '/membership-upgrades/life-progression': (context) =>
      const UpdateLifeProgressionScreen(),
  '/membership-upgrades/spiritual-progression': (context) =>
      const UpdateSpiritualProgressionScreen(),

  // Display Members of Churches
  '/fellowship-members': (context) => const FellowshipMembershipScreen(),
  '/bacenta-members': (context) => const BacentaMembershipScreen(),
  '/governorship-members': (context) => const GovernorshipMembershipScreen(),
  '/council-members': (context) => const CouncilMembershipScreen(),
  '/stream-members': (context) => const StreamMembershipScreen(),
  '/campus-members': (context) => const CampusMembershipScreen(),
  '/hub-members': (context) => const HubMembershipScreen(),

  // Display IDL list for Fellowship Church Levels
  '/bacenta-idls': (context) => const BacentaIDLScreen(),

  // Display IMCL for Fellowship and Bacenta Levels
  '/bacenta-imcls': (context) => const BacentaIMCLScreen(),
  '/governorship-imcls': (context) => const GovernorshipIMCLScreen(),
  '/hub-imcls': (context) => const HubIMCLScreen(),

  '/fellowship/outstanding-visitation': (context) =>
      const FellowshipOutstandingVisitationScreen(),
  '/fellowship/completed-visitation': (context) =>
      const FellowshipCompletedVisitationScreen(),
  '/bacenta/outstanding-visitation': (context) =>
      const BacentaOutstandingVisitationScreen(),
  '/bacenta/completed-visitation': (context) =>
      const BacentaCompletedVisitationScreen(),
  '/governorship/outstanding-visitation': (context) =>
      const GovernorshipOutstandingVisitationScreen(),
  '/governorship/completed-visitation': (context) =>
      const GovernorshipCompletedVisitationScreen(),
  '/council/outstanding-visitation': (context) =>
      const CouncilOutstandingVisitationScreen(),
  '/council/completed-visitation': (context) =>
      const CouncilCompletedVisitationScreen(),

  '/fellowship/outstanding-telepastoring': (context) =>
      const FellowshipOutstandingTelepastoringScreen(),
  '/fellowship/completed-telepastoring': (context) =>
      const FellowshipCompletedTelepastoringScreen(),
  '/bacenta/outstanding-telepastoring': (context) =>
      const BacentaOutstandingTelepastoringScreen(),
  '/bacenta/completed-telepastoring': (context) =>
      const BacentaCompletedTelepastoringScreen(),
  '/governorship/outstanding-telepastoring': (context) =>
      const GovernorshipOutstandingTelepastoringScreen(),
  '/governorship/completed-telepastoring': (context) =>
      const GovernorshipCompletedTelepastoringScreen(),
  '/council/outstanding-telepastoring': (context) =>
      const CouncilOutstandingTelepastoringScreen(),
  '/council/completed-telepastoring': (context) =>
      const CouncilCompletedTelepastoringScreen(),

  '/bacenta/outstanding-prayer': (context) =>
      const BacentaOutstandingPrayerScreen(),
  '/bacenta/completed-prayer': (context) =>
      const BacentaCompletedPrayerScreen(),
  '/governorship/outstanding-prayer': (context) =>
      const GovernorshipOutstandingPrayerScreen(),
  '/governorship/completed-prayer': (context) =>
      const GovernorshipCompletedPrayerScreen(),
  '/council/outstanding-prayer': (context) =>
      const CouncilOutstandingPrayerScreen(),
  '/council/completed-prayer': (context) =>
      const CouncilCompletedPrayerScreen(),

  ////// ATTENDANCE ROUTES //////
  // Fellowship Attendance Screens
  '/record-attendance': (context) => const RecordAttendanceScreen(),
  '/servicerecord-services': (context) => const FellowshipServicesScreen(),
  '/servicerecord/attendance-ticker': (context) =>
      const BacentaAttendanceTickerScreen(),
  '/governorship/attendance-ticker': (context) =>
      const GovernorshipAttendanceTickerScreen(),
  '/servicerecord/attendance-report': (context) =>
      const BacentaAttendanceReportScreen(),
  '/meetings/attendance-report': (context) =>
      const GovernorshipAttendanceReportScreen(),

  // Bacenta Attendance Screens
  '/bussingrecord-services': (context) => const SundayBussingScreen(),
  '/bussingrecord/attendance-ticker': (context) =>
      const BussingRecordAttendanceTickerScreen(),
  '/bussingrecord/attendance-report': (context) =>
      const BussingAttendanceReportScreen(),

  // Hub Attendance Screens
  '/rehearsal-meetings': (context) => const HubRehearsalsScreen(),
  '/rehearsalrecord/attendance-ticker': (context) =>
      const HubAttendanceTickerScreen(),
  '/rehearsalrecord/attendance-report': (context) =>
      const HubAttendanceReportScreen(),

// Attendance Defaulters
  '/governorship/service-attendance-defaulters': (context) =>
      const GovernorshipServiceAttendanceDefaultersScreen(),
  '/governorship/bussing-attendance-defaulters': (context) =>
      const GovernorshipBussingAttendanceDefaultersScreen(),
  '/council/service-attendance-defaulters': (context) =>
      const CouncilServiceAttendanceDefaultersScreen(),
  '/council/bussing-attendance-defaulters': (context) =>
      const CouncilBussingAttendanceDefaultersScreen(),
  '/stream/service-attendance-defaulters': (context) =>
      const StreamServiceAttendanceDefaultersScreen(),
  '/stream/bussing-attendance-defaulters': (context) =>
      const StreamBussingAttendanceDefaultersScreen(),
  '/campus/service-attendance-defaulters': (context) =>
      const CampusFellowshipAttendanceDefaultersScreen(),
  '/campus/bussing-attendance-defaulters': (context) =>
      const CampusBussingAttendanceDefaultersScreen(),

  '/governorship/attendance-defaulters': (context) =>
      const GovernorshipAttendanceDefaultersScreen(),
  '/council/attendance-defaulters': (context) =>
      const CouncilAttendanceDefaultersScreen(),
  '/stream/attendance-defaulters': (context) =>
      const StreamAttendanceDefaultersScreen(),
  '/campus/attendance-defaulters': (context) =>
      const CampusAttendanceDefaultersScreen(),

  // Attendance Defaulters Grouped By SubChurch
  '/council-by-governorship/attendance-defaulters': (context) =>
      const CouncilByGovernorshipAttendanceDefaultersScreen(),
  '/stream-by-council/attendance-defaulters': (context) =>
      const StreamByCouncilAttendanceDefaultersScreen(),
  '/campus-by-stream/attendance-defaulters': (context) =>
      const CampusByStreamAttendanceDefaultersScreen(),

  // Trends Screens
  '/fellowship-trends-menu': (context) => const FellowshipTrendsScreen(),
  '/governorship-trends-menu': (context) => const GovernorshipTrendsScreen(),
  '/council-trends-menu': (context) => const CouncilTrendsScreen(),
  '/stream-trends-menu': (context) => const StreamTrendsScreen(),
  '/campus-trends-menu': (context) => const CampusTrendsScreen(),

  '/trends/fellowship/membership-attendance': (context) =>
      const FellowshipMembershipAttendanceScreen(),
  '/trends/governorship/membership-attendance': (context) =>
      const GovernorshipMembershipAttendanceScreen(),
  '/trends/council/membership-attendance': (context) =>
      const CouncilMembershipAttendanceScreen(),
  '/trends/stream/membership-attendance': (context) =>
      const StreamMembershipAttendanceScreen(),
  '/trends/campus/membership-attendance': (context) =>
      const CampusMembershipAttendanceScreen(),

  // Pastoral Care
  '/trends/fellowship/pastoral-work-cycles': (context) =>
      const FellowshipPastoralWorkCyclesScreen(),
  '/trends/governorship/pastoral-work-cycles': (context) =>
      const GovernorshipPastoralWorkCyclesScreen(),

// My Leaders Trends
  '/governorship-subleaders-trends': (context) =>
      const GovernorshipSubLeadersTrendsScreen(),
  '/council-subleaders-trends': (context) =>
      const CouncilSubLeadersTrendsScreen(),
  '/stream-subleaders-trends': (context) =>
      const StreamSubLeadersTrendsScreen(),
  '/campus-subleaders-trends': (context) =>
      const CampusSubLeadersTrendsScreen(),
};
