import 'package:poimen/screens/home/home.dart';
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
  '/fellowship-members': (context) => const FellowshipMembershipList(),
  '/bacenta-members': (context) => const BacentaMembershipList(),
  '/constituency-members': (context) => const ConstituencyMembershipList(),
  '/council-members': (context) => const CouncilMembershipList(),
  '/stream-members': (context) => const StreamMembershipList(),
  '/gatheringservice-members': (context) => const GatheringMembershipList(),
};
