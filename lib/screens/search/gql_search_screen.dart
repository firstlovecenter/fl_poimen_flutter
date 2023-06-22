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
        phoneNumber
        whatsappNumber
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
        phoneNumber
        whatsappNumber
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
        phoneNumber
        whatsappNumber
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
        phoneNumber
        whatsappNumber
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
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final searchCampus = gql('''
  query searchCampus(\$id: ID!, \$searchKey: String!){
    campuses(where: {id: \$id}){
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
        phoneNumber
        whatsappNumber
      }
    }
  }
''');
