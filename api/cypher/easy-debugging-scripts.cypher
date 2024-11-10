MATCH (poimen:PoimenRecord)
DETACH DELETE poimen;

MATCH (poimen:PoimenRecord)
RETURN poimen.id;

MATCH (governorship:Governorship {id: $governorshipId})-[:CURRENT_HISTORY]->(log:ServiceLog)
RETURN governorship.id, log.id;
MERGE (service:PoimenRecord {id: toString($date)+"-"=$governorshipId})
RETURN service.id;