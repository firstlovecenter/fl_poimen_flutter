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

  ChurchString(String levelLowerCase) {
    _lowerCase = levelLowerCase;
    _properCase = levelLowerCase[0].toUpperCase() + levelLowerCase.substring(1);
  }

  String get lowerCase => _lowerCase;
  String get properCase => _properCase;
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
