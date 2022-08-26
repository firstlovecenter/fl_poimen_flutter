import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String _churchLevel = 'Fellowship';

  String get churchLevel => _churchLevel;

  set churchLevel(String churchLevel) {
    _churchLevel = churchLevel;
    notifyListeners();
  }
}
