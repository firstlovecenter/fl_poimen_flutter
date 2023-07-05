import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipTrendsMenu = gql('''
  query getFellowshipTrendsMenu(\$id: ID!) {
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
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      } 
    }
  }
''');
