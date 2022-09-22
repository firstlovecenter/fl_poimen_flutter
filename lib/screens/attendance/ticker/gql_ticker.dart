import 'package:graphql_flutter/graphql_flutter.dart';

final recordMembershipAttendance = gql('''
 mutation RecordMembershipAttendance(
  \$membersPicture: String!
  \$presentMembers: [ID!]!
  \$absentMembers: [ID!]!
  \$recordId: ID!
) {
  RecordMembershipAttendance(
    membersPicture: \$membersPicture
    presentMembers: \$presentMembers
    absentMembers: \$absentMembers
    recordId: \$recordId
  ) {
    id
    markedAttendance
    membersPresent {
      id
      firstName
      lastName
      pictureUrl
    }
    membersAbsent {
      id
      firstName
      lastName
      pictureUrl
    }
  }
}
  ''');
