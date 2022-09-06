import 'package:graphql_flutter/graphql_flutter.dart';

final getMemberDetails = gql('''
 query getMemberProfile(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      firstName
      lastName
      pictureUrl
      lastFourServices
      gender {
        gender
      }
      dob {
        date
      }
      phoneNumber
      whatsappNumber
      stream_name
      ministry {
        id
        name
      }
      fellowship {
        id
        leader {
          id
          firstName
          lastName
          fullName
        }
      }
    }
  }
''');
