import { Member } from '@jaedag/admin-portal-types'
import { Context } from '../../utils/neo4j-types'
import { rearrangeCypherObject, throwErrorMsg } from '../../utils/utils'
import { memberComments } from './cypher-comments'
import { ChurchLevel, Role } from '../../utils/types'

const getChurchLevelFromAuth = (roles: Role[]): ChurchLevel[] => {
  if (roles.some((role) => ['leaderCampus', 'adminCampus'].includes(role))) {
    return [
      'Campus',
      'Stream',
      'Council',
      'Governorship',
      'Bacenta',
      'Fellowship',
    ]
  }

  if (roles.some((role) => ['leaderStream', 'adminStream'].includes(role))) {
    return ['Stream', 'Council', 'Governorship', 'Bacenta', 'Fellowship']
  }
  if (roles.some((role) => ['leaderCouncil', 'adminCouncil'].includes(role))) {
    return ['Council', 'Governorship', 'Bacenta', 'Fellowship']
  }
  if (
    roles.some((role) =>
      ['leaderGovernorship', 'adminGovernorship'].includes(role)
    )
  ) {
    return ['Governorship', 'Bacenta', 'Fellowship']
  }
  if (roles.some((role) => ['leaderBacenta'].includes(role))) {
    return ['Bacenta', 'Fellowship']
  }
  if (roles.some((role) => ['leaderFellowship'].includes(role))) {
    return ['Fellowship']
  }

  return ['Fellowship']
}

export const pastoralCommentResolvers = {
  Member: {
    pastoralComments: async (
      member: Member,
      args: { limit: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      try {
        const results = rearrangeCypherObject(
          await session.executeRead((tx: any) =>
            tx.run(memberComments, {
              memberId: member.id,
              limit: args.limit,
              roleLevel: getChurchLevelFromAuth(
                context.auth.jwt['https://flcadmin.netlify.app/roles']
              ),
            })
          )
        )

        const response: any = results.map((result) => {
          return {
            ...result.comment.properties,
            author: result.author.properties,
          }
        })

        return response
      } catch (error: unknown) {
        return throwErrorMsg(error)
      } finally {
        session.close()
      }
    },
  },
}

export default pastoralCommentResolvers
