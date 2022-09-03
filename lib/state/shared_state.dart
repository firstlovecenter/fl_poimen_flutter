import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';

class SharedState with ChangeNotifier {
  String _role = '';
  ProfileChurch _church = ProfileChurch(
    id: '',
    typename: '',
    name: '',
  );
  String _fellowshipId = '';
  String _bacentaId = '';
  String _constituencyId = '';
  String _councilId = '';
  String _streamId = '';
  String _gatheringId = '';

  String get role => _role;
  ProfileChurch get church => _church;

  String get fellowshipId => _fellowshipId;
  String get bacentaId => _bacentaId;
  String get constituencyId => _constituencyId;
  String get councilId => _councilId;
  String get streamId => _streamId;
  String get gatheringId => _gatheringId;

  set church(ProfileChurch church) {
    _church = church;
    notifyListeners();
  }

  set role(String role) {
    _role = role;
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
}
