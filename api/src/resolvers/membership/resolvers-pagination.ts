import { Context } from '../utils/neo4j-types'
import { rearrangeCypherObject, throwErrorMsg } from '../utils/utils'
import {
  paginateBacentaDeer,
  paginateBacentaGoats,
  paginateBacentaIDLs,
  paginateBacentaSheep,
  paginateGovernorshipDeer,
  paginateGovernorshipGoats,
  paginateGovernorshipIDLs,
  paginateGovernorshipSheep,
  paginateCouncilDeer,
  paginateCouncilGoats,
  paginateCouncilIDLs,
  paginateCouncilSheep,
  paginateCampusDeer,
  paginateCampusGoats,
  paginateCampusIDLs,
  paginateCampusSheep,
  paginateStreamDeer,
  paginateStreamGoats,
  paginateStreamIDLs,
  paginateStreamSheep,
  paginateHubSheep,
  paginateHubGoats,
  paginateHubDeer,
  paginateHubIDLs,
} from './cypher-pagination'

const paginationResolvers = {
  Campus: {
    sheepPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCampusSheep, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching sheep', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    goatsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCampusGoats, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching goats', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    deerPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCampusDeer, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching deer', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    idlsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCampusIDLs, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching idls', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
  },
  Stream: {
    sheepPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateStreamSheep, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching sheep', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    goatsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateStreamGoats, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching goats', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    deerPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateStreamDeer, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching deer', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    idlsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateStreamIDLs, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching idls', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
  },
  Council: {
    sheepPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCouncilSheep, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching sheep', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    goatsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCouncilGoats, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching goats', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    deerPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCouncilDeer, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching deer', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    idlsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateCouncilIDLs, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching idls', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
  },
  Governorship: {
    sheepPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateGovernorshipSheep, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching sheep', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    goatsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateGovernorshipGoats, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching goats', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    deerPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateGovernorshipDeer, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching deer', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    idlsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateGovernorshipIDLs, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching idls', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
  },
  Bacenta: {
    sheepPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateBacentaSheep, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching sheep', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    goatsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateBacentaGoats, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching goats', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    deerPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateBacentaDeer, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching deer', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
    idlsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateBacentaIDLs, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching idls', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            edges: [],
            totalCount: 0,
            position: 0,
          }
    },
  },

  Hub: {
    sheepPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateHubSheep, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching sheep', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            totalCount: 0,
            edges: [],
            position: 0,
          }
    },
    goatsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateHubGoats, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching goats', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            totalCount: 0,
            edges: [],
            position: 0,
          }
    },
    deerPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateHubDeer, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching deer', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            totalCount: 0,
            edges: [],
            position: 0,
          }
    },
    idlsPaginated: async (
      object: { id: string },
      args: { first: number; position: number },
      context: Context
    ) => {
      const session = context.executionContext.session()

      const cypherResponse = rearrangeCypherObject(
        await session
          .executeRead((tx) =>
            tx.run(paginateHubIDLs, { id: object.id, ...args })
          )
          .catch((error: any) =>
            throwErrorMsg('There was an error fetching idls', error)
          )
      )

      return cypherResponse.length
        ? cypherResponse[0].membersConnection
        : {
            totalCount: 0,
            edges: [],
            position: 0,
          }
    },
  },
  HubCouncil: {},
}

export default paginationResolvers
