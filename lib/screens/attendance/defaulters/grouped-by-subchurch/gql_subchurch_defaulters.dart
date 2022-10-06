import 'package:graphql_flutter/graphql_flutter.dart';

final getCouncilAttendanceDefaultersByConstituency = gql('''
   query getCouncilAttendanceDefaultersByConstituency(\$id: ID!) {
     councils(where: { id: \$id }) {
       id
       name
       typename
       constituencies (options: {sort: [{name: ASC}]}) {
          id
          name
          typename
          leader {
            id
            firstName
            lastName
            typename
            phoneNumber
            whatsappNumber
            pictureUrl
          }
          fellowshipServicesThisWeekCount
          fellowshipAttendanceDefaultersCount
          bacentaBussingThisWeekCount
          bacentaAttendanceDefaultersCount
       }
     }
   }
  ''');
