import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipServiceReport = gql('''
query getFellowshipServiceReport(\$serviceRecordId: ID!, \$fellowshipId: ID!) {
    fellowships(where: { id: \$fellowshipId }) {
      id
      typename
      name
    }
    serviceRecords(where: { id: \$serviceRecordId }) {
      id
      typename
      serviceDate {
        date
      }
      membersPicture
      membersPresent {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
        fellowship {
          id
          typename
          name
        }
      }
      membersAbsent {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
        fellowship {
          id
          typename
          name
        }
      }
      membersPresentFromFellowship(id: \$fellowshipId) {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
      }
      membersAbsentFromFellowship(id: \$fellowshipId) {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
      }
    }
  }
  ''');

final getFellowshipBussingReport = gql('''
query getFellowshipBussingReport(\$bussingRecordId: ID!, \$fellowshipId: ID!) {
    fellowships(where: { id: \$fellowshipId }) {
      id
      typename
      name
    }
    bussingRecords(where: { id: \$bussingRecordId }) {
      id
      typename
      serviceDate {
        date
      }
      membersPicture
      membersPresent {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
        fellowship {
          id
          typename
          name
        }
      }
      membersAbsent {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
        fellowship {
          id
          typename
          name
        }
      }
      membersPresentFromFellowship(id: \$fellowshipId) {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
      }
      membersAbsentFromFellowship(id: \$fellowshipId) {
        id
        status
        typename
        firstName
        lastName
        fullName
        phoneNumber
        whatsappNumber
        pictureUrl
      }
    }
  }
  ''');
