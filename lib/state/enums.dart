// ignore_for_file: constant_identifier_names

enum ChurchLevel {
  fellowship,
  bacenta,
  constituency,
  council,
  stream,
  gathering,
}

enum ChurchRole {
  admin,
  leader,
}

ChurchLevel getChurchLevelFromAuth(List<String> role) {
  if (role.where((element) => ['leaderCampus', 'adminCampus'].contains(element)).isNotEmpty) {
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

Role getRoleEnum(ChurchLevel churchLevel, ChurchRole role) {
  if (churchLevel == ChurchLevel.fellowship && role == ChurchRole.leader) {
    return Role.leaderFellowship;
  } else if (churchLevel == ChurchLevel.bacenta && role == ChurchRole.leader) {
    return Role.leaderBacenta;
  } else if (churchLevel == ChurchLevel.constituency && role == ChurchRole.leader) {
    return Role.leaderConstituency;
  } else if (churchLevel == ChurchLevel.constituency && role == ChurchRole.admin) {
    return Role.adminConstituency;
  } else if (churchLevel == ChurchLevel.council && role == ChurchRole.leader) {
    return Role.leaderCouncil;
  } else if (churchLevel == ChurchLevel.council && role == ChurchRole.admin) {
    return Role.adminCouncil;
  } else if (churchLevel == ChurchLevel.stream && role == ChurchRole.leader) {
    return Role.leaderStream;
  } else if (churchLevel == ChurchLevel.stream && role == ChurchRole.admin) {
    return Role.adminStream;
  } else if (churchLevel == ChurchLevel.gathering && role == ChurchRole.leader) {
    return Role.leaderGathering;
  } else if (churchLevel == ChurchLevel.gathering && role == ChurchRole.admin) {
    return Role.adminGathering;
  }

  return Role.leaderFellowship;
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
    case 'campus':
      return ChurchLevel.gathering;
    default:
      return ChurchLevel.fellowship;
  }
}

ChurchRole convertToRoleEnum(String churchRole) {
  switch (churchRole) {
    case 'Leader':
    case 'leader':
      return ChurchRole.leader;
    case 'Admin':
    case 'admin':
      return ChurchRole.admin;

    default:
      return ChurchRole.leader;
  }
}

class ChurchString {
  String _lowerCase = '';
  String _properCase = '';
  String _pluralLowerCase = '';
  String _pluralProperCase = '';

  ChurchString(String levelLowerCase) {
    _lowerCase = _lowerCase == 'campus' ? 'campus' : levelLowerCase;
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
  if (churchString == 'campus') {
    return 'campuses';
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
  adminConstituency,
  adminCouncil,
  adminStream,
  adminGathering,
  all
}
