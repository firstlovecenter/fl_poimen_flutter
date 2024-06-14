import 'package:graphql_flutter/graphql_flutter.dart';

final getBacentaMembersForBussing = gql('''
   query getBacentaMembersForBussing(\$id: ID!, \$bussingRecordId: ID) {
    bussingRecords(where: { id: \$bussingRecordId }, options: { limit: 1 }) {
      id
      typename
      membersPicture
      serviceDate {
        date
      }
    }
    bacentas (where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getBacentaMembers = gql('''
   query getBacentaMembers(\$id: ID!) {
    bacentas (where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getConstituencyMembers = gql('''
   query getConstituencyMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    constituencies(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getCouncilMembers = gql('''
   query getCouncilMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    councils(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getStreamMembers = gql('''
   query getStreamMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    streams(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getCampusMembers = gql('''
   query getCampusMembers(\$id: ID!, \$serviceRecordId: ID, \$first: Int! \$after: Int!) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    campuses(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            firstName
            lastName
            fullName
            pictureUrl
          }  
        }
        totalCount
        position
      }
      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            firstName
            lastName
            fullName
            pictureUrl
          }  
        }
        totalCount
        position
      }
      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            firstName
            lastName
            fullName
            pictureUrl
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getHubMembers = gql('''
   query getHubMembers(\$id: ID!, \$rehearsalRecordId: ID) {
    rehearsalRecords(where: { id: \$rehearsalRecordId }, options: { limit: 1 }) {
      id
      typename
      membersPicture
      serviceDate {
        date
      }
    }
    hubs(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        lost 
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      goats {
        id
        typename
        lost 
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      deer {
        id
        typename
        lost 
        firstName
        lastName
        fullName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');
