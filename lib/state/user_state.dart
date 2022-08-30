import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String _churchLevel = 'Fellowship';
  String _role = '';

  String get churchLevel => _churchLevel;
  String get role => _role;

  set churchLevel(String churchLevel) {
    _churchLevel = churchLevel;
    notifyListeners();
  }

  set role(String role) {
    _role = role;
    notifyListeners();
  }
}
