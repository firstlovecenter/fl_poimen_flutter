import { Context } from '../utils/neo4j-types'
import { isAuth, rearrangeCypherObject, throwErrorMsg } from '../utils/utils'
import {
  alreadyLoggedPrayerForMember,
  alreadyLoggedTelepastoringForMember,
  alreadyLoggedVisitationForMember,
  getMemberGovernorshipPrayerLists,
  getMemberGovernorshipTelepastoringLists,
  getMemberGovernorshipVisitationLists,
  getMemberCouncilPrayerLists,
  getMemberCouncilTelepastoringLists,
  getMemberCouncilVisitationLists,
  getMemberBacentaPrayerLists,
  getMemberBacentaTelepastoringLists,
  getMemberBacentaVisitationLists,
  logMembershipData,
  logPrayerActivity,
  logTelepastoringActivity,
  logVisitationActivity,
} from './cypher-duties'

type LogPrayerActivityArgs = {
  comment: string
  roleLevel: string
  memberId: string
  cycleId: string
}

type LogTelepastoringActivityArgs = {
  comment: string
  roleLevel: string
  memberId: string
  cycleId: string
}

type LogVisitationActivityArgs = {
  latitude: number
  longitude: number
  picture: string
  comment: string
  roleLevel: string
  memberId: string
  cycleId: string
}

export const extractMemberStatus = (labels: any[]) => {
  const membershipStatus = ['Lost', 'IDL', 'Sheep', 'Goat', 'Deer', 'Member']
  return membershipStatus.find((status) => labels.includes(status))
}

