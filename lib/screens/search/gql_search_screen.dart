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

final searchBacenta = gql('''
  query searchBacenta(\$id: ID!, \$searchKey: String!){
    bacentas(where: {id: \$id}){
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

final searchConstituency = gql('''
  query searchConstituency(\$id: ID!, \$searchKey: String!){
    constituencies(where: {id: \$id}){
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

final searchCouncil = gql('''
  query searchCouncil(\$id: ID!, \$searchKey: String!){
    councils(where: {id: \$id}){
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

final searchStream = gql('''
  query searchStream(\$id: ID!, \$searchKey: String!){
    streams(where: {id: \$id}){
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

final searchGatheringService = gql('''
  query searchGatheringService(\$id: ID!, \$searchKey: String!){
    gatheringServices(where: {id: \$id}){
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
