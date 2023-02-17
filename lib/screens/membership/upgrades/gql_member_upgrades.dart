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
      phoneNumber
      whatsappNumber
      hasHolyGhostBaptism
      hasHolyGhostBaptismDate
      hasWaterBaptism
      hasWaterBaptismDate
      graduatedUnderstandingSchools
      hasAudioCollections
      hasBibleTranslations
      hasCampAttendance
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
    pastoralComments (limit: 5) {
        id
        timestamp
        comment
        activity
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
    pastoralComments (limit: 5) {
        id
        timestamp
        comment
        activity
    }
  }
}
''');

final recordMemberAudioCollectionsUpgrade = gql('''
mutation (
  \$memberId: ID!,
  \$hasAudioCollections: Boolean!
) {
  SetMemberAudioCollections(
  memberId: \$memberId,
  hasAudioCollections: \$hasAudioCollections
  ) {
    id
    firstName
    lastName
    hasAudioCollections
    pastoralComments (limit: 5) {
        id
        timestamp
        comment
        activity
    }
  }
}
''');

final recordMemberBibleTranslationsUpgrade = gql('''
mutation (
  \$memberId: ID!,
  \$hasBibleTranslations: Boolean!
) {
  SetMemberBibleTranslations(
  memberId: \$memberId,
  hasBibleTranslations: \$hasBibleTranslations
  ) {
    id
    firstName
    lastName
    hasBibleTranslations
    pastoralComments (limit: 5) {
        id
        timestamp
        comment
        activity
    }
  }
}
''');

final recordMemberCampAttendanceUpgrade = gql('''
mutation (
  \$memberId: ID!,
  \$hasCampAttendance: Boolean!
) {
  SetMemberCampAttendance(
  memberId: \$memberId,
  hasCampAttendance: \$hasCampAttendance
  ) {
    id
    firstName
    lastName
    hasCampAttendance
    pastoralComments (limit: 5) {
        id
        timestamp
        comment
        activity
    }
  }
}
''');

final recordMemberUnderstandingCampaignUpgrade = gql('''
mutation (
  \$memberId: ID!,
  \$graduatedUnderstandingSchools: [UnderstandingSchools!]!
) {
  SetMemberUnderstandingCampaignGraduated(
  memberId: \$memberId,
  graduatedUnderstandingSchools: \$graduatedUnderstandingSchools
  ) {
    id
    firstName
    lastName
    graduatedUnderstandingSchools
    pastoralComments (limit: 5) {
        id
        timestamp
        comment
        activity
    }
  }
}
''');

final memberUnderstandingCampaings = gql('''
query (\$memberId: ID!) {
  members (where: {id: \$memberId}){
    id
    graduatedUnderstandingSchools
  }
}
''');
