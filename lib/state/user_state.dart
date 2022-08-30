import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';

class UserState with ChangeNotifier {
  String _role = '';
  ProfileChurch _church = ProfileChurch(
    id: '',
    typename: '',
    name: '',
  );

  String get role => _role;
  ProfileChurch get church => _church;

  set church(ProfileChurch church) {
    _church = church;
    notifyListeners();
  }

  set role(String role) {
    _role = role;
    notifyListeners();
  }
}
