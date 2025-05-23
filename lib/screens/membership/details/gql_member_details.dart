import 'package:graphql_flutter/graphql_flutter.dart';

final getMemberDetails = gql('''
 query getMemberProfile(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      stickyNote
      firstName
      middleName
      lastName
      email
      currentTitle
      nameWithTitle
      roles
      status
      pictureUrl
      phoneNumber
      whatsappNumber
      visitationArea
      location {
        latitude
        longitude
      }
      lastAttendedServiceDate
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
      maritalStatus{
        status
      }
      occupation {
        occupation
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
      council {
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
      bacenta{
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

final recordPastoralComment = gql('''
  mutation LogPastoralComment(\$memberId: ID!, \$comment: String!, \$roleLevel: String!, \$cycleId: ID!) {
    LogPastoralComment(memberId: \$memberId, comment: \$comment, roleLevel: \$roleLevel, cycleId: \$cycleId) {
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
''');
