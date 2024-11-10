import { getHumanReadableDate } from '@jaedag/admin-portal-types'
import { Context } from '../utils/neo4j-types'
import { throwErrorMsg } from '../utils/utils'
import { getMembersLastService } from './cypher-attendance'
import {
  setMemberLost,
  setMemberToDeer,
  setMemberToGoat,
  setMemberToSheep,
} from '../membership/member-upgrades/cypher-member-category'

export type RecordMemberArgs = {
  recordId: string
  presentMembers: string[]
  absentMembers: string[]
}

export type serviceType = {
  memberId: string
  firstName: string
  lastName: string
  fullName: string
  memberStatus: ('Sheep' | 'Goat' | 'Deer' | 'Lost')[]
  lastMissedServiceDate: Date
  lastAttendedServiceDate: Date
}

type MemberWithNames = {
  __typename: string[]
  id: string
  firstName: string
  lastName: string
  fullName: string
}

export const setMemberStatusLost = async (
  memberId: string,
  context: Context
): Promise<MemberWithNames> => {
  const session = context.executionContext.session()

  try {
    const lastServiceResponse = await session.executeRead((tx) =>
      tx.run(getMembersLastService, { memberId, auth: context.auth })
    )

    const lastService: serviceType = {
      memberId,
      firstName: lastServiceResponse.records[0]?.get('firstName'),
      lastName: lastServiceResponse.records[0]?.get('lastName'),
      fullName: `${lastServiceResponse.records[0]?.get(
        'firstName'
      )} ${lastServiceResponse.records[0]?.get('lastName')}`,
      memberStatus: lastServiceResponse.records[0]?.get('memberStatus'),
      lastMissedServiceDate: lastServiceResponse.records[0]?.get(
        'lastMissedServiceDate'
      ),
      lastAttendedServiceDate: lastServiceResponse.records[0]?.get(
        'lastAttendedServiceDate'
      ),
    }
    const memberNames = {
      id: memberId,
      __typename: lastService.memberStatus,
      ...lastService,
    }

    const threeMonthsAgo = new Date(Date.now() - 3 * 30 * 86400 * 1000)
    const sixMonthsAgo = new Date(Date.now() - 6 * 30 * 86400 * 1000)
    const twelveMonthsAgo = new Date(Date.now() - 12 * 30 * 86400 * 1000)

    const makeSheep =
      new Date(lastService.lastAttendedServiceDate) >= threeMonthsAgo &&
      !lastService.memberStatus.includes('Sheep')
    const makeGoat =
      new Date(lastService.lastAttendedServiceDate) < threeMonthsAgo &&
      new Date(lastService.lastAttendedServiceDate) > sixMonthsAgo &&
      !lastService.memberStatus.includes('Goat')
    const makeDeer =
      new Date(lastService.lastAttendedServiceDate) < sixMonthsAgo &&
      new Date(lastService.lastAttendedServiceDate) > twelveMonthsAgo &&
      !lastService.memberStatus.includes('Deer')
    const makeLost =
      lastService.lastAttendedServiceDate <
        new Date(Date.now() - 12 * 30 * 86400) &&
      !lastService.memberStatus.includes('Lost')

    if (makeSheep) {
      // Last Attended Date in the last 3 months
      await session.executeWrite((tx) =>
        tx.run(setMemberToSheep, { memberId, auth: context.auth })
      )

      return memberNames
    }

    if (makeGoat) {
      // Last Attended Date in the last 6 months
      await session.executeWrite((tx) =>
        tx.run(setMemberToGoat, { memberId, auth: context.auth })
      )

      return memberNames
    }
    if (makeDeer) {
      // Last Attended Date in the last 12 months
      await session.executeWrite((tx) =>
        tx.run(setMemberToDeer, { memberId, auth: context.auth })
      )

      return memberNames
    }

    if (makeLost) {
      // Last Attended Date in the last 12 months
      await session.executeWrite((tx) =>
        tx.run(setMemberLost, { memberId, auth: context.auth })
      )
      return memberNames
    }

    return memberNames
  } catch (error: unknown) {
    return throwErrorMsg(error)
  } finally {
    await session.close()
  }
}

export type filledLastServiceType = {
  lastService: boolean
  filled: boolean
  lastDate: string
}
export const checkLastServiceIsFilled = (
  filledLastBussing: filledLastServiceType,
  filledLastService: filledLastServiceType
) => {
  const mostRecentRecord =
    new Date(filledLastBussing?.lastDate ?? '2001-01-01') >
    new Date(filledLastService?.lastDate ?? '2001-01-01')
      ? filledLastBussing
      : filledLastService

  const lastDate = mostRecentRecord?.lastDate

  const serviceOrBussing =
    new Date(filledLastBussing?.lastDate ?? '2001-01-01') >
    new Date(filledLastService?.lastDate ?? '2001-01-01')
      ? 'bussing'
      : 'fellowship service'

  const notNew = filledLastBussing && filledLastService

  if (notNew && !mostRecentRecord?.filled && filledLastService) {
    throw new Error(
      `You have a previously unfilled ${serviceOrBussing} on ${getHumanReadableDate(
        lastDate
      )}. You must fill all past services before filling the current one!`
    )
  }
}
