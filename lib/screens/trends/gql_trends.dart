import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipTrendsMenu = gql('''
  query getFellowshipTrendsMenu(\$id: ID!) {
    fellowships(where: {id: \$id}) {
      id
      typename
      name
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      } 
    }
  }
''');

final getConstituencyTrendsMenu = gql('''
  query getConstituencyTrendsMenu(\$id: ID!) {
    constituencies(where: {id: \$id}) {
      id
      typename
      name
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      } 
    }
  }
''');

final getCouncilTrendsMenu = gql('''
  query getCouncilTrendsMenu(\$id: ID!) {
    councils(where: {id: \$id}) {
      id
      typename
      name
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
      currentPastoralCycle {
        id
        typename
        startDate
        endDate
        numberOfDays
      } 
    }
  }
''');

final getStreamTrendsMenu = gql('''
  query getStreamTrendsMenu(\$id: ID!) {
    streams(where: {id: \$id}) {
      id
      typename
      name
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');

final getCampusTrendsMenu = gql('''
  query getCampusTrendsMenu(\$id: ID!) {
    campuses(where: {id: \$id}) {
      id
      typename
      name
      leader {
        id
        typename
        firstName
        lastName
        pictureUrl
        phoneNumber
        whatsappNumber
      }
    }
  }
''');
