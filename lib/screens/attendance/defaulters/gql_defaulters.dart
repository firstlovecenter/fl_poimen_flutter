import 'package:graphql_flutter/graphql_flutter.dart';

final getGovernorshipAttendanceDefaulters = gql('''
   query getGovernorshipAttendanceDefaulters(\$id: ID!) {
     governorships(where: { id: \$id }) {
       id
       name
       typename
       bacentaCount 
       fellowshipServiceAttendanceDefaultersCount
       fellowshipBussingAttendanceDefaultersCount
     }
   }
  ''');

final getGovernorshipFellowshipServiceAttendanceDefaultersList = gql('''
 query getGovernorshipFellowshipServiceAttendanceDefaultersList(\$id: ID!) {
  governorships(where: { id: \$id }) {
    id
    name
    typename
    fellowshipServiceAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getGovernorshipBussingAttendanceDefaultersList = gql('''
 query getGovernorshipBussingAttendanceDefaultersList(\$id: ID!) {
  governorships(where: { id: \$id }) {
    id
    name
    typename
    fellowshipBussingAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getCouncilAttendanceDefaulters = gql('''
   query getCouncilAttendanceDefaulters(\$id: ID!) {
     councils(where: { id: \$id }) {
       id
       name
       typename
       governorshipCount
       fellowshipServiceAttendanceDefaultersCount
       fellowshipBussingAttendanceDefaultersCount
     }
   }
  ''');

final getCouncilFellowshipAttendanceDefaultersList = gql('''
 query getCouncilFellowshipAttendanceDefaultersList(\$id: ID!) {
  councils(where: { id: \$id }) {
    id
    name
    typename
    fellowshipServiceAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getCouncilBussingAttendanceDefaultersList = gql('''
 query getCouncilBussingAttendanceDefaultersList(\$id: ID!) {
  councils(where: { id: \$id }) {
    id
    name
    typename
    fellowshipBussingAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getStreamAttendanceDefaulters = gql('''
   query getStreamAttendanceDefaulters(\$id: ID!) {
     streams(where: { id: \$id }) {
       id
       name
       typename
       councilCount
       fellowshipServiceAttendanceDefaultersCount
       fellowshipBussingAttendanceDefaultersCount
     }
   }
  ''');

final getStreamFellowshipAttendanceDefaultersList = gql('''
 query getStreamFellowshipAttendanceDefaultersList(\$id: ID!) {
  streams(where: { id: \$id }) {
    id
    name
    typename
    fellowshipServiceAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getStreamBussingAttendanceDefaultersList = gql('''
 query getStreamBussingAttendanceDefaultersList(\$id: ID!) {
  streams(where: { id: \$id }) {
    id
    name
    typename
    fellowshipBussingAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getCampusAttendanceDefaulters = gql('''
   query getCampusAttendanceDefaulters(\$id: ID!) {
     campuses(where: { id: \$id }) {
       id
       name
       typename
       streamCount
       fellowshipServiceAttendanceDefaultersCount
       fellowshipBussingAttendanceDefaultersCount
     }
   }
  ''');

final getCampusFellowshipAttendanceDefaultersList = gql('''
 query getCampusFellowshipAttendanceDefaultersList(\$id: ID!) {
  campuses(where: { id: \$id }) {
    id
    name
    typename
    fellowshipServiceAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');

final getCampusBussingAttendanceDefaultersList = gql('''
 query getCampusBussingAttendanceDefaultersList(\$id: ID!) {
  campuses(where: { id: \$id }) {
    id
    name
    typename
    fellowshipBussingAttendanceDefaulters {
      id
      name
      typename
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
}
''');
