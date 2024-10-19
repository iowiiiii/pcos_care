//rough algo for period prediction model/api

class PeriodPredictor {
  Map<DateTime, List<DateTime>> predictPeriodDates({
    required DateTime lastPeriodEndDate,
    required int periodDuration,
    required int cycleLength,
    int numOfCycles = 12,                 //num of future periods to predict
  }) {
    Map<DateTime, List<DateTime>> predictedPeriods = {};

    DateTime currentPeriodStart = lastPeriodEndDate.add(Duration(days: cycleLength));

    for (int i = 0; i < numOfCycles; i++) {
      //list of days for period duration
      List<DateTime> periodDays = List.generate(
          periodDuration,
              (index) => currentPeriodStart.add(Duration(days: index))
      );

      predictedPeriods[currentPeriodStart] = periodDays;

      //add the cycle length to the current period start
      currentPeriodStart = currentPeriodStart.add(Duration(days: cycleLength));
    }

    return predictedPeriods;
  }
}
