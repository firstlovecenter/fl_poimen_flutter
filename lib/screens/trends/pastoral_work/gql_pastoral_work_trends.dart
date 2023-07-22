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
        numberOfDays
        startDate
        endDate

        visitationsByChurch(churchId: \$id) {
          id
          typename
          datetime
          
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

        prayersByChurch(churchId: \$id) {
          id
          typename
          datetime
          
          memberPrayedFor {
           id
           typename
           firstName
           lastName
           pictureUrl
           phoneNumber
           whatsappNumber
         }
        }

        telepastoringsByChurch(churchId: \$id) {
          id
          typename
          datetime
          
          memberTelepastored {
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

final getConstituencyPastoralWorkCycles = gql('''
  query getConstituencyPastoralWorkCycles(\$id: ID!) {
    constituencies(where: {id: \$id}) {
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
        numberOfDays
        startDate
        endDate

        visitationsByChurch(churchId: \$id) {
          id
          typename
          datetime
          
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

        prayersByChurch(churchId: \$id) {
          id
          typename
          datetime
          
          memberPrayedFor {
           id
           typename
           firstName
           lastName
           pictureUrl
           phoneNumber
           whatsappNumber
         }
        }

        telepastoringsByChurch(churchId: \$id) {
          id
          typename
          datetime
          
          memberTelepastored {
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
