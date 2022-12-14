import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipImcls = gql('''
 query getFellowshipIdls(\$id: ID!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name
      imcls {
        id
        typename
        status
        imclChecked
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
        missedChurchComments(options: { sort: [{ timestamp: DESC }], limit: 1 }) {
          id
          typename
          timestamp
          activity
          comment
          author {
            id
            typename
            firstName
            lastName
            pictureUrl
          }
        }
      }
    }
  }
''');

final getBacentaImcls = gql('''
 query getBacentaImcls(\$id: ID!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name
      imcls {
        id
        typename
        imclChecked
        status
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber

        missedChurchComments(options: { sort: [{ timestamp: DESC }], limit: 1 }) {
          id
          typename
          timestamp
          activity
          comment
          author {
            id
            typename
            firstName
            lastName
            pictureUrl
          }
        }
      }
    }
  }
''');

final recordReasonForMemberAbsence = gql('''
  mutation recordReasonForMemberAbsence(\$memberId: ID!, \$reason: String!, \$roleLevel: String!){
  RecordReasonForMemberAbsence(memberId: \$memberId, reason: \$reason, roleLevel: \$roleLevel) {
    id
    typename
    firstName
    lastName
    imclChecked

    missedChurchComments (options: { sort: [{ timestamp: DESC }], limit: 1 }){
      id
      typename
      timestamp
      activity
      comment
      author {
        id
        typename
        firstName
        lastName
        pictureUrl
      }
    }
  }
}
''');
