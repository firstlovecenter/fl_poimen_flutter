export const logPrayerActivity = `
    CREATE (prayer:PrayerActivity {id: randomUUID()})
    CREATE (commentNode:PastoralComment {id: randomUUID()})

    WITH prayer, commentNode AS comment
        SET prayer.datetime = datetime(),
        comment.comment = $comment,
        comment.timestamp = datetime(),
        comment.activity = 'Prayer',
        comment.roleLevel = $roleLevel

    WITH prayer, comment
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(church)<-[:HAS*0..5]-(higherChurch)-[:CURRENT_HISTORY]->(log:ServiceLog)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:LEADS]->(higherChurch)
    MATCH (author)-[:CURRENT_HISTORY]->(log)
    WITH DISTINCT prayer, comment, member, author, higherChurch, log
    MATCH (cycle:PastoralCycle {id: $cycleId})

    MERGE (date:TimeGraph {date: date()})
    MERGE (comment)-[:WRITTEN_ON]->(date)
    MERGE (comment)-[:COMMENTS_ON]->(member)
    MERGE (author)-[:WROTE]->(comment)

    MERGE (prayer)-[:LEAVES_COMMENT]->(comment)
    MERGE (prayer)<-[:PERFORMED_DUTY]-(log)
    MERGE (prayer)-[:TOWARDS]->(member)
    MERGE (prayer)-[:DURING_CYCLE]->(cycle)

    RETURN prayer
`

export const alreadyLoggedPrayerForMember = `
    MATCH (member:Member {id: $memberId})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)
    MATCH (cycle:PastoralCycle {id: $cycleId})

    MATCH (member)<-[:TOWARDS]-(prayer:PrayerActivity)<-[:PERFORMED_DUTY]-(log)
    MATCH (cycle)<-[:DURING_CYCLE]-(prayer:PrayerActivity)

    RETURN prayer
`

export const getMemberBacentaPrayerLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(bacenta:Bacenta)
    MATCH (cycle:BacentaCycle {month: date().month, year: date().year})

    WITH bacenta, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(prayer:PrayerActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(prayer)-[:TOWARDS]->(member)

    WITH DISTINCT member, bacenta 

    WITH COUNT(member) as completedPrayersCount, bacenta 

    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:BacentaCycle {month: date().month, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(bacenta)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(prayer:PrayerActivity)
        WHERE (prayer)-[:TOWARDS]->(member) AND (prayer)-[:DURING_CYCLE]->(cycle)
    }

    WITH DISTINCT member, labels(member) AS labels, bacenta, completedPrayersCount, author WHERE member <> author

    WITH collect(member) as outstandingPrayer, bacenta, completedPrayersCount

    RETURN bacenta, completedPrayersCount, outstandingPrayer
`

export const getMemberGovernorshipPrayerLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(:Bacenta)<-[:HAS]-(governorship:Governorship)
    MATCH (governorship)-[:HAS]->(bacenta:Bacenta)
    MATCH (cycle:GovernorshipCycle {quarter: date().quarter, year: date().year})

    WITH bacenta, governorship, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(prayer:PrayerActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(prayer)-[:TOWARDS]->(member)

    WITH DISTINCT member, governorship

    WITH COUNT(member) as completedPrayersCount, governorship

    MATCH (governorship)-[:HAS]->(bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:GovernorshipCycle {quarter: date().quarter, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(governorship)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(prayer:PrayerActivity)
        WHERE (prayer)-[:TOWARDS]->(member) AND (prayer)-[:DURING_CYCLE]->(cycle)
    }

    OPTIONAL MATCH (author)-[:LEADS]->(lowerChurch)-[:HAS*0..1]->(:Bacenta)<-[:BELONGS_TO]-(alreadyMember:Member)
    WHERE lowerChurch:Bacenta 
    WITH governorship, completedPrayersCount, member, author, collect(DISTINCT alreadyMember) AS alreadyMembers WHERE NOT member IN alreadyMembers

    WITH DISTINCT member, labels(member) AS labels, governorship, completedPrayersCount, author WHERE member <> author

    WITH collect(member) as outstandingPrayer, governorship, completedPrayersCount

    RETURN governorship, completedPrayersCount, outstandingPrayer
`

export const getMemberCouncilPrayerLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(:Bacenta)<-[:HAS*2]-(council:Council)
    MATCH (council)-[:HAS*2]->(bacenta:Bacenta)
    MATCH (cycle:CouncilCycle {half: toInteger(ceil(toFloat(date().month)/toFloat(6))) - 1, year: date().year})

    WITH bacenta, council, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(prayer:PrayerActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(prayer)-[:TOWARDS]->(member)

    WITH DISTINCT member, council

    WITH COUNT(member) as completedPrayersCount, council

    MATCH (council)-[:HAS*2]->(bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:CouncilCycle {half: toInteger(ceil(toFloat(date().month)/toFloat(6))) - 1, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(council)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(prayer:PrayerActivity)
        WHERE (prayer)-[:TOWARDS]->(member) AND (prayer)-[:DURING_CYCLE]->(cycle)
    }

    OPTIONAL MATCH (author)-[:LEADS]->(lowerChurch)-[:HAS*0..1]->(:Bacenta)<-[:BELONGS_TO]-(alreadyMember:Member)
    WHERE lowerChurch:Governorship OR lowerChurch:Bacenta 
    WITH council, completedPrayersCount, member, author, collect(DISTINCT alreadyMember) AS alreadyMembers WHERE NOT member IN alreadyMembers

    WITH DISTINCT member, labels(member) AS labels, council, completedPrayersCount, author WHERE member <> author

    WITH collect(member) as outstandingPrayer, council, completedPrayersCount

    RETURN council, completedPrayersCount, outstandingPrayer
`

export const logTelepastoringActivity = `
    CREATE (telepastoring:TelepastoringActivity {id: randomUUID()})
    CREATE (commentNode:PastoralComment {id: randomUUID()})

    WITH telepastoring, commentNode AS comment
        SET telepastoring.datetime = datetime(),
        comment.comment = $comment,
        comment.timestamp = datetime(),
        comment.activity = 'Telepastoring',
        comment.roleLevel = $roleLevel

    WITH telepastoring, comment
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(church)<-[:HAS*0..5]-(higherChurch)-[:CURRENT_HISTORY]->(log:ServiceLog)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:LEADS]->(higherChurch)
    MATCH (author)-[:CURRENT_HISTORY]->(log)
    WITH DISTINCT telepastoring, comment, member, author, higherChurch, log
    MATCH (cycle:PastoralCycle {id: $cycleId})

    MERGE (date:TimeGraph {date: date()})
    MERGE (comment)-[:WRITTEN_ON]->(date)
    MERGE (comment)-[:COMMENTS_ON]->(member)
    MERGE (author)-[:WROTE]->(comment)

    MERGE (telepastoring)-[:LEAVES_COMMENT]->(comment)
    MERGE (telepastoring)<-[:PERFORMED_DUTY]-(log)
    MERGE (telepastoring)-[:TOWARDS]->(member)
    MERGE (telepastoring)-[:DURING_CYCLE]->(cycle)

    RETURN telepastoring
`

export const alreadyLoggedTelepastoringForMember = `
    MATCH (member:Member {id: $memberId})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)
    MATCH (cycle:PastoralCycle {id: $cycleId})

    MATCH (member)<-[:TOWARDS]-(telepastoring:TelepastoringActivity)<-[:PERFORMED_DUTY]-(log)
    MATCH (cycle)<-[:DURING_CYCLE]-(telepastoring:TelepastoringActivity)

    RETURN telepastoring
`

export const getMemberBacentaTelepastoringLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(bacenta:Bacenta)
    MATCH (cycle:BacentaCycle {month: date().month, year: date().year})

    WITH bacenta, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(telepastoring:TelepastoringActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(telepastoring)-[:TOWARDS]->(member)
    WITH DISTINCT member, bacenta 

    WITH COUNT(member) as completedTelepastoringCount, bacenta 

    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:BacentaCycle {month: date().month, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(bacenta)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(telepastoring:TelepastoringActivity)
        WHERE (telepastoring)-[:TOWARDS]->(member) AND (telepastoring)-[:DURING_CYCLE]->(cycle)
    }

    WITH DISTINCT member, labels(member) AS labels, bacenta, completedTelepastoringCount, author WHERE member <> author

    WITH collect(member) as outstandingTelepastoring, bacenta, completedTelepastoringCount

    RETURN bacenta, completedTelepastoringCount, outstandingTelepastoring
`

export const getMemberGovernorshipTelepastoringLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(:Bacenta)<-[:HAS]-(governorship:Governorship)
    MATCH (governorship)-[:HAS]->(bacenta:Bacenta)
    MATCH (cycle:GovernorshipCycle {quarter: date().quarter, year: date().year})

    WITH bacenta, governorship, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(telepastoring:TelepastoringActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(telepastoring)-[:TOWARDS]->(member)

    WITH DISTINCT member, governorship

    WITH COUNT(member) as completedTelepastoringCount, governorship

    MATCH (governorship)-[:HAS]->(bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:GovernorshipCycle {quarter: date().quarter, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(governorship)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(telepastoring:TelepastoringActivity)
        WHERE (telepastoring)-[:TOWARDS]->(member) AND (telepastoring)-[:DURING_CYCLE]->(cycle)
    }

    OPTIONAL MATCH (author)-[:LEADS]->(lowerChurch)-[:HAS*0..1]->(:Bacenta)<-[:BELONGS_TO]-(alreadyMember:Member)
    WHERE lowerChurch:Bacenta 
    WITH governorship, completedTelepastoringCount, member, author, collect(DISTINCT alreadyMember) AS alreadyMembers WHERE NOT member IN alreadyMembers

    WITH DISTINCT member, labels(member) AS labels, governorship, completedTelepastoringCount, author WHERE member <> author

    WITH collect(member) as outstandingTelepastoring, governorship, completedTelepastoringCount

    RETURN governorship, completedTelepastoringCount, outstandingTelepastoring
`

export const getMemberCouncilTelepastoringLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(:Bacenta)<-[:HAS*2]-(council:Council)
    MATCH (council)-[:HAS*2]->(bacenta:Bacenta)
    MATCH (cycle:CouncilCycle {half: toInteger(ceil(toFloat(date().month)/toFloat(6))) - 1, year: date().year})

    WITH bacenta, council, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(telepastoring:TelepastoringActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(telepastoring)-[:TOWARDS]->(member)

    WITH DISTINCT member, council

    WITH COUNT(member) as completedTelepastoringCount, council

    MATCH (council)-[:HAS*2]->(bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:CouncilCycle {half: toInteger(ceil(toFloat(date().month)/toFloat(6))) - 1, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(council)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(telepastoring:TelepastoringActivity)
        WHERE (telepastoring)-[:TOWARDS]->(member) AND (telepastoring)-[:DURING_CYCLE]->(cycle)
    }

    OPTIONAL MATCH (author)-[:LEADS]->(lowerChurch)-[:HAS*0..1]->(:Bacenta)<-[:BELONGS_TO]-(alreadyMember:Member)
    WHERE lowerChurch:Governorship OR lowerChurch:Bacenta 
    WITH council, completedTelepastoringCount, member, author, collect(DISTINCT alreadyMember) AS alreadyMembers WHERE NOT member IN alreadyMembers

    WITH DISTINCT member, labels(member) AS labels, council, completedTelepastoringCount, author WHERE member <> author

    WITH collect(member) as outstandingTelepastoring, council, completedTelepastoringCount

    RETURN council, completedTelepastoringCount, outstandingTelepastoring
`

export const logVisitationActivity = `
CREATE (visitation:VisitationActivity {id: randomUUID()})
CREATE (commentNode:PastoralComment {id: randomUUID()})

WITH visitation, commentNode AS comment
    SET visitation.datetime = datetime(),
    visitation.location = point({latitude:toFloat($latitude), longitude:toFloat($longitude), crs:'WGS-84'}),
    visitation.picture = $picture,
    comment.comment = $comment,
    comment.timestamp = datetime(),
    comment.activity = 'Visitation',
    comment.roleLevel = $roleLevel

WITH visitation, comment
MATCH (member:Member {id: $memberId})
OPTIONAL MATCH (memberIDL:IDL {id: $memberId})
SET member.location = point({latitude:toFloat($latitude), longitude:toFloat($longitude), crs:'WGS-84'}),
member.visitationArea = $visitationArea 
REMOVE memberIDL:IDL
SET memberIDL:Deer

WITH visitation, comment, member
MATCH (member)-[:BELONGS_TO]->(church)<-[:HAS*0..5]-(higherChurch)-[:CURRENT_HISTORY]->(log:ServiceLog)
MATCH (author:Member {auth_id: $auth.jwt.sub})-[:LEADS]->(higherChurch)
MATCH (author)-[:CURRENT_HISTORY]->(log)
WITH DISTINCT visitation, comment, member, author, higherChurch, log
MATCH (cycle:PastoralCycle {id: $cycleId})

MERGE (date:TimeGraph {date: date()})
MERGE (comment)-[:WRITTEN_ON]->(date)
MERGE (comment)-[:COMMENTS_ON]->(member)
MERGE (author)-[:WROTE]->(comment)

MERGE (visitation)-[:LEAVES_COMMENT]->(comment)
MERGE (visitation)<-[:PERFORMED_DUTY]-(log)
MERGE (visitation)-[:TOWARDS]->(member)
MERGE (visitation)-[:DURING_CYCLE]->(cycle)

RETURN visitation
`

export const alreadyLoggedVisitationForMember = `
    MATCH (member:Member {id: $memberId})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)
    MATCH (cycle:PastoralCycle {id: $cycleId})

    MATCH (member)<-[:TOWARDS]-(visitation:VisitationActivity)<-[:PERFORMED_DUTY]-(log)
    MATCH (cycle)<-[:DURING_CYCLE]-(visitation:VisitationActivity)

    RETURN visitation
`

export const getMemberBacentaVisitationLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(bacenta:Bacenta)
    MATCH (cycle:BacentaCycle {month: date().month, year: date().year})

    WITH bacenta, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(visitation:VisitationActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(visitation)-[:TOWARDS]->(member)

    WITH DISTINCT member, bacenta 

    WITH COUNT(member) as completedVisitationsCount, bacenta 

    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:BacentaCycle {month: date().month, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(bacenta)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(visitation:VisitationActivity)
        WHERE (visitation)-[:TOWARDS]->(member) AND (visitation)-[:DURING_CYCLE]->(cycle)
    }

    WITH DISTINCT member, labels(member) AS labels, bacenta, completedVisitationsCount, author WHERE member <> author

    WITH collect(member) as outstandingVisitations,  bacenta, completedVisitationsCount

    RETURN bacenta, completedVisitationsCount, outstandingVisitations
`

export const getMemberGovernorshipVisitationLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(:Bacenta)<-[:HAS]-(governorship:Governorship)
    MATCH (governorship)-[:HAS]->(bacenta:Bacenta)
    MATCH (cycle:GovernorshipCycle {quarter: date().quarter, year: date().year})

    WITH bacenta, governorship, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(visitation:VisitationActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(visitation)-[:TOWARDS]->(member)

    WITH DISTINCT member, governorship

    WITH COUNT(member) as completedVisitationsCount, governorship

    MATCH (governorship)-[:HAS]->(bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:GovernorshipCycle {quarter: date().quarter, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(governorship)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(visitation:VisitationActivity)
        WHERE (visitation)-[:TOWARDS]->(member) AND (visitation)-[:DURING_CYCLE]->(cycle)
    }

    OPTIONAL MATCH (author)-[:LEADS]->(lowerChurch)-[:HAS*0..1]->(:Bacenta)<-[:BELONGS_TO]-(alreadyMember:Member)
    WHERE lowerChurch:Bacenta 
    WITH governorship, completedVisitationsCount, member, author, collect(DISTINCT alreadyMember) AS alreadyMembers WHERE NOT member IN alreadyMembers

    WITH DISTINCT member, labels(member) AS labels, governorship, completedVisitationsCount, author WHERE member <> author

    WITH collect(member) as outstandingVisitations, governorship, completedVisitationsCount

    RETURN governorship, completedVisitationsCount, outstandingVisitations
`

export const getMemberCouncilVisitationLists = `
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(:Bacenta)<-[:HAS*2]-(council:Council)
    MATCH (council)-[:HAS*2]->(bacenta:Bacenta)
    MATCH (cycle:CouncilCycle {half: toInteger(ceil(toFloat(date().month)/toFloat(6))) - 1, year: date().year})

    WITH bacenta, council, cycle
    MATCH (bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle)<-[:DURING_CYCLE]-(visitation:VisitationActivity)
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)-[:PERFORMED_DUTY]->(visitation)-[:TOWARDS]->(member)

    WITH DISTINCT member, council

    WITH COUNT(member) as completedVisitationsCount, council

    MATCH (council)-[:HAS*2]->(bacenta)<-[:BELONGS_TO]-(member:Active:Member)
    MATCH (cycle:CouncilCycle {half: toInteger(ceil(toFloat(date().month)/toFloat(6))) - 1, year: date().year})
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:CURRENT_HISTORY]->(log:ServiceLog)<-[:CURRENT_HISTORY]-(council)
    WHERE NOT EXISTS {
        MATCH (log)-[:PERFORMED_DUTY]->(visitation:VisitationActivity)
        WHERE (visitation)-[:TOWARDS]->(member) AND (visitation)-[:DURING_CYCLE]->(cycle)
    }
    
    OPTIONAL MATCH (author)-[:LEADS]->(lowerChurch)-[:HAS*0..1]->(:Bacenta)<-[:BELONGS_TO]-(alreadyMember:Member)
    WHERE lowerChurch:Governorship OR lowerChurch:Bacenta 
    WITH council, completedVisitationsCount, member, author, collect(DISTINCT alreadyMember) AS alreadyMembers WHERE NOT member IN alreadyMembers

    WITH DISTINCT member, labels(member) AS labels, council, completedVisitationsCount, author WHERE member <> author

    WITH collect(member) as outstandingVisitations, council, completedVisitationsCount

    RETURN council, completedVisitationsCount, outstandingVisitations
`

export const logMembershipData = `
    MATCH (cycle:PastoralCycle {id: $cycleId})
    MATCH (member:Member {id: $memberId})
    MATCH (member)-[:BELONGS_TO]->(church:Bacenta)<-[:HAS*0..4]-(higherChurch)-[:CURRENT_HISTORY]->(log:ServiceLog)
    WHERE  higherChurch:Bacenta OR higherChurch:Governorship OR higherChurch:Council OR higherChurch:Stream
    MATCH (author:Member {auth_id: $auth.jwt.sub})-[:LEADS]->(higherChurch)
    MATCH (author)-[:CURRENT_HISTORY]->(log)

    MATCH (higherChurch)-[:HAS*0..4]->(bacenta:Bacenta)<-[:BELONGS_TO]-(members:Active:Member)
    OPTIONAL MATCH (bacenta)<-[:BELONGS_TO]-(deer:Deer:Active)
    OPTIONAL MATCH (bacenta)<-[:BELONGS_TO]-(goats:Goat:Active)
    OPTIONAL MATCH (bacenta)<-[:BELONGS_TO]-(sheep:Sheep:Active)

    WITH cycle, log, church, author, 
    COUNT(DISTINCT members) AS members, COUNT(DISTINCT deer) AS deer, COUNT(DISTINCT goats) AS goats, COUNT(DISTINCT sheep) AS sheep

    MERGE (data:MembershipData {id: 'membershipData_' + cycle.id + '_' + log.id})
        SET data.updatedAt = datetime(),
        data.membersCount = members,
        data.deerCount = deer,
        data.goatsCount = goats,
        data.sheepCount = sheep
    
    WITH cycle, log, church, data, author
    MERGE (data)-[:UPDATED_BY]->(author)
    MERGE (log)-[:HAS_DATA]->(data)
    MERGE (data)-[:DURING_CYCLE]->(cycle)
    
    RETURN cycle, log, church, data
`
