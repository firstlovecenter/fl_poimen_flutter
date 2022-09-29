import 'package:graphql_flutter/graphql_flutter.dart';

final constituencyAttendanceDefaulters = gql('''
   query constituencyAttendanceDefaulters(\$id: ID!) {
     constituencies(where: { id: \$id }) {
       id
       name
       typename
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');
