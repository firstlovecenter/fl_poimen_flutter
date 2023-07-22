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

final getConstituencyTrendsMenu = gql('''
  query getConstituencyTrendsMenu(\$id: ID!) {
    constituencies(where: {id: \$id}) {
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
      
      serviceWeeks(limit: 6) {
        week 
        typename
        attendance
        membersPresentAtWeekdayCount
        membersAbsentAtWeekdayCount
      }
      bussingWeeks(limit: 6) {
        week
        typename
        attendance
        membersPresentAtWeekendCount
        membersAbsentAtWeekendCount
      }
    }
  }
''');


final getConstituencyMembershipAttendanceTrends = gql('''
  query getConstituencyMembershipAttendanceTrends(\$id: ID!) {
    constituencies(where: {id: \$id}) {
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
      
      serviceWeeks(limit: 6) {
        week 
        typename
        attendance
        membersPresentAtWeekdayCount
        membersAbsentAtWeekdayCount
      }
      bussingWeeks(limit: 6) {
        week
        typename
        attendance
        membersPresentAtWeekendCount
        membersAbsentAtWeekendCount
      }
    }
  }
''');