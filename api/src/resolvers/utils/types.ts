export type neonumber = { low: number; high: number }
export type RearragedCypherResponse = {
  record: {
    identity: number
    lables: string[]
    properties: any
  }
}

export type ChurchLevel =
  | 'Fellowship'
  | 'Bacenta'
  | 'Governorship'
  | 'Council'
  | 'Stream'
  | 'Campus'
  | 'Campus'
  | 'Oversight'
  | 'Denomination'
  | 'Sonta'
  | 'Hub'
  | 'Ministry'
  | 'Federalministry'

export type Role =
  | 'leaderFellowship'
  | 'leaderBacenta'
  | 'leaderGovernorship'
  | 'leaderCouncil'
  | 'leaderStream'
  | 'leaderCampus'
  | 'leaderOversight'
  | 'leaderFederalministry'
  | 'leaderMinistry'
  | 'leaderHub'
  | 'leaderSonta'
  | 'adminGovernorship'
  | 'adminCouncil'
  | 'adminStream'
  | 'adminCampus'
  | 'adminOversight'
  | 'adminFederalministry'
  | 'adminMinistry'
  | 'arrivalsAdminCampus'
  | 'arrivalsAdminStream'
  | 'arrivalsAdminCouncil'
  | 'arrivalsAdminGovernorship'
  | 'arrivalsCounterStream'
  | 'arrivalsConfirmerStream'
  | 'arrivalsPayerStream'
  | 'tellerStream'
  | 'sheepseekerStream'
  | 'all'
