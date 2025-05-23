import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipHomeScreen = gql('''
  query getFellowshipHomeScreen(\$id: ID!){
    fellowships(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      outstandingVisitationsCount
      outstandingPrayerCount
      outstandingTelepastoringCount
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      }
    }
  }
''');

final getBacentaHomeScreen = gql('''
  query getBacentaHomeScreen(\$id: ID!){
    bacentas(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      outstandingVisitationsCount
      outstandingPrayerCount
      outstandingTelepastoringCount
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      }
    }
  }
''');

final getGovernorshipHomeScreen = gql('''
  query getGovernorshipHomeScreen(\$id: ID!){
    governorships(where: {id: \$id}){
      id
      typename
      name
       imclTotal
      outstandingVisitationsCount
      outstandingPrayerCount
      outstandingTelepastoringCount
      fellowshipServiceAttendanceDefaultersCount
      fellowshipBussingAttendanceDefaultersCount
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      }
    }
  }
''');

final getCouncilHomeScreen = gql('''
  query getCouncilHomeScreen(\$id: ID!){
    councils(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      outstandingVisitationsCount
      outstandingPrayerCount
      outstandingTelepastoringCount
      fellowshipServiceAttendanceDefaultersCount
      fellowshipBussingAttendanceDefaultersCount
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      }
    }
  }
''');

final getStreamHomeScreen = gql('''
  query getStreamHomeScreen(\$id: ID!){
    streams(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      fellowshipServiceAttendanceDefaultersCount
      fellowshipBussingAttendanceDefaultersCount
    }
  }
''');

final getCampusHomeScreen = gql('''
  query getCampusHomeScreen(\$id: ID!){
    campuses(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      fellowshipServiceAttendanceDefaultersCount
      fellowshipBussingAttendanceDefaultersCount
    }
  }
''');

final getHubHomeScreen = gql('''
  query getHubHomeScreen(\$id: ID!){
    hubs(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      }
    }
  }
''');

final getHubCouncilHomeScreen = gql('''
  query getHubCouncilHomeScreen(\$id: ID!){
    hubCouncils(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      }
    }
  }
''');

final getMinistryHomeScreen = gql('''
  query getMinistryHomeScreen(\$id: ID!){
    ministries(where: {id: \$id}){
      id
      typename
      name
      imclTotal
    }
  }
''');

final getCreativeArtsHomeScreen = gql('''
  query getCreativeArtsHomeScreen(\$id: ID!){
    creativeArts(where: {id: \$id}){
      id
      typename
      name
      imclTotal
    }
  }
''');

final getBacentaPastoralCycle = gql('''
 mutation getBacentaPastoralCycle {
  currentBacentaPastoralCycle {
    typename
    startDate
    endDate
    numberOfDays
  }
}
''');

final getGovernorshipPastoralCycle = gql('''
 mutation getGovernorshipPastoralCycle {
  currentGovernorshipPastoralCycle {
    typename
    startDate
    endDate
    numberOfDays
  }
}
''');

final getCouncilPastoralCycle = gql('''
 mutation getCouncilPastoralCycle {
  currentCouncilPastoralCycle {
    typename
    startDate
    endDate
    numberOfDays
  }
}
''');
