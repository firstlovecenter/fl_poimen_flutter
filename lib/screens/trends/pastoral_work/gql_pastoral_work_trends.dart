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

        membershipDataByChurch(churchId: \$id) {
          id
          typename
          updatedAt
          membersCount
          sheepCount
          goatsCount
          deerCount
        }
        visitationsByChurchCount(churchId: \$id)
        prayersByChurchCount(churchId: \$id)
        telepastoringsByChurchCount(churchId: \$id)
      }
    }
  }
''');

final getGovernorshipPastoralWorkCycles = gql('''
  query getGovernorshipPastoralWorkCycles(\$id: ID!) {
    governorships(where: {id: \$id}) {
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

        membershipDataByChurch(churchId: \$id) {
          id
          typename
          updatedAt
          membersCount
          sheepCount
          goatsCount
          deerCount
        }
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
      councils(where: {id: \$id}) {
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

          membershipDataByChurch(churchId: \$id) {
            id
            typename
            updatedAt
            membersCount
            sheepCount
            goatsCount
            deerCount
          }
          visitationsByChurchCount(churchId: \$id)
          prayersByChurchCount(churchId: \$id)
          telepastoringsByChurchCount(churchId: \$id)
        }
      }
    }
  ''');
}
