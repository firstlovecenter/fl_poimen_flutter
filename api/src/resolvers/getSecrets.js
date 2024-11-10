// eslint-disable-next-line @typescript-eslint/no-var-requires
const { loadSecrets } = require('./secrets')

const SECRETS = loadSecrets()?.JWT_SECRET ? loadSecrets() : process.env
export default SECRETS
