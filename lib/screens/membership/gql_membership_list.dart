import 'package:graphql_flutter/graphql_flutter.dart';

final getFellowshipMembers = gql('''
   query getFellowshipMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    fellowships(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');

final getBacentaMembers = gql('''
   query getBacentaMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    bacentas (where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');

final getConstituencyMembers = gql('''
   query getConstituencyMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    constituencies(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');

final getCouncilMembers = gql('''
   query getCouncilMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    councils(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');

final getStreamMembers = gql('''
   query getStreamMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    streams(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');

final getGatheringMembers = gql('''
   query getGatheringMembers(\$id: ID!, \$serviceRecordId: ID) {
    serviceRecords(where: { id: \$serviceRecordId }, options: { limit: 1 }) {
      id
      serviceDate {
        date
      }
    }
    gatheringServices(where: { id: \$id }) {
      id
      typename
      name

      sheep {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      goats {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
      deer {
        id
        typename
        firstName
        lastName
        fullName
        pictureUrl
        gender {
          gender
        }
        dob {
          date
        }
        phoneNumber
      }
    }
  }
''');
