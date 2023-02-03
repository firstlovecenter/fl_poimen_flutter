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

final getConstituencyOutstandingTelepastoring = gql('''
 query getConstituencyOutstandingTelepastoring(\$id: ID!) {
    constituencies(where: { id: \$id }) {
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

final getConstituencyCompletedTelepastoring = gql('''
 query getConstituencyCompletedTelepastoring(\$id: ID!) {
    constituencies(where: { id: \$id }) {
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

final logConstituencyTelepastoringActivity = gql('''
mutation LogConstituencyTelepastoringActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogConstituencyTelepastoringActivity(
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

