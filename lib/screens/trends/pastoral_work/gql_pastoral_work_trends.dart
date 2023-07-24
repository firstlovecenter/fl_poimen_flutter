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

        visitationsByChurchCount(churchId: \$id)
        prayersByChurchCount(churchId: \$id)
        telepastoringsByChurchCount(churchId: \$id)
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

        visitationsByChurchCount(churchId: \$id)
        prayersByChurchCount(churchId: \$id)
        telepastoringsByChurchCount(churchId: \$id)
      }
    }
  }
''');

getCouncilPastoralWorkCycles(String id) {
  return gql('''
    query getCouncilPastoralWorkCycles {
      councils(where: {id: "$id"}) {
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

          visitationsByChurchCount(churchId: "$id")
          prayersByChurchCount(churchId: "$id")
          telepastoringsByChurchCount(churchId: "$id")
        }
      }
    }
  ''');
}
