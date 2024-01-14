import 'package:graphql_flutter/graphql_flutter.dart';

final getUserRoles = gql('''
  query getUserRoles(\$id: String!) {
    minimumRequiredVersion
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
      isAdminForConstituency {
        id
        typename
        name
      }
      leadsCouncil {
        id
        typename
        name
      }
      isAdminForCouncil {
        id
        typename
        name
      }
      leadsStream {
        id
        typename
        name
      }
      isAdminForStream {
        id
        typename
        name
      }
   
      leadsCampus {
        id
        typename
        name
      }
      isAdminForCampus {
        id
        typename
        name
      }

      leadsHub {
        id
        typename
        name
      }
      leadsHubCouncil {
        id
        typename
        name
      }
      leadsMinistry {
        id
        typename
        name
      }
      isAdminForMinistry {
        id
        typename
        name
      }
      leadsCreativeArts {
        id
        typename
        name
      }
      isAdminForCreativeArts {
        id
        typename
        name
      }
    }
  }
''');
