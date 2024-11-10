import { Context } from '../utils/neo4j-types'
import { isAuth, rearrangeCypherObject, throwErrorMsg } from '../utils/utils'
import {
  checkIfFilled,
  recordMembersPresentAtService,
  recordMembersAbsentAtService,
  getLastButOneServiceRecord,
  getLastButOneBussingRecord,
  checkIfRecordExistsForDate,
  recordMembersPresentOnDate,
  recordMembersAbsentOnDate,
} from './cypher-attendance'
import {
  setMemberStatusLost,
  checkLastServiceIsFilled,
  filledLastServiceType,
  RecordMemberArgs,
} from './utils-attendance'
import { creativeArtsAttendanceResolvers } from './resolvers-creativearts-attendance'

export const attendanceMutations = {
  RecordMembershipAttendance: async (
    object: never,
    args: RecordMemberArgs,
    context: Context
  ) => {
    isAuth(['leaderBacenta'], context.auth.roles)
    const session = context.executionContext.session()
    const sessionTwo = context.executionContext.session()
    const sessionThree = context.executionContext.session()

    try {
      const serviceChecks = await Promise.all([
        session.executeRead((tx) => tx.run(checkIfFilled, args)),
        sessionTwo.executeRead((tx) =>
          tx.run(getLastButOneServiceRecord, args)
        ),
        sessionThree.executeRead((tx) =>
          tx.run(getLastButOneBussingRecord, args)
        ),
      ])
      const alreadyFilled: { markedAttendance: boolean }[] =
        rearrangeCypherObject(serviceChecks[0])
      const filledLastService: filledLastServiceType[] = rearrangeCypherObject(
        serviceChecks[1]
      )
      const filledLastBussing: filledLastServiceType[] = rearrangeCypherObject(
        serviceChecks[2]
      )

      if (alreadyFilled[0].markedAttendance) {
        throw new Error('Attendance has already been filled for this service!')
      }

      checkLastServiceIsFilled(filledLastBussing[0], filledLastService[0])

      const attendanceResponse = await Promise.all([
        session.executeWrite((tx) =>
          tx.run(recordMembersPresentAtService, args)
        ),
        sessionTwo.executeWrite((tx) =>
          tx.run(recordMembersAbsentAtService, args)
        ),
      ])

      const members = args.presentMembers.concat(args.absentMembers)

      await Promise.all(
        members.map((memberId) => setMemberStatusLost(memberId, context))
      )

      const presentResponse = rearrangeCypherObject(attendanceResponse[0])
      const absentResponse = rearrangeCypherObject(attendanceResponse[1])
      const serviceRecord =
        presentResponse[0]?.service ?? absentResponse[0]?.service

      return {
        ...serviceRecord.properties,
        markedAttendance: true,
        membersPresent:
          presentResponse.length === 0
            ? []
            : presentResponse[0].membersPresent.map(
                (member: { properties: any }) => member.properties
              ),
        membersAbsent:
          absentResponse.length === 0
            ? []
            : absentResponse[0].membersAbsent.map(
                (member: { properties: any }) => member.properties
              ),
      }
    } catch (error) {
      console.log('🚀 ~ error:', error)

      return throwErrorMsg(error)
    } finally {
      await Promise.all([
        session.close(),
        sessionTwo.close(),
        sessionThree.close(),
      ])
    }
  },
  RecordMembershipAttendanceOnDate: async (
    object: never,
    args: RecordMemberArgs,
    context: Context
  ) => {
    isAuth(
      ['leaderGovernorship', 'adminGovernorship', 'leaderGovernorship'],
      context.auth.roles
    )

    const session = context.executionContext.session()
    const sessionTwo = context.executionContext.session()
    const sessionThree = context.executionContext.session()

    try {
      const serviceChecks = await Promise.all([
        session.executeRead((tx) => tx.run(checkIfRecordExistsForDate, args)),
      ])
      const alreadyFilled: { recordExists: boolean }[] = rearrangeCypherObject(
        serviceChecks[0]
      )

      if (alreadyFilled[0].recordExists) {
        throw new Error('Attendance has already been filled for this date!')
      }

      const attendanceResponse = await Promise.all([
        session.executeWrite((tx) => tx.run(recordMembersPresentOnDate, args)),
        sessionTwo.executeWrite((tx) =>
          tx.run(recordMembersAbsentOnDate, args)
        ),
      ])

      const members = args.presentMembers.concat(args.absentMembers)

      await Promise.all(
        members.map((memberId) => setMemberStatusLost(memberId, context))
      )

      const presentResponse = rearrangeCypherObject(attendanceResponse[0])

      const absentResponse = rearrangeCypherObject(attendanceResponse[1])
      const serviceRecord =
        presentResponse[0]?.service ?? absentResponse[0]?.service

      return {
        ...serviceRecord.properties,
        markedAttendance: true,
        membersPresent:
          presentResponse.length === 0
            ? []
            : presentResponse[0].membersPresent.map(
                (member: { properties: any }) => member.properties
              ),
        membersAbsent:
          absentResponse.length === 0
            ? []
            : absentResponse[0].membersAbsent.map(
                (member: { properties: any }) => member.properties
              ),
      }
    } catch (error) {
      console.error('🚀 ~ error:', error)

      return throwErrorMsg(error)
    } finally {
      await Promise.all([
        session.close(),
        sessionTwo.close(),
        sessionThree.close(),
      ])
    }
  },
  ...creativeArtsAttendanceResolvers,
}

export default attendanceMutations
