import 'package:poimen/screens/attendance/defaulters/service-attendance/council_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/campus_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/stream_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/duties/imcl/screen_bacenta_imcls.dart';
import 'package:poimen/screens/duties/imcl/screen_constituency_imcls.dart';
import 'package:poimen/screens/duties/imcl/screen_fellowship_imcls.dart';
import 'package:poimen/screens/duties/prayer/constituency_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/constituency_outstanding_prayer.dart';
import 'package:poimen/screens/duties/prayer/council_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/council_outstanding_prayer.dart';
import 'package:poimen/screens/duties/prayer/fellowship_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/fellowship_outstanding_prayer.dart';
import 'package:poimen/screens/duties/telepastoring/bacenta_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/constituency_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/bacenta_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/constituency_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/council_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/council_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/fellowship_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/fellowship_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/visitation/bacenta_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/bacenta_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/constituency_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/constituency_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/council_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/council_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/fellowship_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/fellowship_outstanding_visitations.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/constituency_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/council_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/stream_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/campus_bussing_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/constituency_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/council_by_constituency_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/campus_by_stream_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/stream_by_council_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_constituency_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_council_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_stream_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_campus_defaulters.dart';
import 'package:poimen/screens/attendance/report/screen_fellowship_report.dart';
import 'package:poimen/screens/attendance/report/screen_sunday_bussing_report.dart';
import 'package:poimen/screens/attendance/screen_sunday_bussing.dart';
import 'package:poimen/screens/attendance/screen_fellowship_services.dart';
import 'package:poimen/screens/attendance/ticker/screen_sunday_bussing_ticker.dart';
import 'package:poimen/screens/attendance/ticker/screen_fellowship_ticker.dart';
import 'package:poimen/screens/home/home.dart';
import 'package:poimen/screens/membership/details/screen_member_pastoral_comments.dart';
import 'package:poimen/screens/membership/upgrades/screen_member_spiritual_progresion.dart';
import 'package:poimen/screens/membership/upgrades/screen_member_life_progression.dart';
import 'package:poimen/screens/membership/upgrades/screen_update_life_progression.dart';
import 'package:poimen/screens/membership/idl/screen_fellowship_idls.dart';
import 'package:poimen/screens/membership/screen_bacenta_list.dart';
import 'package:poimen/screens/membership/screen_constituency_list.dart';
import 'package:poimen/screens/membership/screen_council_list.dart';
import 'package:poimen/screens/membership/screen_fellowship_list.dart';
import 'package:poimen/screens/membership/screen_campus_list.dart';
import 'package:poimen/screens/membership/details/screen_member_details.dart';
import 'package:poimen/screens/membership/screen_stream_list.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';
import 'package:poimen/screens/search/search_screen.dart';
import 'package:poimen/screens/trends/membership/screen_council_membership_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/screen_constituency_pastoral_work_cycles.dart';
import 'package:poimen/screens/trends/screen_fellowship_trends_menu.dart';
import 'package:poimen/screens/trends/screen_constituency_trends_menu.dart';
import 'package:poimen/screens/trends/screen_council_trends_menu.dart';
import 'package:poimen/screens/trends/screen_stream_trends_menu.dart';
import 'package:poimen/screens/trends/screen_campus_trends_menu.dart';
import 'package:poimen/screens/trends/membership/screen_fellowship_membership_trends.dart';
import 'package:poimen/screens/trends/membership/screen_constituency_membership_trends.dart';
import 'package:poimen/screens/trends/membership/screen_stream_membership_trends.dart';
import 'package:poimen/screens/trends/membership/screen_campus_membership_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/screen_fellowship_pastoral_work_cycles.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_constituency_subleaders.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_council_subleaders.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_stream_subleaders.dart';
import 'package:poimen/screens/trends/leaders_trends/screen_campus_subleaders.dart';

