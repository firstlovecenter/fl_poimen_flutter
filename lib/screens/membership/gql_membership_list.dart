import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipMembers = gql('''
   query getFellowshipMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      typename
      membersPicture
      serviceDate {
        date
      }
    }
    fellowships(where: { id: \$id }) {
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
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
    }
  }
''');

final getBacentaMembers = gql('''
   query getBacentaMembers(\$id: ID!, \$bussingRecordId: ID) {
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
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
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
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
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
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
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
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
      }
    }
  }
''');

final getGatheringMembers = gql('''
   query getGatheringMembers(\$id: ID!, \$serviceRecordId: ID, \$first: Int! \$after: Int!) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    gatheringServices(where: { id: \$id }) {
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
