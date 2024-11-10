export const lastFourWeekdayServices = `
    MATCH (this:Member {id: $id})-[attended:ABSENT_FROM_SERVICE|PRESENT_AT_SERVICE]->(service:ServiceRecord)-[:SERVICE_HELD_ON]->(date:TimeGraph)
    WITH DISTINCT this, attended,service, date ORDER BY date.date DESC LIMIT 4

    WITH this, attended, service, date ORDER BY date.date ASC
    UNWIND labels(service) AS serviceType

    WITH service, attended, serviceType, date WHERE serviceType = 'ServiceRecord'
     RETURN collect({
      service: serviceType,
      present: toBoolean(TYPE(attended) = 'PRESENT_AT_SERVICE'),
      date: date.date
    }) as services
`

export const lastFourWeekendServices = `
    MATCH (this:Member {id: $id})-[attended:ABSENT_FROM_SERVICE|PRESENT_AT_SERVICE]->(service:BussingRecord)-[:BUSSED_ON]->(date:TimeGraph)
    WITH DISTINCT this, attended,service, date ORDER BY date.date DESC LIMIT 4
    
    WITH this, attended, service, date ORDER BY date.date ASC
    UNWIND labels(service) AS serviceType
    
    WITH service, attended, serviceType, date WHERE serviceType = 'BussingRecord'
     RETURN collect({
      service: serviceType,
      present: toBoolean(TYPE(attended) = 'PRESENT_AT_SERVICE'),
      date: date.date
    }) as services
`
