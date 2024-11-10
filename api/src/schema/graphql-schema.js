// eslint-disable-next-line @typescript-eslint/no-var-requires
const fs = require('fs')
// eslint-disable-next-line @typescript-eslint/no-var-requires
const path = require('path')

/*
 * Check for GRAPHQL_SCHEMA environment variable to specify schema file
 * fallback to schema.graphql if GRAPHQL_SCHEMA environment variable is not set
 */

const schema = fs
  .readFileSync(path.join(__dirname, 'schema.graphql'))
  .toString('utf-8')

const directoryHistory = fs
  .readFileSync(path.join(__dirname, 'directory-history.graphql'))
  .toString('utf-8')

const directory = fs
  .readFileSync(path.join(__dirname, 'directory.graphql'))
  .toString('utf-8')

const directoryCreativeArts = fs
  .readFileSync(path.join(__dirname, 'directory-creativearts.graphql'))
  .toString('utf-8')

const search = fs
  .readFileSync(path.join(__dirname, 'search.graphql'))
  .toString('utf-8')

const attendance = fs
  .readFileSync(path.join(__dirname, 'attendance.graphql'))
  .toString('utf-8')
const attendanceDefaulters = fs.readFileSync(
  path.join(__dirname, 'attendance-defaulters.graphql')
)
const attendanceImcl = fs.readFileSync(
  path.join(__dirname, 'attendance-imcl.graphql')
)

const membership = fs
  .readFileSync(path.join(__dirname, 'directory-membership.graphql'))
  .toString('utf-8')
const membershipUpgrades = fs
  .readFileSync(path.join(__dirname, 'directory-membership-upgrades.graphql'))
  .toString('utf-8')

const services = fs
  .readFileSync(path.join(__dirname, 'services.graphql'))
  .toString('utf-8')

const dutiesPastoralCycle = fs
  .readFileSync(path.join(__dirname, 'duties-pastoral-cycle.graphql'))
  .toString('utf-8')

const dutiesOutstanding = fs
  .readFileSync(path.join(__dirname, 'duties-outstanding.graphql'))
  .toString('utf-8')

const dutiesRecording = fs
  .readFileSync(path.join(__dirname, 'duties-recording.graphql'))
  .toString('utf-8')

const array = [
  schema,
  directory,
  directoryHistory,
  directoryCreativeArts,
  search,
  attendance,
  attendanceDefaulters,
  attendanceImcl,
  membership,
  membershipUpgrades,
  services,
  dutiesPastoralCycle,
  dutiesOutstanding,
  dutiesRecording,
]

exports.typeDefs = array.join(' ')
