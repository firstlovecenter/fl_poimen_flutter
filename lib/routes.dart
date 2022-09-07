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

  // Display IDL list for Church Levels
  '/fellowship-idls': (context) => const FellowshipIDLScreen(),
};
