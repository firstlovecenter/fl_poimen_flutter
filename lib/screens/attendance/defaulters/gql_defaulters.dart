import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencyAttendanceDefaulters = gql('''
   query getConstituencyAttendanceDefaulters(\$id: ID!) {
     constituencies(where: { id: \$id }) {
       id
       name
       typename
       fellowshipAttendanceDefaultersCount
       bacentaAttendanceDefaultersCount
     }
   }
  ''');
