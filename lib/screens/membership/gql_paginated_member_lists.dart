import 'package:graphql_flutter/graphql_flutter.dart';

final getGatheringMembershipNumbers = gql('''
query getGatheringMembershipNumbers(\$id: ID!) {
  gatheringServices(where: { id: \$id }) {
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

final getGatheringSheepForList = gql('''
   query getGatheringSheep(\$id: ID!, \$first: Int! \$after: Int!) {
    gatheringServices(where: { id: \$id }) {
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
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getGatheringGoatsForList = gql('''
   query getGatheringGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    gatheringServices(where: { id: \$id }) {
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
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getGatheringDeerForList = gql('''
   query getGatheringDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    gatheringServices(where: { id: \$id }) {
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
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getConstituencyMembershipNumbers = gql('''
query getConstituencyMembershipNumbers(\$id: ID!) {
  constituencies(where: { id: \$id }) {
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

final getConstituencySheepForList = gql('''
   query getConstituenciesheep(\$id: ID!, \$first: Int! \$after: Int!) {
    constituencies(where: { id: \$id }) {
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
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getConstituencyGoatsForList = gql('''
   query getConstituencyGoats(\$id: ID!, \$first: Int! \$after: Int!) {
    constituencies(where: { id: \$id }) {
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
          }  
        }
        totalCount
        position
      }
    }
  }
''');

final getConstituencyDeerForList = gql('''
   query getConstituencyDeer(\$id: ID!, \$first: Int! \$after: Int!) {
    constituencies(where: { id: \$id }) {
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
          }  
        }
        totalCount
        position
      }
    }
  }
''');
