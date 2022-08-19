import 'package:graphql_flutter/graphql_flutter.dart';

final getUserRoles = gql('''
  query getUserRoles(\$id: String!) {
    members(where: { auth_id: \$id }) {
      id
      firstName
      lastName
      pictureUrl
      leadsFellowship {
        id
        name
      }
      leadsBacenta {
        id
        name
      }
      leadsConstituency {
        id
        name
      }
      leadsSonta {
        id
        name
      }
      leadsCouncil {
        id
        name
      }
   
      leadsGatheringService {
        id
        name
      }
      isAdminForGatheringService {
        id
        name
      }
    }
  }
''');
