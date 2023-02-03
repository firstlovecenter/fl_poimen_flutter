import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipOutstandingPrayer = gql('''
 query getFellowshipOutstandingPrayer(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      completedPrayerCount
      outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getBacentaOutstandingPrayer = gql('''
 query getBacentaOutstandingPrayer(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      completedPrayerCount
      outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getConstituencyOutstandingPrayer = gql('''
 query getConstituencyOutstandingPrayer(\$id: ID!) {
    constituencies(where: { id: \$id }) {
      id
      typename
      name
      completedPrayerCount
      outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getCouncilOutstandingPrayer = gql('''
 query getCouncilOutstandingPrayer(\$id: ID!) {
    councils(where: { id: \$id }) {
      id
      typename
      name
      completedPrayerCount
      outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getFellowshipCompletedPrayer = gql('''
 query getFellowshipCompletedPrayer(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      outstandingPrayerCount
      completedPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getBacentaCompletedPrayer = gql('''
 query getBacentaCompletedPrayer(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      outstandingPrayerCount
      completedPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getConstituencyCompletedPrayer = gql('''
 query getConstituencyCompletedPrayer(\$id: ID!) {
    constituencies(where: { id: \$id }) {
      id
      typename
      name
      outstandingPrayerCount
      completedPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getCouncilCompletedPrayer = gql('''
 query getCouncilCompletedPrayer(\$id: ID!) {
    councils(where: { id: \$id }) {
      id
      typename
      name
      outstandingPrayerCount
      completedPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final logFellowshipPrayerActivity = gql('''
mutation LogFellowshipPrayerActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogFellowshipPrayerActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedPrayerCount
     outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final logBacentaPrayerActivity = gql('''
mutation LogBacentaPrayerActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogBacentaPrayerActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedPrayerCount
     outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final logConstituencyPrayerActivity = gql('''
mutation LogConstituencyPrayerActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogConstituencyPrayerActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedPrayerCount
     outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final logCouncilPrayerActivity = gql('''
mutation LogCouncilPrayerActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogCouncilPrayerActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedPrayerCount
     outstandingPrayer {
        id
        typename
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');
