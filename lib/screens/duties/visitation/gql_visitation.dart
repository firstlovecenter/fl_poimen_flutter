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
        visitationArea
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
      }
    }
  }
''');

final logConstituencyVisitationActivity = gql('''
mutation LogConstituencyVisitationActivity(
    \$latitude: Float!
    \$longitude: Float!
    \$visitationArea: String!
    \$picture: String!
    \$comment: String!
    \$roleLevel: String!
    \$memberId: ID!
    \$cycleId: ID!){
  LogConstituencyVisitationActivity(
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
      }
    }
  }
''');
