export const memberComments = `
MATCH (member:Member {id: $memberId})<-[:COMMENTS_ON]-(comment:PastoralComment)<-[:WROTE]-(author:Member)
WHERE comment.roleLevel IN $roleLevel
RETURN author, comment ORDER BY comment.timestamp DESC LIMIT toInteger($limit)
`
export default memberComments
