import 'package:graphql_flutter/graphql_flutter.dart';

final getGovernorshipMeetings = gql('''
query getGovernorshipMeetings(\$id: ID!) {
    governorships(where: { id: \$id }) {
      id
      typename
      name
       poimenMeetings (limit: 10) {
        id
        typename
        attendance
        markedAttendance(churchId: \$id)
        serviceDate {
            date
         } 
      }
    }
  }
''');
