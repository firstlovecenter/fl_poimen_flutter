import { getHumanReadableDate } from '@jaedag/admin-portal-types'
import { Context } from '../utils/neo4j-types'
import { isAuth, throwErrorMsg } from '../utils/utils'
import {
  RecordMemberArgs,
  filledLastServiceType,
  setMemberStatusLost,
} from './utils-attendance'
import {
  checkIfFilled,
  getLastButOneRehearsalRecord,
  recordMembersAbsentAtService,
  recordMembersPresentAtService,
} from './cypher-rehearsal-attendance'

export const creativeArtsAttendanceResolvers = {
  RecordMembershipRehearsalAttendance: async (
    object: never,
    args: RecordMemberArgs,
    context: Context
  ) => {
    isAuth(['leaderHub'], context.auth.roles)
    const session = context.executionContext.session()
    const sessionTwo = context.executionContext.session()
    const sessionThree = context.executionContext.session()

    try {
      const serviceChecks = await Promise.all([
        session.executeRead((tx) => tx.run(checkIfFilled, args)),
        sessionTwo.executeRead((tx) =>
          tx.run(getLastButOneRehearsalRecord, args)
        ),
      ])

      const alreadyFilled: { markedAttendance: boolean }[] = (
        serviceChecks[0] as any
      ).records.map((record: any) => ({
        markedAttendance: record.get('markedAttendance'),
      }))

      const filledLastService: filledLastServiceType[] =
        serviceChecks[1].records.map((record: any) => ({
          lastService: record.get('lastService'),
          filled: record.get('filled'),
          lastDate: record.get('lastDate'),
        }))

      if (alreadyFilled[0].markedAttendance) {
        throw new Error('Attendance has already been filled for this service!')
      }

      if (filledLastService[0]?.filled === true) {
        throw new Error(
          `You have a previously unfilled reherasal meeting on ${getHumanReadableDate(
            filledLastService[0].lastDate
          )}. You must fill all past meetings before filling the current one!`
        )
      }

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

      const presentResponse = attendanceResponse[0].records.map(
        (record: any) => ({
          service: record.get('service'),
          membersPresent: record.get('membersPresent'),
        })
      )
      const absentResponse = attendanceResponse[1].records.map(
        (record: any) => ({
          service: record.get('service'),
          membersAbsent: record.get('membersAbsent'),
        })
      )
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
}

export default creativeArtsAttendanceResolvers
