// ignore_for_file: constant_identifier_names

enum ChurchLevel {
  fellowship,
  bacenta,
  constituency,
  council,
  stream,
  campus,
  hub,
  hubCouncil,
  ministry,
  creativeArts
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
  } else if (churchLevel == ChurchLevel.campus && role == ChurchRole.leader) {
    return Role.leaderCampus;
  } else if (churchLevel == ChurchLevel.campus && role == ChurchRole.admin) {
    return Role.adminCampus;
  }

  //* Creative Arts Roles
  else if (churchLevel == ChurchLevel.hub && role == ChurchRole.leader) {
    return Role.leaderHub;
  } else if (churchLevel == ChurchLevel.hubCouncil && role == ChurchRole.leader) {
    return Role.leaderHubCouncil;
  } else if (churchLevel == ChurchLevel.ministry && role == ChurchRole.leader) {
    return Role.leaderMinistry;
  } else if (churchLevel == ChurchLevel.ministry && role == ChurchRole.admin) {
    return Role.adminMinistry;
  } else if (churchLevel == ChurchLevel.creativeArts && role == ChurchRole.leader) {
    return Role.leaderCreativeArts;
  } else if (churchLevel == ChurchLevel.creativeArts && role == ChurchRole.admin) {
    return Role.adminCreativeArts;
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
      return ChurchLevel.campus;
    case 'hub':
      return ChurchLevel.hub;
    case 'hubCouncil':
      return ChurchLevel.hubCouncil;
    case 'ministry':
      return ChurchLevel.ministry;
    case 'creativeArts':
      return ChurchLevel.creativeArts;
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

enum MaritalStatusOptions {
  Single,
  Married,
  Widowed,
}

enum MemberCategory { Sheep, Deer, Goat }

enum Role {
  leaderFellowship,
  leaderBacenta,
  leaderConstituency,
  leaderCouncil,
  leaderStream,
  leaderCampus,
  leaderHub,
  leaderHubCouncil,
  leaderMinistry,
  leaderCreativeArts,
  adminConstituency,
  adminCouncil,
  adminStream,
  adminCampus,
  adminMinistry,
  adminCreativeArts,
  all
}

List<Role> permitRoleAndHigher(Role role) {
  if (role == Role.leaderFellowship) {
    return [
      Role.leaderFellowship,
      Role.leaderBacenta,
      Role.leaderConstituency,
      Role.adminConstituency,
      Role.leaderCouncil,
      Role.adminCouncil,
      Role.leaderStream,
      Role.adminStream,
      Role.leaderCampus,
      Role.adminCampus,
    ];
  }

  if (role == Role.leaderBacenta) {
    return [
      Role.leaderBacenta,
      Role.leaderConstituency,
      Role.adminConstituency,
      Role.leaderCouncil,
      Role.adminCouncil,
      Role.leaderStream,
      Role.adminStream,
      Role.leaderCampus,
      Role.adminCampus,
    ];
  }

  if (role == Role.leaderConstituency || role == Role.adminConstituency) {
    return [
      Role.leaderConstituency,
      Role.adminConstituency,
      Role.leaderCouncil,
      Role.adminCouncil,
      Role.leaderStream,
      Role.adminStream,
      Role.leaderCampus,
      Role.adminCampus,
    ];
  }

  if (role == Role.leaderCouncil || role == Role.adminCouncil) {
    return [
      Role.leaderCouncil,
      Role.adminCouncil,
      Role.leaderStream,
      Role.adminStream,
      Role.leaderCampus,
      Role.adminCampus,
    ];
  }

  if (role == Role.leaderStream || role == Role.adminStream) {
    return [
      Role.leaderStream,
      Role.adminStream,
      Role.leaderCampus,
      Role.adminCampus,
    ];
  }

  if (role == Role.leaderCampus || role == Role.adminCampus) {
    return [
      Role.leaderCampus,
      Role.adminCampus,
    ];
  }

  return [];
}
