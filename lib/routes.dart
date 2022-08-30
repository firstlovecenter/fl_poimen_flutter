import 'package:poimen/screens/home/home.dart';
import 'package:poimen/screens/membership/fellowship_list.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';

var appRoutes = {
  '/home': (context) => const Home(),
  '/profile-choose': (context) => const ProfileChooseScreen(),
  '/fellowship-members': (context) => const FellowshipMembershipList()
};
