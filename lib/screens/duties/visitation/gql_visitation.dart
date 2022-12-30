import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipOutstandingVisitations = gql('''
 query getFellowshipOutstandingVisitations(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      completedVisitationsCount
      outstandingVisitations {
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

final getBacentaOutstandingVisitations = gql('''
 query getBacentaOutstandingVisitations(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      completedVisitationsCount
      outstandingVisitations {
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

final getConstituencyOutstandingVisitations = gql('''
 query getConstituencyOutstandingVisitations(\$id: ID!) {
    constituencies(where: { id: \$id }) {
      id
      typename
      name
      completedVisitationsCount
      outstandingVisitations {
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

final getFellowshipCompletedVisitations = gql('''
 query getFellowshipCompletedVisitations(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      outstandingVisitationsCount
      completedVisitations {
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

final getBacentaCompletedVisitations = gql('''
 query getBacentaCompletedVisitations(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      outstandingVisitationsCount
      completedVisitations {
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

final getConstituencyCompletedVisitations = gql('''
 query getConstituencyCompletedVisitations(\$id: ID!) {
    constituencies(where: { id: \$id }) {
      id
      typename
      name
      outstandingVisitationsCount
      completedVisitations {
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

final logVisitationActivity = gql('''
mutation LogVisitationActivity(
    \$latitude: Float!
    \$longitude: Float!
    \$picture: String!
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogVisitationActivity(
    latitude: \$latitude, 
    longitude: \$longitude, 
    picture: \$picture, 
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
    id
    picture
  }
}
''');
