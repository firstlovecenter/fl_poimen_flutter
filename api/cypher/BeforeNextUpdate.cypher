MATCH (cycle:ConstituencyCycle)
SET cycle:GovernorshipCycle
RETURN cycle;
