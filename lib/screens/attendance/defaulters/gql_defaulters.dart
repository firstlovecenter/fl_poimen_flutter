import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencyAttendanceDefaulters = gql('''
   query getConstituencyAttendanceDefaulters(\$id: ID!) {
     constituencies(where: { id: \$id }) {
       id
       name
       typename
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');

final getConstituencyFellowshipAttendanceDefaultersList = gql('''
 query getConstituencyFellowshipAttendanceDefaultersList(\$id: ID!) {
  constituencies(where: { id: \$id }) {
    id
    name
    typename
    fellowshipAttendanceDefaulters {
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

final getConstituencyBacentaAttendanceDefaultersList = gql('''
 query getConstituencyBacentaAttendanceDefaultersList(\$id: ID!) {
  constituencies(where: { id: \$id }) {
    id
    name
    typename
    bacentaAttendanceDefaulters {
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
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');

final getCouncilFellowshipAttendanceDefaultersList = gql('''
 query getCouncilFellowshipAttendanceDefaultersList(\$id: ID!) {
  councils(where: { id: \$id }) {
    id
    name
    typename
    fellowshipAttendanceDefaulters {
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

final getCouncilBacentaAttendanceDefaultersList = gql('''
 query getCouncilBacentaAttendanceDefaultersList(\$id: ID!) {
  councils(where: { id: \$id }) {
    id
    name
    typename
    bacentaAttendanceDefaulters {
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
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');

final getStreamFellowshipAttendanceDefaultersList = gql('''
 query getStreamFellowshipAttendanceDefaultersList(\$id: ID!) {
  streams(where: { id: \$id }) {
    id
    name
    typename
    fellowshipAttendanceDefaulters {
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

final getStreamBacentaAttendanceDefaultersList = gql('''
 query getStreamBacentaAttendanceDefaultersList(\$id: ID!) {
  streams(where: { id: \$id }) {
    id
    name
    typename
    bacentaAttendanceDefaulters {
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
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');

final getGatheringFellowshipAttendanceDefaultersList = gql('''
 query getGatheringFellowshipAttendanceDefaultersList(\$id: ID!) {
  gatheringServices(where: { id: \$id }) {
    id
    name
    typename
    fellowshipAttendanceDefaulters {
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

final getGatheringBacentaAttendanceDefaultersList = gql('''
 query getGatheringBacentaAttendanceDefaultersList(\$id: ID!) {
  gatheringServices(where: { id: \$id }) {
    id
    name
    typename
    bacentaAttendanceDefaulters {
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
