// ignore_for_file: constant_identifier_names

enum ChurchLevel {
  fellowship,
  bacenta,
  constituency,
  council,
  stream,
  gathering,
}

ChurchLevel convertToChurchEnum(String churchLevel) {
  switch (churchLevel) {
    case 'fellowship':
      return ChurchLevel.fellowship;
    case 'bacenta':
      return ChurchLevel.bacenta;
    case 'constituency':
      return ChurchLevel.constituency;
    case 'council':
      return ChurchLevel.council;
    case 'stream':
      return ChurchLevel.stream;
    case 'gatheringservice':
      return ChurchLevel.gathering;
    default:
      return ChurchLevel.fellowship;
  }
}

class ChurchString {
  String _lowerCase = '';
  String _properCase = '';
  String _pluralLowerCase = '';
  String _pluralProperCase = '';

  ChurchString(String levelLowerCase) {
    _lowerCase = _lowerCase == 'gatheringservices' ? 'gatheringServices' : levelLowerCase;
    _properCase = levelLowerCase[0].toUpperCase() + levelLowerCase.substring(1);
    _pluralLowerCase = _lowerCase == 'constituency' ? 'constituencies' : '${levelLowerCase}s';
    _pluralProperCase = _properCase == 'Constituency' ? 'Constituencies' : '${_properCase}s';
  }

  String get lowerCase => _lowerCase;
  String get properCase => _properCase;
  String get pluralLowerCase => _pluralLowerCase;
  String get pluralProperCase => _pluralProperCase;
}

enum Stream { Campus, Town, Anagkazo }

enum GenderOptions {
  Male,
  Female,
}

enum MemberCategory { Sheep, Deer, Goat }

enum Role {
  leaderFellowship,
  leaderBacenta,
  leaderConstituency,
  leaderCouncil,
  leaderStream,
  leaderGathering,
  all
}
