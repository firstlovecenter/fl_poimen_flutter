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

final getCouncilSubLeaders = gql('''
query getCouncilSubLeaders(\$id: ID!) {
  councils(where: {id: \$id}) {
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

final getStreamSubLeaders = gql('''
query getStreamSubLeaders(\$id: ID!) {
  streams(where: {id: \$id}) {
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

final getCampusSubLeaders = gql('''
query getCampusSubLeaders(\$id: ID!) {
  campuses(where: {id: \$id}) {
    id
    typename
    name
    subChurches {
      id
      name
      typename

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
