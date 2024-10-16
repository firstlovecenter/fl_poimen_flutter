import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencyServiceReport = gql('''
query getConstituencyServiceReport(\$poimenRecordId: ID!, \$constituencyId: ID!) {
    constituencies(where: { id: \$constituencyId }) {
      id
      typename
      name
    }
    poimenRecords(where: { id: \$poimenRecordId }) {
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
        bacenta {
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
        bacenta {
          id
          typename
          name
        }
      }
    }
  }
  ''');

final getBacentaServiceReport = gql('''
query getBacentaServiceReport(\$serviceRecordId: ID!, \$bacentaId: ID!) {
    bacentas(where: { id: \$bacentaId }) {
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
        bacenta {
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
        bacenta {
          id
          typename
          name
        }
      }
      membersPresentFromBacenta(id: \$bacentaId) {
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
      membersAbsentFromBacenta(id: \$bacentaId) {
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
        bacenta {
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
        bacenta {
          id
          typename
          name
        }
      }
      membersPresentFromBacenta(id: \$bacentaId) {
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
      membersAbsentFromBacenta(id: \$bacentaId) {
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

final getHubRehearsalReport = gql('''
query getHubRehearsalReport(\$rehearsalRecordId: ID!, \$hubId: ID!) {
    hubs(where: { id: \$hubId }) {
      id
      typename
      name
    }
    rehearsalRecords(where: { id: \$rehearsalRecordId }) {
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
        bacenta {
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
        bacenta {
          id
          typename
          name
        }
      }
      membersPresentFromHub(id: \$hubId) {
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
      membersAbsentFromHub(id: \$hubId) {
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
