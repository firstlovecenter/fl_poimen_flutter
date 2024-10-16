import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipOutstandingTelepastoring = gql('''
 query getFellowshipOutstandingTelepastoring(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      completedTelepastoringCount
      outstandingTelepastoring {
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

final getBacentaOutstandingTelepastoring = gql('''
 query getBacentaOutstandingTelepastoring(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      completedTelepastoringCount
      outstandingTelepastoring {
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

final getGovernorshipOutstandingTelepastoring = gql('''
 query getGovernorshipOutstandingTelepastoring(\$id: ID!) {
    governorships(where: { id: \$id }) {
      id
      typename
      name
      completedTelepastoringCount
      outstandingTelepastoring {
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

final getCouncilOutstandingTelepastoring = gql('''
 query getCouncilOutstandingTelepastoring(\$id: ID!) {
    councils(where: { id: \$id }) {
      id
      typename
      name
      completedTelepastoringCount
      outstandingTelepastoring {
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

final getFellowshipCompletedTelepastoring = gql('''
 query getFellowshipCompletedTelepastoring(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      outstandingTelepastoringCount
      completedTelepastoring {
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

final getBacentaCompletedTelepastoring = gql('''
 query getBacentaCompletedTelepastoring(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      outstandingTelepastoringCount
      completedTelepastoring {
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

final getGovernorshipCompletedTelepastoring = gql('''
 query getGovernorshipCompletedTelepastoring(\$id: ID!) {
    governorships(where: { id: \$id }) {
      id
      typename
      name
      outstandingTelepastoringCount
      completedTelepastoring {
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

final getCouncilCompletedTelepastoring = gql('''
 query getCouncilCompletedTelepastoring(\$id: ID!) {
    councils(where: { id: \$id }) {
      id
      typename
      name
      outstandingTelepastoringCount
      completedTelepastoring {
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

final logFellowshipTelepastoringActivity = gql('''
mutation LogFellowshipTelepastoringActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogFellowshipTelepastoringActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedTelepastoringCount
     outstandingTelepastoring {
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

final logBacentaTelepastoringActivity = gql('''
mutation LogBacentaTelepastoringActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogBacentaTelepastoringActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedTelepastoringCount
     outstandingTelepastoring {
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

final logGovernorshipTelepastoringActivity = gql('''
mutation LogGovernorshipTelepastoringActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogGovernorshipTelepastoringActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedTelepastoringCount
     outstandingTelepastoring {
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

final logCouncilTelepastoringActivity = gql('''
mutation LogCouncilTelepastoringActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogCouncilTelepastoringActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
     id
     typename
     name
     completedTelepastoringCount
     outstandingTelepastoring {
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
