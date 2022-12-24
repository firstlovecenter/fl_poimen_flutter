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

final logTelepastoringActivity = gql('''
mutation LogTelepastoringActivity(
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogTelepastoringActivity(
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
    id
  }
}
''');
