import 'package:graphql_flutter/graphql_flutter.dart';

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

final getCouncilMembershipAttendanceTrends = gql('''
  query getCouncilMembershipAttendanceTrends(\$id: ID!) {
    councils(where: {id: \$id}) {
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

final getStreamMembershipAttendanceTrends = gql('''
  query getStreamMembershipAttendanceTrends(\$id: ID!) {
    streams(where: {id: \$id}) {
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

final getCampusMembershipAttendanceTrends = gql('''
  query getCampusMembershipAttendanceTrends(\$id: ID!) {
    campuses(where: {id: \$id}) {
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
