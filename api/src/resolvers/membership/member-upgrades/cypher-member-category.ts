export const setMemberToGoat = `
    CREATE (comment:PastoralComment {id: randomUUID()})
        SET comment.timestamp = datetime(),
        comment.comment = "Member status has been changed to Goat",
        comment.activity = "Member Status Update",
        comment.roleLevel = 'Fellowship'
    
    WITH comment
    MATCH (member:Member {id: $memberId})
    SET member:Goat
    REMOVE member:Deer, member:Sheep, member:Lost, member:Lost, member.lost

    WITH member, comment
    MATCH (author:Member {auth_id: $auth.jwt.sub})
    MERGE (date:TimeGraph {date: date()})
    MERGE (comment)-[:COMMENTS_ON]->(member)
    MERGE (comment)-[:WRITTEN_ON]->(date)
    MERGE (author)-[:WROTE]->(comment)
        
    RETURN member
    `
export const setMemberToSheep = `
    CREATE (comment:PastoralComment {id: randomUUID()})
        SET comment.timestamp = datetime(),
        comment.comment = "Member status has been changed to Sheep",
        comment.activity = "Member Status Update",
        comment.roleLevel = 'Fellowship'

    WITH comment
    MATCH (member:Member {id: $memberId})
    SET member:Sheep
    REMOVE member:Deer, member:Goat, member:Lost, member.lost

    WITH member, comment
    MATCH (author:Member {auth_id: $auth.jwt.sub})
    MERGE (date:TimeGraph {date: date()})
    MERGE (comment)-[:COMMENTS_ON]->(member)
    MERGE (comment)-[:WRITTEN_ON]->(date)
    MERGE (author)-[:WROTE]->(comment)
        
    RETURN member
    `

export const setMemberToDeer = `
    CREATE (comment:PastoralComment {id: randomUUID()})
        SET comment.timestamp = datetime(),
        comment.comment = "Member status has been changed to Deer",
        comment.activity = "Member Status Update",
        comment.roleLevel = 'Fellowship'
    
    WITH comment
    MATCH (member:Member {id: $memberId})
    SET member:Deer
    REMOVE member:Sheep, member:Goat, member:Lost, member.lost

    WITH member, comment
    MATCH (author:Member {auth_id: $auth.jwt.sub})
    MERGE (date:TimeGraph {date: date()})
    MERGE (comment)-[:COMMENTS_ON]->(member)
    MERGE (comment)-[:WRITTEN_ON]->(date)
    MERGE (author)-[:WROTE]->(comment)
        
    RETURN member
    `

export const setMemberLost = `
    CREATE (comment:PastoralComment {id: randomUUID()})
        SET comment.timestamp = datetime(),
        comment.comment = "Member status has been changed to Lost",
        comment.activity = "Member Status Update",
        comment.roleLevel = 'Fellowship'
    
    WITH comment
    MATCH (member:Member {id: $memberId})
    SET member:Lost,
    member.lost = true
    REMOVE member:IMCL
    REMOVE member.imclChecked

    WITH member, comment
    MATCH (author:Member {auth_id: $auth.jwt.sub})
    MERGE (date:TimeGraph {date: date()})
    MERGE (comment)-[:COMMENTS_ON]->(member)
    MERGE (comment)-[:WRITTEN_ON]->(date)
    MERGE (author)-[:WROTE]->(comment)
    
    RETURN member
    `
