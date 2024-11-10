import { Session } from 'neo4j-driver'
import { Role } from './types'

export type Context = {
  auth: {
    roles: Role[]
    jwt: { sub: string; 'https://flcadmin.netlify.app/roles': Role[] }
  }
  executionContext: { session: () => Session }
}
