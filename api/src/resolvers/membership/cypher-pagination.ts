export const paginateCampusSheep = `
MATCH (this:Campus {id: $id})
 CALL {
   WITH this
   WITH this
    MATCH (this)-[:HAS]->(stream:Stream)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Sheep) 
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
 }

 RETURN membersConnection
`

export const paginateCampusGoats = `
MATCH (this:Campus {id: $id})
 CALL {
   WITH this
   WITH this
    MATCH (this)-[:HAS]->(stream:Stream)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Goat) 
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
 }

 RETURN membersConnection
`

export const paginateCampusDeer = `
MATCH (this:Campus {id: $id})
 CALL {
   WITH this
   WITH this
    MATCH (this)-[:HAS]->(stream:Stream)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Deer) 
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
 }

 RETURN membersConnection
`

export const paginateCampusIDLs = `
MATCH (this:Campus {id: $id})
 CALL {
   WITH this
   WITH this
    MATCH (this)-[:HAS]->(stream:Stream)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:IDL) 
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
 }

 RETURN membersConnection
`

export const paginateStreamSheep = `
MATCH (this:Stream {id: $id})
 CALL {
   WITH this
   WITH this
    MATCH (this)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Sheep)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }
    
    RETURN membersConnection
    `

export const paginateStreamGoats = `
MATCH (this:Stream {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Goat)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
    `

export const paginateStreamDeer = `
MATCH (this:Stream {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Deer)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
    `

export const paginateStreamIDLs = `
MATCH (this:Stream {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(council:Council)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:IDL)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
    `

export const paginateCouncilSheep = `
MATCH (this:Council {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Sheep)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateCouncilGoats = `
MATCH (this:Council {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Goat)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateCouncilDeer = `
MATCH (this:Council {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Deer)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateCouncilIDLs = `
MATCH (this:Council {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(governorship:Governorship)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:IDL)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateGovernorshipSheep = `
MATCH (this:Governorship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Sheep)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateGovernorshipGoats = `
MATCH (this:Governorship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Goat)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateGovernorshipDeer = `
MATCH (this:Governorship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:Deer)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateGovernorshipIDLs = `
MATCH (this:Governorship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)-[:HAS]->(bacenta:Bacenta)<-[:BELONGS_TO]-(member:Active:IDL)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateBacentaSheep = `
MATCH (this:Bacenta {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:Sheep)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateBacentaGoats = `
MATCH (this:Bacenta {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:Goat)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateBacentaDeer = `
MATCH (this:Bacenta {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:Deer)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateBacentaIDLs = `
MATCH (this:Bacenta {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:IDL)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateFellowshipSheep = `
MATCH (this:Fellowship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:Sheep)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateFellowshipGoats = `
MATCH (this:Fellowship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:Goat)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateFellowshipDeer = `
MATCH (this:Fellowship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:Deer)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateFellowshipIDLs = `
MATCH (this:Fellowship {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:BELONGS_TO]-(member:Active:IDL)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateHubSheep = `
MATCH (this:Hub {id: $id})
CALL {
  WITH this
  WITH this
  MATCH (this)<-[:HAS]-(:HubCouncil)<-[:HAS]-(:Ministry)<-[:HAS]-(creativearts:CreativeArts)
  MATCH (this)<-[:HAS_MINISTRY]-(governorship:Governorship)-[:HAS*2]->(fellowship:Fellowship)
    MATCH (creativearts)<-[:BELONGS_TO]-(member:Active:Sheep)-[:BELONGS_TO]->(fellowship)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)

    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber, whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
    RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateHubGoats = `
MATCH (this:Hub {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:HAS]-(:HubCouncil)<-[:HAS]-(:Ministry)<-[:HAS]-(creativearts:CreativeArts)
    MATCH (this)<-[:HAS_MINISTRY]-(governorship:Governorship)-[:HAS*2]->(fellowship:Fellowship)
    MATCH (creativearts)<-[:BELONGS_TO]-(member:Active:Goat)-[:BELONGS_TO]->(fellowship)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber,  whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
     RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateHubDeer = `
MATCH (this:Hub {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:HAS]-(:HubCouncil)<-[:HAS]-(:Ministry)<-[:HAS]-(creativearts:CreativeArts)
    MATCH (this)<-[:HAS_MINISTRY]-(governorship:Governorship)-[:HAS*2]->(fellowship:Fellowship)
    MATCH (creativearts)<-[:BELONGS_TO]-(member:Active:Deer)-[:BELONGS_TO]->(fellowship)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber,  whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
     RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`

export const paginateHubIDLs = `
MATCH (this:Hub {id: $id})
  CALL {
    WITH this
    WITH this
    MATCH (this)<-[:HAS]-(:HubCouncil)<-[:HAS]-(:Ministry)<-[:HAS]-(creativearts:CreativeArts)
    MATCH (this)<-[:HAS_MINISTRY]-(governorship:Governorship)-[:HAS*2]->(fellowship:Fellowship)
    MATCH (creativearts)<-[:BELONGS_TO]-(member:Active:IDL)-[:BELONGS_TO]->(fellowship)
    WITH member AS member ORDER BY toLower(member.lastName)
    WITH member SKIP toInteger($after)
    WITH COUNT(member) AS totalCount,  collect(member) AS memberList LIMIT toInteger($first)
    
    UNWIND memberList AS member
    WITH totalCount, collect({ node: { id: member.id, firstName: member.firstName, lastName: member.lastName, pictureUrl: member.pictureUrl, phoneNumber: member.phoneNumber,  whatsappNumber: member.whatsappNumber, lost: member.lost} }) AS edges
    WITH totalCount, edges[..$first] AS limitedSelection
     RETURN { edges: limitedSelection, totalCount: totalCount, position: $after + $first } AS membersConnection
    }

    RETURN membersConnection
`
