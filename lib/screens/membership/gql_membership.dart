import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipMembers = gql('''
   query getFellowshipMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
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
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');
