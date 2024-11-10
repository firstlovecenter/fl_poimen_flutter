import {
  GraphQLError,
  GraphQLScalarSerializer,
  GraphQLScalarType,
  GraphQLScalarValueParser,
  Kind,
} from 'graphql'

export const understandingSchoolOptions = [
  'New Believers School',
  'Fruitful Believers School',
  'School of the Word',
  'School of Victorious Living',
  'School of Solid Foundation',
  'School of Evangelism',
  'School of Apologetics',
]

const schoolOption = (value: string) => {
  if (understandingSchoolOptions.includes(value)) {
    return value
  }

  throw new GraphQLError('School option is not valid', {
    extensions: { code: 'BAD_USER_INPUT' },
  })
}

const customScalars = {
  UnderstandingSchools: new GraphQLScalarType({
    name: 'UnderstandingSchool',
    description: 'One of the First Love Church Understanding Campaing Schools',
    parseValue: schoolOption as GraphQLScalarValueParser<string>,
    serialize: schoolOption as GraphQLScalarSerializer<string>,
    parseLiteral(ast) {
      if (ast.kind === Kind.STRING) {
        return schoolOption(ast.value)
      }

      throw new GraphQLError('School option is not valid', {
        extensions: { code: 'BAD_USER_INPUT' },
      })
    },
  }),
  Query: {
    understandingSchools(_: any, { school }: { school: string }) {
      return schoolOption(school)
    },
  },
}

export default customScalars
