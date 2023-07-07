import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipTrendsMenu = gql('''
  query getFellowshipTrendsMenu(\$id: ID!) {
    fellowships(where: {id: \$id}) {
      id
      typename
      name
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
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

final getFellowshipMembershipAttendanceTrends = gql('''
  query getFellowshipMembershipAttendanceTrends(\$id: ID!) {
    fellowships(where: {id: \$id}) {
      id
      typename
      name

      sheepCount
      goatsCount
      deerCount
      lostCount

      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      
      services(limit: 6) {
        id
        typename
        serviceDate {
          date
        }
        attendance
        membersPresentFromFellowshipCount(id: \$id)
        membersAbsentFromFellowshipCount(id: \$id)
      }
      bussing(limit: 6) {
        id
        typename
        serviceDate {
          date
        }
        attendance
        membersPresentFromFellowshipCount(id: \$id)
        membersAbsentFromFellowshipCount(id: \$id)
      }
    }
  }
''');
