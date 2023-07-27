import 'package:graphql_flutter/graphql_flutter.dart';

final getConstituencySubLeaders = gql('''
query getConstituencySubLeaders(\$id: ID!) {
  constituencies(where: {id: \$id}) {
    id
    typename
    name
    subChurches {
      id
      name
      typename

      memberCount 

      completedVisitationsCount
      completedTelepastoringCount
      completedPrayersCount

      leader {
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
''');
