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
        typename
        id
        name
      }
      leadsBacenta {
        id
        typename
        name
      }
      leadsConstituency {
        id
        typename
        name
        imclTotal
      }
      leadsSonta {
        id
        name
      }
      leadsCouncil {
        id
        typename
        name
        imclTotal
      }
      leadsStream {
        id
        typename
        name
        imclTotal
      }
   
      leadsGatheringService {
        id
        typename
        name
        imclTotal
      }
      isAdminForGatheringService {
        id
        typename
        name
        imclTotal
      }
    }
  }
''');
