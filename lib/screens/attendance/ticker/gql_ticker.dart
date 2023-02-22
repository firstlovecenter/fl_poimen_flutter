import 'package:graphql_flutter/graphql_flutter.dart';

final recordMembershipAttendance = gql('''
 mutation RecordMembershipAttendance(
  \$fellowshipId: ID!
  \$presentMembers: [ID!]!
  \$absentMembers: [ID!]!
  \$recordId: ID!
) {
  RecordMembershipAttendance(
    fellowshipId: \$fellowshipId
    presentMembers: \$presentMembers
    absentMembers: \$absentMembers
    recordId: \$recordId
  ) {
    id
    markedAttendance(fellowshipId: \$fellowshipId)
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
