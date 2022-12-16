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
