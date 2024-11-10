const getLastDayOfMonth = (date: Date) => {
  return new Date(date.getFullYear(), date.getMonth() + 1, 0, 23, 59, 59)
}
const getFirstDayOfMonth = (date: Date) => {
  return new Date(date.getFullYear(), date.getMonth(), 1)
}

/// / NUMBER OF DAYS CALCULATIONS ////
export const getNumberOfDaysInCycle = (startDate: Date, endDate: Date) => {
  const oneDay = 1000 * 60 * 60 * 24
  const diffInMs = endDate.getTime() - startDate.getTime()

  return Math.round(diffInMs / oneDay)
}

/// / CYCLE START AND END DATES ///
export const getStreamCycleStartDate = (now: Date) => {
  const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 1, 0))
  return firstDay
}
export const getStreamCycleEndDate = (now: Date) => {
  const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 1, 0))
  return lastDay
}

export const getBacentaCycleStartDate = (now: Date) => {
  const firstDayOfMonth = getFirstDayOfMonth(now)

  const startDate = firstDayOfMonth

  return startDate
}
export const getBacentaCycleEndDate = (now: Date) => {
  const lastDayOfMonth = getLastDayOfMonth(now)

  const endDate = lastDayOfMonth

  return endDate
}
export const getGovernorshipCycleStartDate = (now: Date) => {
  if (now.getMonth() >= 1 && now.getMonth() <= 3) {
    const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 1, 0))
    return firstDay
  }
  if (now.getMonth() >= 4 && now.getMonth() <= 6) {
    const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 4, 0))
    return firstDay
  }
  if (now.getMonth() >= 7 && now.getMonth() <= 9) {
    const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 7, 0))
    return firstDay
  }
  if (now.getMonth() >= 10 && now.getMonth() <= 12) {
    const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 10, 0))
    return firstDay
  }
  return getStreamCycleStartDate(now)
}
export const getGovernorshipCyleEndDate = (now: Date) => {
  if (now.getMonth() >= 1 && now.getMonth() <= 3) {
    const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 4, 0))
    return lastDay
  }
  if (now.getMonth() >= 4 && now.getMonth() <= 6) {
    const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 7, 0))
    return lastDay
  }
  if (now.getMonth() >= 7 && now.getMonth() <= 9) {
    const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 10, 0))
    return lastDay
  }
  if (now.getMonth() >= 10 && now.getMonth() <= 12) {
    const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 1, 0))
    return lastDay
  }
  return getStreamCycleEndDate(now)
}
export const getCouncilCycleStartDate = (now: Date) => {
  if (now.getMonth() >= 1 && now.getMonth() <= 6) {
    const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 1, 0))
    return firstDay
  }
  if (now.getMonth() >= 7 && now.getMonth() <= 12) {
    const firstDay = getLastDayOfMonth(new Date(now.getFullYear(), 7, 0))
    return firstDay
  }
  return getStreamCycleStartDate(now)
}
export const getCouncilCycleEndDate = (now: Date) => {
  if (now.getMonth() >= 1 && now.getMonth() <= 6) {
    const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 7, 0))
    return lastDay
  }
  if (now.getMonth() >= 7 && now.getMonth() <= 12) {
    const lastDay = getLastDayOfMonth(new Date(now.getFullYear(), 1, 0))
    return lastDay
  }
  return getStreamCycleEndDate(now)
}
