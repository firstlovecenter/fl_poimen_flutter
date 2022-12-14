// ignore_for_file: constant_identifier_names

enum ChurchLevel {
  fellowship,
  bacenta,
  constituency,
  council,
  stream,
  gathering,
}

ChurchLevel getChurchLevelFromAuth(List<String> role) {
  if (role
      .where((element) => ['leaderGatheringService', 'adminGatheringService'].contains(element))
      .isNotEmpty) {
    return ChurchLevel.council;
  } else if (role
      .where((element) => ['leaderStream', 'adminStream'].contains(element))
      .isNotEmpty) {
    return ChurchLevel.council;
  } else if (role
      .where((element) => ['leaderCouncil', 'adminCouncil'].contains(element))
      .isNotEmpty) {
    return ChurchLevel.council;
  } else if (role
      .where((element) => ['leaderConstituency', 'adminConstituency'].contains(element))
      .isNotEmpty) {
    return ChurchLevel.constituency;
  } else if (role.where((element) => ['leaderBacenta'].contains(element)).isNotEmpty) {
    return ChurchLevel.bacenta;
  } else if (role.contains('leaderFellowship')) {
    return ChurchLevel.fellowship;
  } else {
    return ChurchLevel.fellowship;
  }
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
    _lowerCase = _lowerCase == 'gatheringservice' ? 'gatheringService' : levelLowerCase;
    _properCase = levelLowerCase[0].toUpperCase() + levelLowerCase.substring(1);
    _pluralLowerCase = _convertToPluralLowerCase(_lowerCase);
    _pluralProperCase = _properCase == 'Constituency' ? 'Constituencies' : '${_properCase}s';
  }

  String get lowerCase => _lowerCase;
  String get properCase => _properCase;
  String get pluralLowerCase => _pluralLowerCase;
  String get pluralProperCase => _pluralProperCase;
}

String _convertToPluralLowerCase(String churchString) {
  if (churchString == 'constituency') {
    return 'constituencies';
  }
  if (churchString == 'gatheringservice') {
    return 'gatheringServices';
  }

  return '${churchString}s';
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
