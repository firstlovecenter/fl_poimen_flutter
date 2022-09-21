import 'package:poimen/screens/attendance/report/screen_fellowship_report.dart';
import 'package:poimen/screens/attendance/screen_bacenta_services.dart';
import 'package:poimen/screens/attendance/screen_fellowship_services.dart';
import 'package:poimen/screens/attendance/report/screen_bacenta_report.dart';
import 'package:poimen/screens/attendance/ticker/screen_bacenta_ticker.dart';
import 'package:poimen/screens/attendance/ticker/screen_fellowship_ticker.dart';
import 'package:poimen/screens/home/home.dart';
import 'package:poimen/screens/membership/idl/screen_fellowship_idls.dart';
import 'package:poimen/screens/membership/screen_bacenta_list.dart';
import 'package:poimen/screens/membership/screen_constituency_list.dart';
import 'package:poimen/screens/membership/screen_council_list.dart';
import 'package:poimen/screens/membership/screen_fellowship_list.dart';
import 'package:poimen/screens/membership/screen_gathering_list.dart';
import 'package:poimen/screens/membership/screen_member_details.dart';
import 'package:poimen/screens/membership/screen_stream_list.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';

var appRoutes = {
  '/home': (context) => const Home(),
  '/profile-choose': (context) => const ProfileChooseScreen(),

  // Display Member Details
  '/member-details': (context) => const MemberDetailsScreen(),

  // Display Members of Churches
  '/fellowship-members': (context) => const FellowshipMembershipScreen(),
  '/bacenta-members': (context) => const BacentaMembershipScreen(),
  '/constituency-members': (context) => const ConstituencyMembershipScreen(),
  '/council-members': (context) => const CouncilMembershipScreen(),
  '/stream-members': (context) => const StreamMembershipScreen(),
  '/gatheringservice-members': (context) => const GatheringMembershipScreen(),

  // Display IDL list for Fellowship Church Levels
  '/fellowship-idls': (context) => const FellowshipIDLScreen(),

  ////// ATTENDANCE ROUTES //////
  // Fellowship Attendance Screens
  '/fellowship-services': (context) => const FellowshipServicesScreen(),
  '/fellowship/attendance-ticker': (context) => const FellowshipAttendanceTickerScreen(),
  '/fellowship/attendance-report': (context) => const FellowshipAttendanceReportScreen(),

  // Bacenta Attendance Screens
  '/bacenta-services': (context) => const BacentaServicesScreen(),
  '/bacenta/attendance-ticker': (context) => const BacentaAttendanceTickerScreen(),
  '/bacenta/attendance-report': (context) => const BacentaAttendanceReportScreen(),
};
