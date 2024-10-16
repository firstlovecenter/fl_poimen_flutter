import 'package:graphql_flutter/graphql_flutter.dart';

final getCampusMembershipNumbers = gql('''
query getCampusMembershipNumbers(\$id: ID!) {
  campuses(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getCampusSheepForList = gql('''
   query getCampusSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    campuses(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            phoneNumber
            whatsappNumber
            pictureUrl
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getCampusGoatsForList = gql('''
   query getCampusGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    campuses(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getCampusDeerForList = gql('''
   query getCampusDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    campuses(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getStreamMembershipNumbers = gql('''
query getStreamMembershipNumbers(\$id: ID!) {
  streams(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getStreamSheepForList = gql('''
   query getStreamSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    streams(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getStreamGoatsForList = gql('''
   query getStreamGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    streams(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getStreamDeerForList = gql('''
   query getStreamDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    streams(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getCouncilMembershipNumbers = gql('''
query getCouncilMembershipNumbers(\$id: ID!) {
  councils(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getCouncilSheepForList = gql('''
   query getCouncilSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    councils(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getCouncilGoatsForList = gql('''
   query getCouncilGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    councils(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getCouncilDeerForList = gql('''
   query getCouncilDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    councils(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getGovernorshipMembershipNumbers = gql('''
query getGovernorshipMembershipNumbers(\$id: ID!) {
  governorships(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getGovernorshipSheepForList = gql('''
   query getGovernorshipsheep(\$id: ID!, \$first: Int! \$after: Int!) {
    governorships(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getGovernorshipGoatsForList = gql('''
   query getGovernorshipGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    governorships(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getGovernorshipDeerForList = gql('''
   query getGovernorshipDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    governorships(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getBacentaMembershipNumbers = gql('''
query getBacentaMembershipNumbers(\$id: ID!) {
  bacentas(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getBacentaSheepForList = gql('''
   query getBacentaSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getBacentaGoatsForList = gql('''
   query getBacentaGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getBacentaDeerForList = gql('''
   query getBacentaDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    bacentas(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getFellowshipMembershipNumbers = gql('''
query getFellowshipMembershipNumbers(\$id: ID!) {
  fellowships(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getFellowshipSheepForList = gql('''
   query getFellowshipSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getFellowshipGoatsForList = gql('''
   query getFellowshipGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getFellowshipDeerForList = gql('''
   query getFellowshipDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    fellowships(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getHubMembershipNumbers = gql('''
query getHubMembershipNumbers(\$id: ID!) {
  hubs(where: { id: \$id }) {
    id
    typename
    name

    sheepPaginated {
      totalCount
    }
    goatsPaginated {
      totalCount
    }
    deerPaginated {
      totalCount
    }
  }
}
''');

final getHubSheepForList = gql('''
   query getHubSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    hubs(where: { id: \$id }) {
      id
      typename
      name

      sheepPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getHubGoatsForList = gql('''
   query getHubGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    hubs(where: { id: \$id }) {
      id
      typename
      name

      goatsPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getHubDeerForList = gql('''
   query getHubDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    hubs(where: { id: \$id }) {
      id
      typename
      name

      deerPaginated(first: \$first, after: \$after) {
        edges {
          node {
            id
            typename
            lost 
            firstName
            lastName
            fullName
            pictureUrl
            phoneNumber
            whatsappNumber
          }  
        }
        totalCount
        position
      }
    }
  }
''');
