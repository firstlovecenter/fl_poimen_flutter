export const checkIfFilled = `
 MATCH (record:RehearsalRecord {id: $recordId})
 MATCH (hub:Hub {id: $hubId})
 MATCH (hub)<-[:HAS_MINISTRY]-(governorship:Governorship)-[:HAS*2]->(fellowship:Fellowship)
 MATCH (hub)<-[:HAS*2]-(creativearts:CreativeArts)
 MATCH (record)<-[:PRESENT_AT_SERVICE]-(member:Member)-[:BELONGS_TO]->(fellowship)
 MATCH (member)-[:BELONGS_TO]->(creativearts)
 RETURN COUNT(member) > 0 AS markedAttendance
`

export const getLastButOneRehearsalRecord = `
MATCH (record {id: $recordId})-[:SERVICE_HELD_ON]->(date:TimeGraph) WHERE record:RehearsalRecord
MATCH (church:Hub {id: $hubId})-[:HAS_HISTORY]->(:ServiceLog)-[:HAS_SERVICE]->(otherServiceRecords:RehearsalRecord)-[:SERVICE_HELD_ON]->(otherDate:TimeGraph)
WHERE NOT (otherServiceRecords:NoService) AND duration.between(otherDate.date, date.date).weeks < 52 AND otherDate.date < date.date 

WITH record, collect(otherServiceRecords) AS otherServiceRecords
UNWIND otherServiceRecords AS otherRecords

WITH DISTINCT record, otherRecords
ORDER BY otherRecords.createdAt DESC LIMIT 3

WITH collect(record) + collect(otherRecords) AS combinedArray, record
UNWIND combinedArray AS combinedRecord
WITH DISTINCT combinedRecord, record
ORDER BY combinedRecord.createdAt DESC LIMIT 3

WITH collect(DISTINCT combinedRecord.id) AS recordIds, record.id AS currentServiceId

WITH apoc.coll.indexOf(recordIds,currentServiceId) + 1 AS lastServiceIndex, recordIds WHERE lastServiceIndex >= 0
MATCH (lastService:RehearsalRecord {id: recordIds[lastServiceIndex]})-[:SERVICE_HELD_ON]->(lastDate:TimeGraph)
OPTIONAL MATCH (lastService)<-[:PRESENT_AT_SERVICE|ABSENT_FROM_SERVICE]-(member:Member)-[:BELONGS_TO]->(:Hub {id: $hubId})

RETURN COUNT(lastService) > 0 AS lastService, COUNT(member) > 0 AS filled, lastDate.date AS lastDate 
`

export const checkIfFilledAbsent = `
MATCH (record {id: $recordId}) WHERE record:ServiceRecord OR record:BussingRecord
MATCH (record)<-[:ABSENT_FROM_SERVICE]-(member:Member)
RETURN COUNT(member) > 0 AS markedAttendance
`

export const recordMembersPresentAtService = `
MATCH (service:RehearsalRecord {id: $recordId})-[:SERVICE_HELD_ON]->(date:TimeGraph)

WITH service, date
UNWIND $presentMembers AS presentMemberId
MATCH (present:Member {id: presentMemberId})
REMOVE present.rehearsalIMCLChecked
SET service.markedAttendance = true,
present.lastAttendedServiceDate = date.date
MERGE (present)-[:PRESENT_AT_SERVICE]->(service)

RETURN service, collect(present) AS membersPresent
`

export const recordMembersAbsentAtService = `
MATCH (service:RehearsalRecord {id: $recordId})-[:SERVICE_HELD_ON]->(date:TimeGraph)

WITH service, date
UNWIND $absentMembers AS absentMemberId
MATCH (absent:Member {id: absentMemberId})
SET absent.rehearsalIMCLChecked = false,
absent.lastMissedServiceDate = date.date,
service.markedAttendance = true
MERGE (absent)-[:ABSENT_FROM_SERVICE]->(service)

RETURN service, collect(absent) AS membersAbsent
`

// Setting Member Status
export const getMembersLastService = `
 MATCH (member:Member {id: $memberId})
 WITH DISTINCT member
 
 RETURN member.id AS memberId, 
    member.firstName AS firstName, 
    member.lastName AS lastName, 
    labels(member) AS memberStatus, 
    member.lastMissedServiceDate AS lastMissedServiceDate, 
    member.lastAttendedServiceDate AS lastAttendedServiceDate 
 `
