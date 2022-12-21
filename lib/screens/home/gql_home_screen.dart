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

final getConstituencyHomeScreen = gql('''
  query getConstituencyHomeScreen(\$id: ID!){
    constituencies(where: {id: \$id}){
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

final getSontaHomeScreen = gql('''
  query getSontaHomeScreen(\$id: ID!){
    sonatas(where: {id: \$id}){
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

final getCouncilHomeScreen = gql('''
  query getCouncilHomeScreen(\$id: ID!){
    councils(where: {id: \$id}){
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

final getStreamHomeScreen = gql('''
  query getStreamHomeScreen(\$id: ID!){
    streams(where: {id: \$id}){
      id
      typename
      name
      imclTotal
      
    }
  }
''');

final getGatheringServiceHomeScreen = gql('''
  query getGatheringServiceHomeScreen(\$id: ID!){
    gatheringServices(where: {id: \$id}){
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

final getConstituencyPastoralCycle = gql('''
 mutation getConstituencyPastoralCycle {
  currentConstituencyPastoralCycle {
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
