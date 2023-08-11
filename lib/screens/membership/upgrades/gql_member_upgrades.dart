import 'package:graphql_flutter/graphql_flutter.dart';

final getMemberSpiritualProgression = gql('''
 query getMemberSpiritualProgression(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      status
      firstName
      lastName
      pictureUrl
      phoneNumber
      whatsappNumber
      spiritualProgression {
        salvation
        waterBaptism
        holyGhostBaptism
        newBelieversSchool
        strongChristiansAcademy
        understandingSchools1
        understandingSchools2
        understandingSchools3
        attendedCamp1
        attendedCamp2
        attendedCamp3
        foundersIntimateCounselling
        leadPastorIntimateCounselling
        bacentaLeader
        basontaLeader
        creativeArtsLeader
        pastor
        hasMakariosCollection
        hasAudioCollection
        onBacentaWhatsappGroup
        }
      }
  }
''');

final getMemberLifeProgression = gql('''
 query getMemberLifeProgression(\$id: ID!) {
    members(where: { id: \$id }) {
      id
      typename
      status
      firstName
      lastName
      pictureUrl
      phoneNumber
      whatsappNumber
      lifeProgression {
        married
        childbirth
        universityEducation
        ownsHouseOrBuildingProject
      }
    }
  } 
''');

final updateMemberLifeProgression = gql('''
mutation (
  \$memberId: ID!,
  \$married: Boolean!,
  \$childbirth: Boolean!,
  \$ownsHouseOrBuildingProject: Boolean!,
  \$universityEducation: Boolean!
) {
  UpdateMemberLifeProgression(
  memberId: \$memberId,
  married: \$married,
  childbirth: \$childbirth,
  ownsHouseOrBuildingProject: \$ownsHouseOrBuildingProject,
  universityEducation: \$universityEducation

  ) {
    id
    typename
    firstName
    lastName
    status
    lifeProgression {
        married
        childbirth
        universityEducation
        ownsHouseOrBuildingProject
    }
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

final updateMemberSpiritualProgression = gql('''
mutation (
  \$memberId: ID!,
  \$salvation: Boolean!,
  \$waterBaptism: Boolean!,
  \$holyGhostBaptism: Boolean!,
  \$newBelieversSchool: Boolean!,
  \$strongChristiansAcademy: Boolean!,
  \$understandingSchools1: Boolean!,
  \$understandingSchools2: Boolean!,
  \$understandingSchools3: Boolean!,
  \$attendedCamp1: Boolean!,
  \$attendedCamp2: Boolean!,
  \$attendedCamp3: Boolean!,
  \$foundersIntimateCounselling: Boolean!,
  \$leadPastorIntimateCounselling: Boolean!,
  \$bacentaLeader: Boolean!,
  \$basontaLeader: Boolean!,
  \$creativeArtsLeader: Boolean!,
  \$hasMakariosCollection: Boolean!,
  \$hasAudioCollection: Boolean!,
  \$onBacentaWhatsappGroup: Boolean!,
) {
  UpdateMemberSpiritualProgression(
  memberId: \$memberId,
  salvation: \$salvation,
  waterBaptism: \$waterBaptism,
  holyGhostBaptism: \$holyGhostBaptism,
  newBelieversSchool: \$newBelieversSchool,
  strongChristiansAcademy: \$strongChristiansAcademy,
  understandingSchools1: \$understandingSchools1,
  understandingSchools2: \$understandingSchools2,
  understandingSchools3: \$understandingSchools3,
  attendedCamp1: \$attendedCamp1,
  attendedCamp2: \$attendedCamp2,
  attendedCamp3: \$attendedCamp3,
  foundersIntimateCounselling: \$foundersIntimateCounselling,
  leadPastorIntimateCounselling: \$leadPastorIntimateCounselling,
  bacentaLeader: \$bacentaLeader,
  basontaLeader: \$basontaLeader,
  creativeArtsLeader: \$creativeArtsLeader,
  hasMakariosCollection: \$hasMakariosCollection,
  hasAudioCollection: \$hasAudioCollection,
  onBacentaWhatsappGroup: \$onBacentaWhatsappGroup,
  ) {
    id
    typename
    firstName
    lastName
    status
    spiritualProgression {
        salvation
        waterBaptism
        holyGhostBaptism
        newBelieversSchool
        strongChristiansAcademy
        understandingSchools1
        understandingSchools2
        understandingSchools3
        attendedCamp1
        attendedCamp2
        attendedCamp3
        foundersIntimateCounselling
        leadPastorIntimateCounselling
        bacentaLeader
        basontaLeader
        creativeArtsLeader
        pastor
        hasMakariosCollection
        hasAudioCollection
        onBacentaWhatsappGroup
    }
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