var appRoutes = {
  '/home': (context) => const Home(),
  '/search': (context) => const SearchScreen(),
  '/profile-choose': (context) => const ProfileChooseScreen(),

  // Display Member Details
  '/member-details': (context) => const MemberDetailsScreen(),
  '/member-pastoral-comments': (context) => const MemberPastoralCommentsScreen(),
  '/member-spiritual-progression': (context) => const MemberSpiritualProgressionsScreen(),
  '/member-life-progression': (context) => const MemberLifeProgressionsScreen(),
  '/membership-upgrades/life-progression': (context) => const UpdateLifeProgressionScreen(),

  // Display Members of Churches
  '/fellowship-members': (context) => const FellowshipMembershipScreen(),
  '/bacenta-members': (context) => const BacentaMembershipScreen(),
  '/constituency-members': (context) => const ConstituencyMembershipScreen(),
  '/council-members': (context) => const CouncilMembershipScreen(),
  '/stream-members': (context) => const StreamMembershipScreen(),
  '/campus-members': (context) => const CampusMembershipScreen(),

  // Display IDL list for Fellowship Church Levels
  '/fellowship-idls': (context) => const FellowshipIDLScreen(),

  // Display IMCL for Fellowship and Bacenta Levels
  '/fellowship-imcls': (context) => const FellowshipIMCLScreen(),
  '/bacenta-imcls': (context) => const BacentaIMCLScreen(),
  '/constituency-imcls': (context) => const ConstituencyIMCLScreen(),

  '/fellowship/outstanding-visitation': (context) => const FellowshipOutstandingVisitationScreen(),
  '/fellowship/completed-visitation': (context) => const FellowshipCompletedVisitationScreen(),
  '/bacenta/outstanding-visitation': (context) => const BacentaOutstandingVisitationScreen(),
  '/bacenta/completed-visitation': (context) => const BacentaCompletedVisitationScreen(),
  '/constituency/outstanding-visitation': (context) =>
      const ConstituencyOutstandingVisitationScreen(),
  '/constituency/completed-visitation': (context) => const ConstituencyCompletedVisitationScreen(),
  '/council/outstanding-visitation': (context) => const CouncilOutstandingVisitationScreen(),
  '/council/completed-visitation': (context) => const CouncilCompletedVisitationScreen(),

  '/fellowship/outstanding-telepastoring': (context) =>
      const FellowshipOutstandingTelepastoringScreen(),
  '/fellowship/completed-telepastoring': (context) =>
      const FellowshipCompletedTelepastoringScreen(),
  '/bacenta/outstanding-telepastoring': (context) => const BacentaOutstandingTelepastoringScreen(),
  '/bacenta/completed-telepastoring': (context) => const BacentaCompletedTelepastoringScreen(),
  '/constituency/outstanding-telepastoring': (context) =>
      const ConstituencyOutstandingTelepastoringScreen(),
  '/constituency/completed-telepastoring': (context) =>
      const ConstituencyCompletedTelepastoringScreen(),
  '/council/outstanding-telepastoring': (context) => const CouncilOutstandingTelepastoringScreen(),
  '/council/completed-telepastoring': (context) => const CouncilCompletedTelepastoringScreen(),

  '/fellowship/outstanding-prayer': (context) => const FellowshipOutstandingPrayerScreen(),
  '/fellowship/completed-prayer': (context) => const FellowshipCompletedPrayerScreen(),
  '/constituency/outstanding-prayer': (context) => const ConstituencyOutstandingPrayerScreen(),
  '/constituency/completed-prayer': (context) => const ConstituencyCompletedPrayerScreen(),
  '/council/outstanding-prayer': (context) => const CouncilOutstandingPrayerScreen(),
  '/council/completed-prayer': (context) => const CouncilCompletedPrayerScreen(),

  ////// ATTENDANCE ROUTES //////
  // Fellowship Attendance Screens
  '/servicerecord-services': (context) => const FellowshipServicesScreen(),
  '/servicerecord/attendance-ticker': (context) => const FellowshipAttendanceTickerScreen(),
  '/servicerecord/attendance-report': (context) => const FellowshipAttendanceReportScreen(),

  // Bacenta Attendance Screens
  '/bussingrecord-services': (context) => const SundayBussingScreen(),
  '/bussingrecord/attendance-ticker': (context) => const BussingRecordAttendanceTickerScreen(),
  '/bussingrecord/attendance-report': (context) => const BussingAttendanceReportScreen(),

// Attendance Defaulters
  '/constituency/service-attendance-defaulters': (context) =>
      const ConstituencyServiceAttendanceDefaultersScreen(),
  '/constituency/bussing-attendance-defaulters': (context) =>
      const ConstituencyBussingAttendanceDefaultersScreen(),
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

  '/constituency/attendance-defaulters': (context) =>
      const ConstituencyAttendanceDefaultersScreen(),
  '/council/attendance-defaulters': (context) => const CouncilAttendanceDefaultersScreen(),
  '/stream/attendance-defaulters': (context) => const StreamAttendanceDefaultersScreen(),
  '/campus/attendance-defaulters': (context) => const CampusAttendanceDefaultersScreen(),

  // Attendance Defaulters Grouped By SubChurch
  '/council-by-constituency/attendance-defaulters': (context) =>
      const CouncilByConstituencyAttendanceDefaultersScreen(),
  '/stream-by-council/attendance-defaulters': (context) =>
      const StreamByCouncilAttendanceDefaultersScreen(),
  '/campus-by-stream/attendance-defaulters': (context) =>
      const CampusByStreamAttendanceDefaultersScreen(),

  // Trends Screens
  '/fellowship-trends-menu': (context) => const FellowshipTrendsScreen(),
  '/constituency-trends-menu': (context) => const ConstituencyTrendsScreen(),
  '/council-trends-menu': (context) => const CouncilTrendsScreen(),
  '/stream-trends-menu': (context) => const StreamTrendsScreen(),
  '/campus-trends-menu': (context) => const CampusTrendsScreen(),

  '/trends/fellowship/membership-attendance': (context) =>
      const FellowshipMembershipAttendanceScreen(),
  '/trends/constituency/membership-attendance': (context) =>
      const ConstituencyMembershipAttendanceScreen(),
  '/trends/council/membership-attendance': (context) => const CouncilMembershipAttendanceScreen(),
  '/trends/stream/membership-attendance': (context) => const StreamMembershipAttendanceScreen(),
  '/trends/campus/membership-attendance': (context) => const CampusMembershipAttendanceScreen(),

  // Pastoral Care
  '/trends/fellowship/pastoral-work-cycles': (context) =>
      const FellowshipPastoralWorkCyclesScreen(),
  '/trends/constituency/pastoral-work-cycles': (context) =>
      const ConstituencyPastoralWorkCyclesScreen(),

// My Leaders Trends
  '/constituency-subleaders-trends': (context) => const ConstituencySubLeadersTrendsScreen(),
  '/council-subleaders-trends': (context) => const CouncilSubLeadersTrendsScreen(),
  '/stream-subleaders-trends': (context) => const StreamSubLeadersTrendsScreen(),
  '/campus-subleaders-trends': (context) => const CampusSubLeadersTrendsScreen(),
};
