import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipPastoralWorkCycles = gql('''
  query getFellowshipPastoralWorkCycles(\$id: ID!) {
    fellowships(where: {id: \$id}) {
      id
      typename
      name

      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }

      pastoralCycles {
        id
        typename
        startDate
        endDate
        month
        year

        visitationsByChurch(churchId: \$id) {
          id
          typename
          memberVisited {
           id
           typename
           firstName
           lastName
           pictureUrl
           phoneNumber
           whatsappNumber
         }
        }
      }
    }
  }
''');
