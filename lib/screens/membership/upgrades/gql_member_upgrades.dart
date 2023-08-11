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
