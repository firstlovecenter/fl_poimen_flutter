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
      ministry {
        id
        name
      }
      stream {
        id
        typename
        name
        
      }
      fellowship {
        id
        typename
        name
        leader {
          id
          typename
          firstName
          lastName
          fullName
          pictureUrl
        }
      }
    }
  }
''');
