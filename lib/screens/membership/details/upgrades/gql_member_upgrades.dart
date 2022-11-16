import 'package:graphql_flutter/graphql_flutter.dart';

final getMemberUpgradesDetails = gql('''
 query getMemberUpgradesDetails(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      status
      firstName
      lastName
      pictureUrl
      hasHolyGhostBaptism
      hasHolyGhostBaptismDate
      hasWaterBaptism
      hasWaterBaptismDate
      graduatedUnderstandingSchools
      hasAudioCollections
      hasBibleTranslations
      attendedCampsWithProphet
      attendedCampsWithOtherBishops
    }
  }
''');

final recordMemberHolyGhostBaptismUpgrade = gql('''
mutation (
  \$memberId: ID!,
  \$hasHolyGhostBaptism: Boolean!,
  \$hasHolyGhostBaptismDate: String
) {
  SetMemberHolyGhostBaptism(
  memberId: \$memberId,
  hasHolyGhostBaptism: \$hasHolyGhostBaptism,
  hasHolyGhostBaptismDate: \$hasHolyGhostBaptismDate
  ) {
    id
    firstName
    lastName
    hasHolyGhostBaptism
    hasHolyGhostBaptismDate
    history (options: {limit: 5}) {
      id
      historyRecord
    }
  }
}
''');

final recordMemberWaterBaptismUpgrade = gql('''
mutation (
  \$memberId: ID!,
  \$hasWaterBaptism: Boolean!,
  \$hasWaterBaptismDate: String
) {
  SetMemberWaterBaptism(
  memberId: \$memberId,
  hasWaterBaptism: \$hasWaterBaptism,
  hasWaterBaptismDate: \$hasWaterBaptismDate
  ) {
    id
    firstName
    lastName
    hasWaterBaptism
    hasWaterBaptismDate
    history (options: {limit: 5}) {
      id
      historyRecord
    }
  }
}
''');
