import 'package:graphql_flutter/graphql_flutter.dart';

final getUserRoles = gql('''
  query getUserRoles(\$id: String!) {
    members(where: { auth_id: \$id }) {
      id
      typename
      firstName
      lastName
      pictureUrl
      leadsFellowship {
        id
        typename
        name
      }
      leadsConstituency {
        id
        typename
        name
      }
      leadsSonta {
        id
        name
      }
      leadsCouncil {
        id
        typename
        name
      }
      leadsStream {
        id
        typename
        name
      }
   
      leadsGatheringService {
        id
        typename
        name
      }
      isAdminForGatheringService {
        id
        typename
        name
      }
    }
  }
''');
