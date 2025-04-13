import 'package:graphql_flutter/graphql_flutter.dart';

/// GraphQL mutation for creating a new member
final createMemberMutation = gql('''
  mutation CreateMember(
    \$firstName: String!
    \$middleName: String
    \$lastName: String!
    \$gender: String!
    \$phoneNumber: String!
    \$whatsappNumber: String!
    \$email: String
    \$dob: String!
    \$maritalStatus: String!
    \$occupation: String
    \$pictureUrl: String
    \$visitationArea: String!
    \$bacentaId: ID!
    \$basontaId: String
  ) {
    CreateMember(
      firstName: \$firstName
      middleName: \$middleName
      lastName: \$lastName
      gender: \$gender
      phoneNumber: \$phoneNumber
      whatsappNumber: \$whatsappNumber
      email: \$email
      dob: \$dob
      maritalStatus: \$maritalStatus
      occupation: \$occupation
      pictureUrl: \$pictureUrl
      visitationArea: \$visitationArea
      bacentaId: \$bacentaId
      basontaId: \$basontaId
    ) {
      id
      typename
      firstName
      lastName
      middleName
      gender
      phoneNumber
      whatsappNumber
      email
      dob
      maritalStatus
      occupation
      pictureUrl
      visitationArea
    }
  }
''');
