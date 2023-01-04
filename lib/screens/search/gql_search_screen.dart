import 'package:graphql_flutter/graphql_flutter.dart';

final searchFellowship = gql('''
  query searchFellowship(\$id: ID!, \$searchKey: String!){
    fellowships(where: {id: \$id}){
      id
      typename
      name
      memberSearch(key: \$searchKey) {
        id
        typename
        lost 
        firstName
        lastName
        fullName
        pictureUrl
      }
    }
  }
''');
