/* eslint-disable no-relative-import-paths/no-relative-import-paths */
/* eslint-disable no-underscore-dangle */
import { Member } from '@jaedag/admin-portal-types'
import { QueryResult } from 'neo4j-driver'
import { ChurchLevel, Role } from './types'

type ErrorCustom = {
  response: {
    data: {
      message: string
    }
    statusText: string
    status: string
  }
}

export const checkIfArrayHasRepeatingValues = (array: any[]) => {
  const sortedArray = array.sort()
  for (let i = 0; i < sortedArray.length - 1; i += 1) {
    if (sortedArray[i + 1] === sortedArray[i]) {
      return true
    }
  }
  return false
}

export const throwErrorMsg = (
  message: string | unknown,
  error?: ErrorCustom | string | any
) => {
  let errorVar: string | ErrorCustom = ''

  if (error) {
    errorVar = error
  }

  if (error?.response?.data?.message) {
    errorVar = error?.response?.data?.message
  }

  if (error?.response?.statusText) {
    errorVar = `${error.response.status} ${error.response.statusText}`
  }

  // eslint-disable-next-line no-console
  console.error(message, errorVar)
  throw new Error(`${message} ${errorVar}`)
}

export const noEmptyArgsValidation = (args: any[]) => {
  if (!args.length) {
    throwErrorMsg('args must be passed in array')
  }

  args.forEach((argument, index) => {
    if (!argument) {
      throwErrorMsg(`${args[index - 1]} Argument Cannot Be Empty`)
    }
  })
}

export const errorHandling = (member: Member) => {
  if (!member.email) {
    throwErrorMsg(
      `${member.firstName} ${member.lastName} does not have a valid email address. Please add an email address and then try again`
    )
  }
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export const rearrangeCypherObject = (response: QueryResult) => {
  const cypherResponse: any[] = []

  response.records.forEach((record, index: number) => {
    const cypherRecord: {
      [key: string]: any
    } = {}
    record?.keys.forEach((key, j) => {
      // eslint-disable-next-line @typescript-eslint/ban-ts-comment
      // @ts-ignore
      cypherRecord[key as string] = response.records[index]._fields[j]
    })

    cypherResponse.push(cypherRecord)
  })

  return cypherResponse
}

export const isAuth = (permittedRoles: Role[], userRoles?: Role[]) => {
  if (!permittedRoles.some((r) => userRoles?.includes(r))) {
    throwErrorMsg('You are not permitted to run this mutation')
  }
}

export const nextHigherChurch = (churchLevel: ChurchLevel) => {
  switch (churchLevel) {
    case 'Fellowship':
      return 'Bacenta'
    case 'Bacenta':
      return 'Governorship'
    case 'Governorship':
      return 'Council'
    case 'Council':
      return 'Stream'
    case 'Stream':
      return 'Campus'
    case 'Campus':
      return 'Oversight'
    default:
      return 'Oversight'
  }
}
