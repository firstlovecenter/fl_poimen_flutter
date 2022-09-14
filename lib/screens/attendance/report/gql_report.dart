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
      }
    }
  }
  ''');

final getBacentaBussingReport = gql('''
query getBacentaBussingReport(\$bussingRecordId: ID!, \$bacentaId: ID!) {
    bacentas(where: { id: \$bacentaId }) {
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
      }
    }
  }
  ''');
