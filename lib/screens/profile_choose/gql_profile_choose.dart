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
        currentPastoralCycle {
          typename
          startDate
          endDate
          numberOfDays
        }
      }
      leadsBacenta {
        id
        typename
        name
        currentPastoralCycle {
          typename
          startDate
          endDate
          numberOfDays
        }
      }
      leadsConstituency {
        id
        typename
        name
        imclTotal
        currentPastoralCycle {
          typename
          startDate
          endDate
          numberOfDays
        }
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
        currentPastoralCycle {
          typename
          startDate
          endDate
          numberOfDays
        }
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
