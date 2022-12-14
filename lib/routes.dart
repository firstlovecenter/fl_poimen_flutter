import 'package:poimen/screens/duties/imcl/screen_bacenta_imcls.dart';
import 'package:poimen/screens/duties/imcl/screen_fellowship_imcls.dart';
import 'package:poimen/screens/duties/prayer/constituency_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/constituency_outstanding_prayer.dart';
import 'package:poimen/screens/duties/prayer/fellowship_completed_prayer.dart';
import 'package:poimen/screens/duties/prayer/fellowship_outstanding_prayer.dart';
import 'package:poimen/screens/duties/telepastoring/bacenta_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/constituency_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/bacenta_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/constituency_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/fellowship_completed_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/fellowship_outstanding_telepastoring.dart';
import 'package:poimen/screens/duties/visitation/bacenta_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/bacenta_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/constituency_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/constituency_outstanding_visitations.dart';
import 'package:poimen/screens/duties/visitation/fellowship_completed_visitations.dart';
import 'package:poimen/screens/duties/visitation/fellowship_outstanding_visitations.dart';
import 'package:poimen/screens/attendance/defaulters/bacenta-attendance/constituency_bacenta_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bacenta-attendance/council_bacenta_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bacenta-attendance/gathering_bacenta_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/bacenta-attendance/stream_bacenta_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/constituency_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/council_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/gathering_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/stream_fellowship_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/gathering_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/council_by_constituency_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/gathering_by_stream_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/stream_by_council_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_constituency_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_council_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/screen_stream_defaulters.dart';
import 'package:poimen/screens/attendance/report/screen_fellowship_report.dart';
import 'package:poimen/screens/attendance/report/screen_sunday_bussing_report.dart';
import 'package:poimen/screens/attendance/screen_sunday_bussing.dart';
import 'package:poimen/screens/attendance/screen_fellowship_services.dart';
import 'package:poimen/screens/attendance/ticker/screen_sunday_bussing_ticker.dart';
import 'package:poimen/screens/attendance/ticker/screen_fellowship_ticker.dart';
import 'package:poimen/screens/home/home.dart';
import 'package:poimen/screens/membership/details/screen_member_pastoral_comments.dart';
import 'package:poimen/screens/membership/upgrades/screen_audio_collections.dart';
import 'package:poimen/screens/membership/upgrades/screen_bible_translations.dart';
import 'package:poimen/screens/membership/upgrades/screen_camp_attendance.dart';
import 'package:poimen/screens/membership/upgrades/screen_membership_upgrades.dart';
import 'package:poimen/screens/membership/upgrades/screen_holy_ghost_baptism.dart';
import 'package:poimen/screens/membership/upgrades/screen_understanding_campaign.dart';
import 'package:poimen/screens/membership/upgrades/screen_water_baptism_upgrade.dart';
import 'package:poimen/screens/membership/idl/screen_fellowship_idls.dart';
import 'package:poimen/screens/membership/screen_bacenta_list.dart';
import 'package:poimen/screens/membership/screen_constituency_list.dart';
import 'package:poimen/screens/membership/screen_council_list.dart';
import 'package:poimen/screens/membership/screen_fellowship_list.dart';
import 'package:poimen/screens/membership/screen_gathering_list.dart';
import 'package:poimen/screens/membership/details/screen_member_details.dart';
import 'package:poimen/screens/membership/screen_stream_list.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';
import 'package:poimen/screens/search/search_screen.dart';

