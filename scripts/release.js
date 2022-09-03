/* eslint-disable @typescript-eslint/no-var-requires */
// eslint-disable-next-line import/no-extraneous-dependencies
const concurrently = require('concurrently')
const { concurrentOpts  } = require('./common')

const release = []

switch (process.argv[2]) {
  case 'patch':
    release.push({
      name: 'release:patch',
      command:
        "changelog -p && git add CHANGELOG.md && git commit -m 'docs: update CHANGELOG.md' && npm version patch && git push origin && git push origin --tags",
      prefixColor: 'yellow',
    })
    break
  case 'minor':
      release.push({
      name: 'release:minor',
      command:
        "changelog -m && git add CHANGELOG.md && git commit -m 'docs: update CHANGELOG.md' && npm version minor && git push origin && git push origin --tags",
      prefixColor: 'yellow',
    })
    break
  case 'major':
    release.push({
      name: 'release:major',
      command:
        "changelog -M && git add CHANGELOG.md && git commit -m 'docs: update CHANGELOG.md' && npm version major && git push origin && git push origin --tags",
      prefixColor: 'yellow',
    })
    break
  default:
    break
}


concurrently(release, concurrentOpts)
