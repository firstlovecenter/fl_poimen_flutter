import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/state/enums.dart';

class SharedState with ChangeNotifier {
  Role _role = Role.leaderFellowship;
  ProfileChurch _church = ProfileChurch(
    id: '',
    typename: '',
    name: '',
  );
  String _memberId = '';
  String _fellowshipId = '';
  String _bacentaId = '';
  String _constituencyId = '';
  String _councilId = '';
  String _streamId = '';
  String _gatheringId = '';

  String _bussingRecordId = '';
  String _serviceRecordId = '';
  int _bottomNavSelectedIndex = 0;

  Role get role => _role;
  ProfileChurch get church => _church;
  int get bottomNavSelectedIndex => _bottomNavSelectedIndex;

  String get memberId => _memberId;
  String get fellowshipId => _fellowshipId;
  String get bacentaId => _bacentaId;
  String get constituencyId => _constituencyId;
  String get councilId => _councilId;
  String get streamId => _streamId;
  String get gatheringId => _gatheringId;

  String get bussingRecordId => _bussingRecordId;
  String get serviceRecordId => _serviceRecordId;

  set church(ProfileChurch church) {
    _church = church;
    notifyListeners();
  }

  set role(Role role) {
    _role = role;
    notifyListeners();
  }

  set bottomNavSelectedIndex(int bottomNavSelectedIndex) {
    _bottomNavSelectedIndex = bottomNavSelectedIndex;
    notifyListeners();
  }

  set memberId(String memberId) {
    _memberId = memberId;
    notifyListeners();
  }

  set fellowshipId(String fellowshipId) {
    _fellowshipId = fellowshipId;
    notifyListeners();
  }

  set bacentaId(String bacentaId) {
    _bacentaId = bacentaId;
    notifyListeners();
  }

  set constituencyId(String constituencyId) {
    _constituencyId = constituencyId;
    notifyListeners();
  }

  set councilId(String councilId) {
    _councilId = councilId;
    notifyListeners();
  }

  set streamId(String streamId) {
    _streamId = streamId;
    notifyListeners();
  }

  set gatheringId(String gatheringId) {
    _gatheringId = gatheringId;
    notifyListeners();
  }

  set bussingRecordId(String bussingRecordId) {
    _bussingRecordId = bussingRecordId;
    notifyListeners();
  }

  set serviceRecordId(String serviceRecordId) {
    _serviceRecordId = serviceRecordId;
    notifyListeners();
  }
}