var appRoutes = {
  '/home': (context) => const Home(),
  '/search': (context) => const SearchScreen(),
  '/profile-choose': (context) => const ProfileChooseScreen(),

  // Display Member Details
  '/member-details': (context) => const MemberDetailsScreen(),
  '/member-pastoral-comments': (context) => const MemberPastoralCommentsScreen(),
  '/membership-upgrades': (context) => const MembershipUpgradesScreen(),
  '/membership-upgrades/holy-ghost-baptism': (context) => const HolyGhostBaptismScreen(),
  '/membership-upgrades/water-baptism': (context) => const WaterBaptismScreen(),
  '/membership-upgrades/audio-collections': (context) => const AudioCollectionsScreen(),
  '/membership-upgrades/bible-translations': (context) => const BibleTranslationsScreen(),
  '/membership-upgrades/understanding-campaign': (context) => const UnderstandingCampaignScreen(),
  '/membership-upgrades/camp-attendance': (context) => const CampAttendanceScreen(),

  // Display Members of Churches
  '/fellowship-members': (context) => const FellowshipMembershipScreen(),
  '/bacenta-members': (context) => const BacentaMembershipScreen(),
  '/constituency-members': (context) => const ConstituencyMembershipScreen(),
  '/council-members': (context) => const CouncilMembershipScreen(),
  '/stream-members': (context) => const StreamMembershipScreen(),
  '/gathering-members': (context) => const GatheringMembershipScreen(),

  // Display IDL list for Fellowship Church Levels
  '/fellowship-idls': (context) => const FellowshipIDLScreen(),

  //// PASTORAL DUTIES ///////
  // Display IMCL for Fellowship and Bacenta Levels
  '/fellowship-imcls': (context) => const FellowshipIMCLScreen(),
  '/bacenta-imcls': (context) => const BacentaIMCLScreen(),

  '/fellowship/outstanding-visitation': (context) => const FellowshipOutstandingVisitationScreen(),
  '/fellowship/completed-visitation': (context) => const FellowshipCompletedVisitationScreen(),
  '/bacenta/outstanding-visitation': (context) => const BacentaOutstandingVisitationScreen(),
  '/bacenta/completed-visitation': (context) => const BacentaCompletedVisitationScreen(),
  '/constituency/outstanding-visitation': (context) =>
      const ConstituencyOutstandingVisitationScreen(),
  '/constituency/completed-visitation': (context) => const ConstituencyCompletedVisitationScreen(),

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

  '/fellowship/outstanding-prayer': (context) => const FellowshipOutstandingPrayerScreen(),
  '/fellowship/completed-prayer': (context) => const FellowshipCompletedPrayerScreen(),
  '/constituency/outstanding-prayer': (context) => const ConstituencyOutstandingPrayerScreen(),
  '/constituency/completed-prayer': (context) => const ConstituencyCompletedPrayerScreen(),

  ////// ATTENDANCE ROUTES //////
  // Fellowship Attendance Screens
  '/servicerecord-services': (context) => const FellowshipServicesScreen(),
  '/servicerecord/attendance-ticker': (context) => const FellowshipAttendanceTickerScreen(),
  '/fellowship/attendance-report': (context) => const FellowshipAttendanceReportScreen(),

  // Bacenta Attendance Screens
  '/bussingrecord-services': (context) => const SundayBussingScreen(),
  '/bussingrecord/attendance-ticker': (context) => const BussingRecordAttendanceTickerScreen(),
  '/bussingrecord/attendance-report': (context) => const BussingAttendanceReportScreen(),

// Attendance Defaulters
  '/constituency/fellowship-attendance-defaulters': (context) =>
      const ConstituencyFellowshipAttendanceDefaultersScreen(),
  '/constituency/bacenta-attendance-defaulters': (context) =>
      const ConstituencyBacentaAttendanceDefaultersScreen(),
  '/council/fellowship-attendance-defaulters': (context) =>
      const CouncilFellowshipAttendanceDefaultersScreen(),
  '/council/bacenta-attendance-defaulters': (context) =>
      const CouncilBacentaAttendanceDefaultersScreen(),
  '/stream/fellowship-attendance-defaulters': (context) =>
      const StreamFellowshipAttendanceDefaultersScreen(),
  '/stream/bacenta-attendance-defaulters': (context) =>
      const StreamBacentaAttendanceDefaultersScreen(),
  '/gatheringservice/fellowship-attendance-defaulters': (context) =>
      const GatheringFellowshipAttendanceDefaultersScreen(),
  '/gatheringservice/bacenta-attendance-defaulters': (context) =>
      const GatheringBacentaAttendanceDefaultersScreen(),

  '/constituency/attendance-defaulters': (context) =>
      const ConstituencyAttendanceDefaultersScreen(),
  '/council/attendance-defaulters': (context) => const CouncilAttendanceDefaultersScreen(),
  '/stream/attendance-defaulters': (context) => const StreamAttendanceDefaultersScreen(),
  '/gathering/attendance-defaulters': (context) => const GatheringAttendanceDefaultersScreen(),

  // Attendance Defaulters Grouped By SubChurch
  '/council-by-constituency/attendance-defaulters': (context) =>
      const CouncilByConstituencyAttendanceDefaultersScreen(),
  '/stream-by-council/attendance-defaulters': (context) =>
      const StreamByCouncilAttendanceDefaultersScreen(),
  '/gathering-by-stream/attendance-defaulters': (context) =>
      const GatheringByStreamAttendanceDefaultersScreen(),
};
