import 'package:flutter/material.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/state/enums.dart';

class SharedState with ChangeNotifier {
  Role _role = Role.leaderFellowship;
  ProfileChurch _church = ProfileChurch(
    id: '',
    typename: '',
    name: '',
  );
  MemberForList _member = MemberForList(
    id: '',
    typename: '',
    firstName: '',
    lastName: '',
    pictureUrl: '',
    status: '',
  );

  PastoralCycle _pastoralCycle = PastoralCycle(
    typename: '',
    startDate: '',
    endDate: '',
    numberOfDays: 0,
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
  String _bottomNavSelected = '';

  Role get role => _role;
  ProfileChurch get church => _church;
  MemberForList get member => _member;
  String get bottomNavSelected => _bottomNavSelected;

  PastoralCycle get pastoralCycle => _pastoralCycle;
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

  set member(MemberForList member) {
    _member = member;
    notifyListeners();
  }

  set role(Role role) {
    _role = role;
    notifyListeners();
  }

  set bottomNavSelected(String bottomNavSelected) {
    _bottomNavSelected = bottomNavSelected;
    notifyListeners();
  }

  set pastoralCycle(PastoralCycle pastoralCycle) {
    _pastoralCycle = pastoralCycle;
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
