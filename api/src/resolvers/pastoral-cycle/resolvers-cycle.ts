import {
  getBacentaCycleEndDate,
  getBacentaCycleStartDate,
  getNumberOfDaysInCycle,
} from './utils-cycle'

export const cycleResolvers = {
  PastoralComment: {
    typename: () => 'PastoralComment',
  },
  MissedChurchComment: {
    typename: () => 'MissedChurchComment',
  },
  VisitationActivity: {
    typename: () => 'VisitationActivity',
  },
  PrayerActivity: {
    typename: () => 'PrayerActivity',
  },
  TelepastoringActivity: {
    typename: () => 'TelepastoringActivity',
  },

  BacentaCycle: {
    typename: () => 'BacentaCycle',
    numberOfDays: (object: { startDate: string; endDate: string }) =>
      getNumberOfDaysInCycle(
        getBacentaCycleStartDate(new Date(object.startDate)),
        getBacentaCycleEndDate(new Date(object.endDate))
      ),
  },
  GovernorshipCycle: {
    typename: () => 'GovernorshipCycle',
    numberOfDays: (object: { startDate: string; endDate: string }) =>
      getNumberOfDaysInCycle(
        getBacentaCycleStartDate(new Date(object.startDate)),
        getBacentaCycleEndDate(new Date(object.endDate))
      ),
  },
  CouncilCycle: {
    typename: () => 'CouncilCycle',
    numberOfDays: (object: { startDate: string; endDate: string }) =>
      getNumberOfDaysInCycle(
        getBacentaCycleStartDate(new Date(object.startDate)),
        getBacentaCycleEndDate(new Date(object.endDate))
      ),
  },
  PastoralCycle: {
    typename: () => 'PastoralCycle',
    numberOfDays: (object: { startDate: string; endDate: string }) =>
      getNumberOfDaysInCycle(
        getBacentaCycleStartDate(new Date(object.startDate)),
        getBacentaCycleEndDate(new Date(object.endDate))
      ),
  },
}

export const cycleMutations = {}
