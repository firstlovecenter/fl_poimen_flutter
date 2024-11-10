/* eslint-disable no-underscore-dangle */
import { Member } from '@jaedag/admin-portal-types'
import { attendanceMutations } from './attendance/resolvers-attendance'
import { cycleResolvers } from './pastoral-cycle/resolvers-cycle'
import paginationResolvers from './membership/resolvers-pagination'
import customScalars from './scalars/customScalars'
import { pastoralCommentResolvers } from './membership/pastoral-comments/resolvers-comments'
import { dutiesMutations } from './duties/resolvers-duties'
import { memberStatusResolvers } from './membership/member-upgrades/resolvers-member-status'
import { Context } from './utils/neo4j-types'
import {
  lastFourWeekdayServices,
  lastFourWeekendServices,
} from './membership/cypher-member'
import { rearrangeCypherObject, throwErrorMsg } from './utils/utils'
import { typenameResolvers } from './resolver-typenames'

const resolvers = {
  // Resolver Parameters
  // Object: the parent result of a previous resolver
  // Args: Field Arguments
  // Context: Context object, database connection, API, etc
  // GraphQLResolveInfo

  Member: {
    typename: () => 'Member',
    fullName: (source: Member) => `${source.firstName} ${source.lastName}`,
    currentTitle: async (source: Member, args: unknown, context: Context) => {
      const session = context.executionContext.session()

      const res = await session.executeRead((tx) =>
        tx.run(
          `MATCH (member:Member {id: $id})-[:HAS_GENDER]->(gender:Gender)
          MATCH (member)-[:HAS_TITLE]->(title:Title)
          RETURN member AS member, gender.gender AS gender, title.name AS title, title.priority AS priority ORDER BY priority DESC LIMIT 1`,
          {
            id: source.id,
          }
        )
      )

      const gender = res.records[0]?.get('gender')
      const title = res.records[0]?.get('title') ?? ''
      let shortTitle = ''

      if (title === 'Bishop') {
        shortTitle = 'Bishop'
      }
      if (title === 'Bishop' && gender === 'Female') {
        shortTitle = 'Mother'
      }

      if (title === 'Reverend') {
        shortTitle = 'Rev.'
      }
      if (title === 'Reverend' && gender === 'Female') {
        shortTitle = 'LR'
      }
      if (title === 'Pastor') {
        shortTitle = 'Ps.'
      }
      if (title === 'Pastor' && gender === 'Female') {
        shortTitle = 'LP'
      }

      return `${shortTitle}`
    },
    nameWithTitle: async (source: Member, args: unknown, context: Context) => {
      const session = context.executionContext.session()

      const res = await session.executeRead((tx) =>
        tx.run(
          `MATCH (member:Member {id: $id})-[:HAS_GENDER]->(gender:Gender)
          MATCH (member)-[:HAS_TITLE]->(title:Title)
          RETURN member AS member, gender.gender AS gender, title.name AS title, title.priority AS priority ORDER BY priority DESC LIMIT 1`,
          {
            id: source.id,
          }
        )
      )

      const gender = res.records[0]?.get('gender')
      const title = res.records[0]?.get('title') ?? ''
      let shortTitle = ''

      if (title === 'Bishop') {
        shortTitle = 'Bishop'
      }
      if (title === 'Bishop' && gender === 'Female') {
        shortTitle = 'Mother'
      }

      if (title === 'Reverend') {
        shortTitle = 'Rev.'
      }
      if (title === 'Reverend' && gender === 'Female') {
        shortTitle = 'LR'
      }
      if (title === 'Pastor') {
        shortTitle = 'Ps.'
      }
      if (title === 'Pastor' && gender === 'Female') {
        shortTitle = 'LP'
      }

      return `${shortTitle} ${source.firstName} ${source.lastName}`
    },
    roles: async (source: Member, args: unknown, context: Context) => {
      const session = context.executionContext.session()
      const sessionTwo = context.executionContext.session()

      try {
        const response = await Promise.all([
          session.executeRead((tx) =>
            tx.run(
              `MATCH (member:Member {id: $id})-[:LEADS]->(church)
              RETURN church.name AS name, labels(church) AS churchLabels`,
              {
                id: source.id,
              }
            )
          ),
          sessionTwo.executeRead((tx) =>
            tx.run(
              `MATCH (member:Member {id: $id})-[:IS_ADMIN_FOR]->(church)
              WHERE church:Bacenta OR church:Governorship OR church:Council OR church:Stream OR church:Campus 
              OR church:Hub OR church:HubCouncil OR church:Ministry OR church:CreativeArts OR church:Fellowship
              RETURN church.name AS name, labels(church) AS churchLabels`,
              {
                id: source.id,
              }
            )
          ),
        ])

        const leaderRoles = response[0].records.map((record) => {
          const name = record.get('name')
          const churchLabels = record.get('churchLabels')
          const churchLabel = churchLabels.filter((label: string) =>
            ['Bacenta', 'Governorship', 'Council'].includes(label)
          )
          return `${churchLabel} Leader: ${name}`
        })

        return leaderRoles.join('\n')
      } catch (error: unknown) {
        return throwErrorMsg('Error retrieving member roles', error)
      } finally {
        session.close()
      }
    },
    lastFourWeekdayServices: async (
      source: Member,
      args: { id: string },
      context: Context
    ) => {
      const session = context.executionContext.session()

      try {
        const response = rearrangeCypherObject(
          await session.executeRead((tx) =>
            tx.run(lastFourWeekdayServices, {
              id: source.id,
            })
          )
        )

        return response[0]?.services
      } catch (error: unknown) {
        return throwErrorMsg(
          'Error retrieving last four weekday services',
          error
        )
      } finally {
        session.close()
      }
    },
    lastFourWeekendServices: async (
      source: Member,
      args: { id: string },
      context: Context
    ) => {
      const session = context.executionContext.session()

      try {
        const response = rearrangeCypherObject(
          await session.executeRead((tx) =>
            tx.run(lastFourWeekendServices, {
              id: source.id,
            })
          )
        )

        return response[0]?.services
      } catch (error: unknown) {
        return throwErrorMsg(
          'Error retrieving last four weekend services',
          error
        )
      } finally {
        session.close()
      }
    },

    ...pastoralCommentResolvers.Member,
  },
  Sheep: {
    typename: () => 'Sheep',
    fullName: (source: Member) => `${source.firstName} ${source.lastName}`,
  },
  Goat: {
    typename: () => 'Goat',
    fullName: (source: Member) => `${source.firstName} ${source.lastName}`,
  },
  Deer: {
    typename: () => 'Deer',
    fullName: (source: Member) => `${source.firstName} ${source.lastName}`,
  },
  IDL: {
    typename: () => 'IDL',
    fullName: (source: Member) => `${source.firstName} ${source.lastName}`,
  },
  IMCL: {
    typename: () => 'IMCL',
    fullName: (source: Member) => `${source.firstName} ${source.lastName}`,
  },
  Campus: {
    typename: () => 'Campus',
    ...paginationResolvers.Campus,
  },
  Stream: {
    typename: () => 'Stream',
    ...paginationResolvers.Stream,
  },
  Council: {
    typename: () => 'Council',
    ...paginationResolvers.Council,
  },
  Governorship: {
    typename: () => 'Governorship',
    ...paginationResolvers.Governorship,
  },
  Bacenta: {
    typename: () => 'Bacenta',
    ...paginationResolvers.Bacenta,
  },
  Fellowship: {
    typename: () => 'Fellowship',
  },
  CreativeArts: {
    typename: () => 'CreativeArts',
  },
  Ministry: {
    typename: () => 'Ministry',
  },
  HubCouncil: {
    typename: () => 'HubCouncil',
  },
  Hub: {
    typename: () => 'Hub',
    ...paginationResolvers.Hub,
  },
  ...typenameResolvers,
  ...cycleResolvers,
  Query: {
    ...customScalars.Query,
  },
  Mutation: {
    ...memberStatusResolvers,
    ...attendanceMutations,
    ...dutiesMutations,
  },
}

export default resolvers
