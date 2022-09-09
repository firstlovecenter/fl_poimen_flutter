import 'package:graphql_flutter/graphql_flutter.dart';

final recordMemberFellowshipAttendance = gql('''
  mutation RecordMemberFellowshipAttendance(
    \$membersPicture: String!
    \$presentMembers: [ID!]!
    \$absentMembers: [ID!]!
    \$recordId: ID!
  ) {
    RecordFellowshipMemberPresent(
      presentMembers: \$presentMembers
      membersPicture: \$membersPicture
      recordId: \$recordId
    ) {
      id
      markedAttendance
      membersPicture
      membersPresent {
        id
        firstName
        lastName
        pictureUrl
      }
    }
    RecordFellowshipMemberAbsent(
      absentMembers: \$absentMembers
      recordId: \$recordId
    ) {
      id
      markedAttendance
      membersAbsent {
        id
        firstName
        lastName
        pictureUrl
      }
    }
  }
  ''');

final recordMemberBacentaAttendance = gql('''
mutation RecordMemberBacentaAttendance(
    \$membersPicture: String!
    \$presentMembers: [ID!]!
    \$absentMembers: [ID!]!
    \$recordId: ID!
  ) {
    RecordBacentaMemberPresent(
      presentMembers: \$presentMembers
      membersPicture: \$membersPicture
      recordId: \$recordId
    ) {
      id
      markedAttendance
      membersPicture
      membersPresent {
        id
        firstName
        lastName
        pictureUrl
      }
    }
    RecordBacentaMemberAbsent(
      absentMembers: \$absentMembers
      recordId: \$recordId
    ) {
      id
      markedAttendance
      membersAbsent {
        id
        firstName
        lastName
        pictureUrl
      }
    }
  }
  ''');

final computeMembesStatuses = gql('''
  mutation ComputeMembersStatuses(\$memberIds: [ID!]!) {
    ComputeMembersStatuses(members: \$memberIds) {
      __typename
      id
      firstName
      lastName
      fullName
    }
  }
''');
