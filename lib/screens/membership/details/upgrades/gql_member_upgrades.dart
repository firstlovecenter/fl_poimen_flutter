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
      hasWaterBaptism
      graduatedUnderstandingSchools
      hasAudioCollections
      hasBibleTranslations
      attendedCampsWithProphet
      attendedCampsWithOtherBishops
    }
  }
''');
