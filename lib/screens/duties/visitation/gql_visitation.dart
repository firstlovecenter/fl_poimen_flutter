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
        location {
          latitude
          longitude
        }
        visitationArea
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
        location {
          latitude
          longitude
        }
        visitationArea
      }
    }
  }
''');

final getGovernorshipOutstandingVisitations = gql('''
 query getGovernorshipOutstandingVisitations(\$id: ID!) {
    governorships(where: { id: \$id }) {
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
        location {
          latitude
          longitude
        }
        visitationArea
      }
    }
  }
''');

final getCouncilOutstandingVisitations = gql('''
 query getCouncilOutstandingVisitations(\$id: ID!) {
    councils(where: { id: \$id }) {
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
        location {
          latitude
          longitude
        }
        visitationArea
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

final getGovernorshipCompletedVisitations = gql('''
 query getGovernorshipCompletedVisitations(\$id: ID!) {
    governorships(where: { id: \$id }) {
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

final getCouncilCompletedVisitations = gql('''
 query getCouncilCompletedVisitations(\$id: ID!) {
    councils(where: { id: \$id }) {
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

final logFellowshipVisitationActivity = gql('''
mutation LogFellowshipVisitationActivity(
    \$latitude: Float!
    \$longitude: Float!
    \$visitationArea: String!
    \$picture: String!
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogFellowshipVisitationActivity(
    latitude: \$latitude,
    longitude: \$longitude,
    visitationArea: \$visitationArea,
    picture: \$picture,
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
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
        visitationArea
      }
      idls {
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

final logBacentaVisitationActivity = gql('''
mutation LogBacentaVisitationActivity(
    \$latitude: Float!
    \$longitude: Float!
    \$visitationArea: String!
    \$picture: String!
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogBacentaVisitationActivity(
    latitude: \$latitude,
    longitude: \$longitude,
    visitationArea: \$visitationArea,
    picture: \$picture,
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
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
        visitationArea
      }
    }
  }
''');

final logGovernorshipVisitationActivity = gql('''
mutation LogGovernorshipVisitationActivity(
    \$latitude: Float!
    \$longitude: Float!
    \$visitationArea: String!
    \$picture: String!
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogGovernorshipVisitationActivity(
    latitude: \$latitude,
    longitude: \$longitude,
    visitationArea: \$visitationArea,
    picture: \$picture,
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
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
        visitationArea
      }
    }
  }
''');

final logCouncilVisitationActivity = gql('''
mutation LogCouncilVisitationActivity(
    \$latitude: Float!
    \$longitude: Float!
    \$visitationArea: String!
    \$picture: String!
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogCouncilVisitationActivity(
    latitude: \$latitude,
    longitude: \$longitude,
    visitationArea: \$visitationArea,
    picture: \$picture,
    comment: \$comment, 
    roleLevel: \$roleLevel, 
    memberId: \$memberId, 
    cycleId: \$cycleId) {
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
        visitationArea
      }
    }
  }
''');
