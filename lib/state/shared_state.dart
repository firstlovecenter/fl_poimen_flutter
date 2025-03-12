import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/state/enums.dart';

class SharedState with ChangeNotifier {
  String _searchKey = '';
  String _version = '0.0.0';
  Role _role = Role.leaderFellowship;
  ChurchLevel _roleLevel = ChurchLevel.fellowship;
  ChurchRole _roleType = ChurchRole.leader;

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
    phoneNumber: '',
    whatsappNumber: '',
  );

  PastoralCycle _pastoralCycle = PastoralCycle(
    id: '',
    typename: '',
    startDate: '',
    endDate: '',
    numberOfDays: 0,
  );
  String _memberId = '';
  String _fellowshipId = '';
  String _bacentaId = '';
  String _governorshipId = '';
  String _councilId = '';
  String _streamId = '';
  String _campusId = '';
  String _hubId = '';
  String _hubCouncilId = '';
  String _ministryId = '';
  String _creativeArtsId = '';

  String _bussingRecordId = '';
  String _serviceRecordId = '';
  String _bottomNavSelected = '';

  String get searchKey => _searchKey;
  String get version => _version;
  Role get role => _role;
  ChurchLevel get roleLevel => _roleLevel;
  ChurchRole get roleType => _roleType;
  ProfileChurch get church => _church;
  MemberForList get member => _member;
  String get bottomNavSelected => _bottomNavSelected;

  PastoralCycle get pastoralCycle => _pastoralCycle;
  String get memberId => _memberId;
  String get fellowshipId => _fellowshipId;
  String get bacentaId => _bacentaId;
  String get governorshipId => _governorshipId;
  String get councilId => _councilId;
  String get streamId => _streamId;
  String get campusId => _campusId;
  String get hubId => _hubId;
  String get hubCouncilId => _hubCouncilId;
  String get ministryId => _ministryId;
  String get creativeArtsId => _creativeArtsId;

  String get bussingRecordId => _bussingRecordId;
  String get serviceRecordId => _serviceRecordId;

  set searchKey(String searchKey) {
    _searchKey = searchKey;
    notifyListeners();
  }

  set version(String version) {
    // Only update if different to avoid unnecessary notifications
    if (_version == version) return;

    // Make sure version is in a valid format if it's expected to be numeric
    if (version != "prod" && version != "dev" && version != "staging") {
      try {
        // Try to format as semantic version if it's supposed to be a number
        if (version.contains('.')) {
          _version = version;
        } else {
          // If it's a single number, format it as x.0.0
          _version = "$version.0.0";
        }
      } catch (e) {
        // If there's any error, just use the version as-is
        _version = version;
      }
    } else {
      // For special strings like "prod", store as-is
      _version = version;
    }

    // Safely notify listeners outside of build phase
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.persistentCallbacks) {
      notifyListeners();
    } else {
      // Use a microtask to defer the notification until after the build phase
      Future.microtask(() => notifyListeners());
    }
  }

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

  set roleLevel(ChurchLevel roleLevel) {
    _roleLevel = roleLevel;
    notifyListeners();
  }

  set roleType(ChurchRole roleType) {
    _roleType = roleType;
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

  set governorshipId(String governorshipId) {
    _governorshipId = governorshipId;
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

  set campusId(String campusId) {
    _campusId = campusId;
    notifyListeners();
  }

  set hubId(String hubId) {
    _hubId = hubId;
    notifyListeners();
  }

  set hubCouncilId(String hubCouncilId) {
    _hubCouncilId = hubCouncilId;
    notifyListeners();
  }

  set ministryId(String ministryId) {
    _ministryId = ministryId;
    notifyListeners();
  }

  set creativeArtsId(String creativeArtsId) {
    _creativeArtsId = creativeArtsId;
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
