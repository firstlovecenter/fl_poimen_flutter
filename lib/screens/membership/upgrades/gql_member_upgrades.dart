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
    status
    hasHolyGhostBaptism
    hasHolyGhostBaptismDate
    pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
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
    status
    hasWaterBaptism
    hasWaterBaptismDate
    pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
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
    status
    hasAudioCollections
    pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
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
    status
    hasBibleTranslations
    pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
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
    status
    hasCampAttendance
    pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
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
    status
    graduatedUnderstandingSchools
    pastoralComments (limit: 5) {
        id
        typename
        timestamp
        comment
        author {
          id
          typename
          firstName
          lastName
          pictureUrl
          phoneNumber
          whatsappNumber
        }
        activity
      }
  }
}
''');

final memberUnderstandingCampaigns = gql('''
query (\$memberId: ID!) {
  members (where: {id: \$memberId}){
    id
    status
    graduatedUnderstandingSchools
  }
}
''');