export const dutiesMutations = {
  LogBacentaPrayerActivity: async (
    object: never,
    args: LogPrayerActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderBacenta'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedPrayerForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Prayer activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logPrayerActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberPrayerListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberBacentaPrayerLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const bacenta = memberPrayerListReport[0].bacenta.properties
      const { completedPrayersCount } = memberPrayerListReport[0]
      const outstandingPrayer = memberPrayerListReport[0].outstandingPrayer.map(
        (member: { properties: any; labels: string[] }) => ({
          ...member.properties,
          typename: 'Member',
          status: extractMemberStatus(member.labels),
        })
      )

      return {
        ...bacenta,
        typename: 'Bacenta',
        completedPrayersCount,
        outstandingPrayer,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },

  LogGovernorshipPrayerActivity: async (
    object: never,
    args: LogPrayerActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderGovernorship'], context.auth.roles)
    const session = context.executionContext.session()
    const sessionTwo = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedPrayerForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Prayer activity has already been logged for this member during this cycle!'
        )
      }

      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logPrayerActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberPrayerListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberGovernorshipPrayerLists, {
            ...args,
            auth: context.auth,
          })
        )
      )

      const governorship = memberPrayerListReport[0].governorship.properties
      const { completedPrayersCount } = memberPrayerListReport[0]
      const outstandingPrayer = memberPrayerListReport[0].outstandingPrayer.map(
        (member: { properties: any; labels: string[] }) => ({
          ...member.properties,
          typename: 'Member',
          status: extractMemberStatus(member.labels),
        })
      )

      return {
        ...governorship,
        typename: 'Governorship',
        completedPrayersCount,
        outstandingPrayer,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },
  LogCouncilPrayerActivity: async (
    object: never,
    args: LogPrayerActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderCouncil'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedPrayerForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Prayer activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logPrayerActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberPrayerListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberCouncilPrayerLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const council = memberPrayerListReport[0].council.properties
      const { completedPrayersCount } = memberPrayerListReport[0]
      const outstandingPrayer = memberPrayerListReport[0].outstandingPrayer.map(
        (member: { properties: any; labels: string[] }) => ({
          ...member.properties,
          typename: 'Member',
          status: extractMemberStatus(member.labels),
        })
      )

      return {
        ...council,
        typename: 'Council',
        completedPrayersCount,
        outstandingPrayer,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },

  LogBacentaTelepastoringActivity: async (
    object: never,
    args: LogTelepastoringActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderBacenta'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedTelepastoringForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Telepastoring activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logTelepastoringActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberTelepastoringListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberBacentaTelepastoringLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const bacenta = memberTelepastoringListReport[0].bacenta.properties
      const { completedTelepastoringCount } = memberTelepastoringListReport[0]
      const outstandingTelepastoring =
        memberTelepastoringListReport[0].outstandingTelepastoring.map(
          (member: { properties: any; labels: string[] }) => ({
            ...member.properties,
            typename: 'Member',
            status: extractMemberStatus(member.labels),
          })
        )

      return {
        ...bacenta,
        typename: 'Bacenta',
        completedTelepastoringCount,
        outstandingTelepastoring,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },

  LogGovernorshipTelepastoringActivity: async (
    object: never,
    args: LogTelepastoringActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderGovernorship'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedTelepastoringForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Telepastoring activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logTelepastoringActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberTelepastoringListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberGovernorshipTelepastoringLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const governorship =
        memberTelepastoringListReport[0].governorship.properties
      const { completedTelepastoringCount } = memberTelepastoringListReport[0]
      const outstandingTelepastoring =
        memberTelepastoringListReport[0].outstandingTelepastoring.map(
          (member: { properties: any; labels: string[] }) => ({
            ...member.properties,
            typename: 'Member',
            status: extractMemberStatus(member.labels),
          })
        )

      return {
        ...governorship,
        typename: 'Governorship',
        completedTelepastoringCount,
        outstandingTelepastoring,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },
  LogCouncilTelepastoringActivity: async (
    object: never,
    args: LogTelepastoringActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderCouncil'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedTelepastoringForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Telepastoring activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logTelepastoringActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberTelepastoringListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberCouncilTelepastoringLists, {
            ...args,
            auth: context.auth,
          })
        )
      )

      sessionTwo.close()

      const council = memberTelepastoringListReport[0].council.properties
      const { completedTelepastoringCount } = memberTelepastoringListReport[0]
      const outstandingTelepastoring =
        memberTelepastoringListReport[0].outstandingTelepastoring.map(
          (member: { properties: any; labels: string[] }) => ({
            ...member.properties,
            typename: 'Member',
            status: extractMemberStatus(member.labels),
          })
        )

      return {
        ...council,
        typename: 'Council',
        completedTelepastoringCount,
        outstandingTelepastoring,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },

  LogBacentaVisitationActivity: async (
    object: never,
    args: LogVisitationActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderBacenta'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedVisitationForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Visitation activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logVisitationActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberVisitationListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberBacentaVisitationLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const bacenta = memberVisitationListReport[0].bacenta.properties
      const { completedVisitationsCount } = memberVisitationListReport[0]
      const outstandingVisitations =
        memberVisitationListReport[0].outstandingVisitations.map(
          (member: { properties: any; labels: string[] }) => ({
            ...member.properties,
            typename: 'Member',
            status: extractMemberStatus(member.labels),
          })
        )

      const outstandingIDLsList =
        memberVisitationListReport[0].outstandingVisitations.filter(
          (member: { properties: any; labels: string[] }) =>
            extractMemberStatus(member.labels) === 'IDL'
        )

      const outstandingIDLs = outstandingIDLsList.map(
        (member: { properties: any; labels: string[] }) => ({
          ...member.properties,
          typename: 'Member',
          status: extractMemberStatus(member.labels),
        })
      )

      return {
        ...bacenta,
        typename: 'Bacenta',
        completedVisitationsCount,
        outstandingVisitations,
        idls: outstandingIDLs,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },

  LogGovernorshipVisitationActivity: async (
    object: never,
    args: LogVisitationActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderGovernorship'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedVisitationForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Visitation activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logVisitationActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberVisitationListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberGovernorshipVisitationLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const governorship = memberVisitationListReport[0].governorship.properties
      const { completedVisitationsCount } = memberVisitationListReport[0]
      const outstandingVisitations =
        memberVisitationListReport[0].outstandingVisitations.map(
          (member: { properties: any; labels: string[] }) => ({
            ...member.properties,
            typename: 'Member',
            status: extractMemberStatus(member.labels),
          })
        )

      return {
        ...governorship,
        typename: 'Governorship',
        completedVisitationsCount,
        outstandingVisitations,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },
  LogCouncilVisitationActivity: async (
    object: never,
    args: LogVisitationActivityArgs,
    context: Context
  ) => {
    isAuth(['leaderCouncil'], context.auth.roles)
    const session = context.executionContext.session()

    try {
      const alreadyFilled = rearrangeCypherObject(
        await session.executeRead((tx) =>
          tx.run(alreadyLoggedVisitationForMember, {
            ...args,
            auth: context.auth,
          })
        )
      )

      if (alreadyFilled[0]) {
        return throwErrorMsg(
          'Visitation activity has already been logged for this member during this cycle!'
        )
      }

      const sessionTwo = context.executionContext.session()
      await Promise.all([
        session.executeWrite((tx) =>
          tx.run(logVisitationActivity, {
            ...args,
            auth: context.auth,
          })
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(logMembershipData, {
            ...args,
            auth: context.auth,
          })
        ),
      ])

      const memberVisitationListReport = rearrangeCypherObject(
        await sessionTwo.executeRead((tx) =>
          tx.run(getMemberCouncilVisitationLists, {
            ...args,
            auth: context.auth,
          })
        )
      )
      sessionTwo.close()

      const council = memberVisitationListReport[0].council.properties
      const { completedVisitationsCount } = memberVisitationListReport[0]
      const outstandingVisitations =
        memberVisitationListReport[0].outstandingVisitations.map(
          (member: { properties: any; labels: string[] }) => ({
            ...member.properties,
            typename: 'Member',
            status: extractMemberStatus(member.labels),
          })
        )

      return {
        ...council,
        typename: 'Council',
        completedVisitationsCount,
        outstandingVisitations,
      }
    } catch (error) {
      return throwErrorMsg(error)
    } finally {
      session.close()
    }
  },
}

export default dutiesMutations
