import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencyAttendanceDefaulters = gql('''
   query getConstituencyAttendanceDefaulters(\$id: ID!) {
     constituencies(where: { id: \$id }) {
       id
       name
       typename
       bacentaCount 
       fellowshipServiceAttendanceDefaultersCount
       fellowshipBussingAttendanceDefaultersCount
     }
   }
  ''');

final getConstituencyFellowshipServiceAttendanceDefaultersList = gql('''
 query getConstituencyFellowshipServiceAttendanceDefaultersList(\$id: ID!) {
  constituencies(where: { id: \$id }) {
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

final getConstituencyBussingAttendanceDefaultersList = gql('''
 query getConstituencyBussingAttendanceDefaultersList(\$id: ID!) {
  constituencies(where: { id: \$id }) {
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
       constituencyCount
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

final getGatheringAttendanceDefaulters = gql('''
   query getGatheringAttendanceDefaulters(\$id: ID!) {
     gatheringServices(where: { id: \$id }) {
       id
       name
       typename
       streamCount
       fellowshipServiceAttendanceDefaultersCount
       fellowshipBussingAttendanceDefaultersCount
     }
   }
  ''');

final getGatheringFellowshipAttendanceDefaultersList = gql('''
 query getGatheringFellowshipAttendanceDefaultersList(\$id: ID!) {
  gatheringServices(where: { id: \$id }) {
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

final getGatheringBussingAttendanceDefaultersList = gql('''
 query getGatheringBussingAttendanceDefaultersList(\$id: ID!) {
  gatheringServices(where: { id: \$id }) {
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
