import 'package:graphql_flutter/graphql_flutter.dart';

final getMemberDetails = gql('''
 query getMemberProfile(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      firstName
      lastName
      status
      pictureUrl
      phoneNumber
      whatsappNumber
      visitationLocation
      howYouJoined
      location {
        latitude
        longitude
      }
      lastFourWeekdayServices {
        date
        service
        present
      }
      lastFourWeekendServices {
        date
        service
        present
      }
      gender {
        gender
      }
      dob {
        date
      }
      ministry {
        id
        typename
        name
      }
      stream {
        id
        typename
        name
        
      }
      pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
        activity
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
          phoneNumber
          whatsappNumber
        }
      }
    }
  }
''');

final getMemberPastoralComments = gql('''
 query getMemberProfile(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      status
      firstName
      lastName
      pictureUrl
      phoneNumber
      whatsappNumber
      pastoralComments (limit: 10) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
        activity
      }
    }
  }
''');
