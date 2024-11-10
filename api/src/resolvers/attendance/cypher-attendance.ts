export const checkIfFilled = `
MATCH (record {id: $recordId}) WHERE record:ServiceRecord OR record:BussingRecord
 MATCH (record)<-[:PRESENT_AT_SERVICE]-(member:Member)-[:BELONGS_TO]->(bacenta:Bacenta {id: $bacentaId})
 RETURN COUNT(member) > 0 AS markedAttendance
`

export const checkIfRecordExistsForDate = `
MATCH (governorship:Governorship {id: $governorshipId})-[:CURRENT_HISTORY]->(:ServiceLog)-[:HAS_SERVICE]->(record:PoimenRecord)-[:SERVICE_HELD_ON]->(date:TimeGraph {date: date($date)})
RETURN COUNT(record) > 0 AS recordExists
`

export const getLastButOneServiceRecord = `
MATCH (record {id: $recordId})-[:SERVICE_HELD_ON|BUSSED_ON]->(date:TimeGraph) WHERE record:ServiceRecord OR record:BussingRecord
MATCH (church:Bacenta {id: $bacentaId})-[:HAS_HISTORY]->(:ServiceLog)-[:HAS_SERVICE]->(otherServiceRecords:ServiceRecord)-[:SERVICE_HELD_ON]->(otherDate:TimeGraph)
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
MATCH (lastService:ServiceRecord {id: recordIds[lastServiceIndex]})-[:SERVICE_HELD_ON]->(lastDate:TimeGraph)
OPTIONAL MATCH (lastService)<-[:PRESENT_AT_SERVICE|ABSENT_FROM_SERVICE]-(member:Member)-[:BELONGS_TO]->(:Bacenta {id: $bacentaId})

RETURN COUNT(lastService) > 0 AS lastService, COUNT(member) > 0 AS filled, lastDate.date AS lastDate 
`

export const getLastButOneBussingRecord = `
MATCH (record {id: $recordId})-[:SERVICE_HELD_ON|BUSSED_ON]->(date:TimeGraph) WHERE record:ServiceRecord OR record:BussingRecord
MATCH (church:Bacenta {id: $bacentaId})
MATCH (church)-[:HAS_HISTORY]->(:ServiceLog)-[:HAS_BUSSING]->(otherRecords:BussingRecord)-[:BUSSED_ON]->(otherDate:TimeGraph)
WHERE NOT (otherRecords:NoService) AND duration.between(otherDate.date, date.date).weeks < 52 AND otherDate.date < date.date

WITH DISTINCT record, otherRecords
ORDER BY otherRecords.createdAt DESC LIMIT 3

WITH collect(record) + collect(otherRecords) AS combinedArray, record
UNWIND combinedArray AS combinedRecord
WITH DISTINCT combinedRecord, record
ORDER BY combinedRecord.createdAt DESC LIMIT 3

WITH collect(DISTINCT combinedRecord.id) AS recordIds, record.id AS currentServiceId

WITH apoc.coll.indexOf(recordIds,currentServiceId) + 1 AS lastServiceIndex, recordIds WHERE lastServiceIndex >= 0
MATCH (lastService:BussingRecord {id: recordIds[lastServiceIndex]})-[:BUSSED_ON]->(lastDate:TimeGraph)

OPTIONAL MATCH (lastService)<-[:PRESENT_AT_SERVICE|ABSENT_FROM_SERVICE]-(member:Member)-[:BELONGS_TO]->(:Bacenta {id: $bacentaId})
RETURN COUNT(lastService) > 0 AS lastService, COUNT(member) > 0 AS filled, lastDate.date AS lastDate
`

export const checkIfFilledAbsent = `
MATCH (record {id: $recordId}) WHERE record:ServiceRecord OR record:BussingRecord
MATCH (record)<-[:ABSENT_FROM_SERVICE]-(member:Member)
RETURN COUNT(member) > 0 AS markedAttendance
`

export const recordMembersPresentOnDate = `
MERGE (date:TimeGraph {date: date($date)})
MERGE (service:PoimenRecord {id: $date+"-"+$governorshipId})
WITH date, service

MATCH (governorship:Governorship {id: $governorshipId})-[:CURRENT_HISTORY]->(log:ServiceLog)
MERGE (log)-[:HAS_SERVICE]->(service)
MERGE (service)-[:SERVICE_HELD_ON]->(date)

WITH service, date
UNWIND $presentMembers AS presentMemberId
MATCH (present:Member {id: presentMemberId})
REMOVE present:IMCL
REMOVE present.imclChecked
SET service.markedAttendance = true,
present.lastAttendedServiceDate = date.date
MERGE (present)-[:PRESENT_AT_SERVICE]->(service)

RETURN service, collect(present) AS membersPresent
`

export const recordMembersAbsentOnDate = `
MERGE (date:TimeGraph {date: date($date)})
MERGE (service:PoimenRecord {id: $date+"-"+$governorshipId})
WITH date, service

MATCH (governorship:Governorship {id: $governorshipId})-[:CURRENT_HISTORY]->(log:ServiceLog)
MERGE (log)-[:HAS_SERVICE]->(service)
MERGE (service)-[:SERVICE_HELD_ON]->(date)

WITH service, date
UNWIND $absentMembers AS absentMemberId
MATCH (absent:Member {id: absentMemberId})
SET absent:IMCL,
absent.imclChecked = false,
absent.lastMissedServiceDate = date.date,
service.markedAttendance = true
MERGE (absent)-[:ABSENT_FROM_SERVICE]->(service)

RETURN service, collect(absent) AS membersAbsent
`

export const recordMembersPresentAtService = `
MATCH (service {id: $recordId})-[:SERVICE_HELD_ON|BUSSED_ON]->(date:TimeGraph)
WHERE service:ServiceRecord OR service:BussingRecord

WITH service, date
UNWIND $presentMembers AS presentMemberId
MATCH (present:Member {id: presentMemberId})
REMOVE present:IMCL
REMOVE present.imclChecked
SET service.markedAttendance = true,
present.lastAttendedServiceDate = date.date
MERGE (present)-[:PRESENT_AT_SERVICE]->(service)

RETURN service, collect(present) AS membersPresent
`

export const recordMembersAbsentAtService = `
MATCH (service {id: $recordId})-[:SERVICE_HELD_ON|BUSSED_ON]->(date:TimeGraph)
WHERE service:ServiceRecord OR service:BussingRecord

WITH service, date
UNWIND $absentMembers AS absentMemberId
MATCH (absent:Member {id: absentMemberId})
SET absent:IMCL,
absent.imclChecked = false,
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
