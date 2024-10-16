import 'package:graphql_flutter/graphql_flutter.dart';

final recordMembershipAttendanceOnDate = gql('''
 mutation RecordMembershipAttendanceOnDate(
  \$constituencyId: ID!
  \$presentMembers: [ID!]!
  \$absentMembers: [ID!]!
  \$date: String!
) {
  RecordMembershipAttendanceOnDate(
    constituencyId: \$constituencyId
    presentMembers: \$presentMembers
    absentMembers: \$absentMembers
    date: \$date
  ) {
    id
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

final recordMembershipAttendance = gql('''
 mutation RecordMembershipAttendance(
  \$bacentaId: ID!
  \$presentMembers: [ID!]!
  \$absentMembers: [ID!]!
  \$recordId: ID!
) {
  RecordMembershipAttendance(
    bacentaId: \$bacentaId
    presentMembers: \$presentMembers
    absentMembers: \$absentMembers
    recordId: \$recordId
  ) {
    id
    markedAttendance(churchId: \$bacentaId)
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

final recordMembershipRehearsalAttendance = gql('''
 mutation RecordMembershipRehearsalAttendance(
  \$hubId: ID!
  \$presentMembers: [ID!]!
  \$absentMembers: [ID!]!
  \$recordId: ID!
) {
  RecordMembershipRehearsalAttendance(
    hubId: \$hubId
    presentMembers: \$presentMembers
    absentMembers: \$absentMembers
    recordId: \$recordId
  ) {
    id
    markedAttendance(churchId: \$hubId)
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
