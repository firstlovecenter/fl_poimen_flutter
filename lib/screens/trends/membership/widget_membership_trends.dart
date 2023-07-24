import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/member_header_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MembershipTrendsWidget extends StatefulWidget {
  MembershipTrendsWidget({Key? key, required this.church}) : super(key: key);
  final ChurchForMembershipAttendanceTrends church;

  final Color presentBarColor = Colors.greenAccent;
  final Color presentBarColor2 = Colors.greenAccent.shade700;
  final Color absentBarColor = Colors.redAccent;
  final Color absentBarColor2 = Colors.redAccent.shade700;
  final Color avgColor = Colors.yellowAccent;
  @override
  State<MembershipTrendsWidget> createState() => _MembershipTrendsWidgetState();
}

class _MembershipTrendsWidgetState extends State<MembershipTrendsWidget> {
  final double width = 20;

  late List<BarChartGroupData> rawBarGroups = [];
  late List<BarChartGroupData> showingBarGroups = [];
  List<DateTime> rawData = [];

  int touchedGroupIndex = -1;
  final categoryOptions = ['Bussing', 'Services'];
  String category = 'Bussing';

  void setCategory(String newCategory) {
    setState(() {
      category = newCategory;

      if (category == 'Services') {
        var serviceData = widget.church.serviceWeeks.map((service) {
          return makeGroupData(
            widget.church.serviceWeeks.indexOf(service),
            service.membersPresentAtWeekdayCount.toDouble(),
            service.membersAbsentAtWeekdayCount.toDouble(),
          );
        }).toList();

        rawBarGroups = serviceData.reversed.toList();
        showingBarGroups = rawBarGroups;
      }
      if (category == 'Bussing') {
        var bussingData = widget.church.bussingWeeks.map((bussing) {
          return makeGroupData(
            widget.church.bussingWeeks.indexOf(bussing),
            bussing.membersPresentAtWeekendCount.toDouble(),
            bussing.membersAbsentAtWeekendCount.toDouble(),
          );
        }).toList();

        rawBarGroups = bussingData.reversed.toList();
        showingBarGroups = rawBarGroups;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    List<BarChartGroupData> items = [];

    items = widget.church.bussingWeeks.map((service) {
      return makeGroupData(
        widget.church.bussingWeeks.indexOf(service),
        service.membersPresentAtWeekendCount.toDouble(),
        service.membersAbsentAtWeekendCount.toDouble(),
      );
    }).toList();

    rawBarGroups = items.reversed.toList();
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return ListView(
      children: [
        MemberHeaderWidget(
          member: widget.church.leader,
          role: Role.values.byName('leader${widget.church.typename}'),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    makeTransactionsIcon(),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      category == 'Bussing' ? 'Weekend Service' : 'Weekday Service',
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'in Weeks',
                      style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 38,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: widget.presentBarColor,
                      child: Center(child: Container()),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Members Present',
                      style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: widget.absentBarColor,
                      child: Center(child: Container()),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Members Absent',
                      style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: 20,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: const Color.fromARGB(0, 5, 4, 4),
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return BarTooltipItem(
                              rod.toY.round().toString(),
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 42,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 28,
                            interval: 1,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleSwitch(
              minWidth: 100,
              initialLabelIndex: categoryOptions.indexOf(category),
              activeBgColors: [
                [widget.presentBarColor, widget.presentBarColor2],
                [widget.absentBarColor, widget.absentBarColor2]
              ],
              inactiveBgColor: isDarkMode ? const Color.fromARGB(255, 43, 43, 43) : Colors.grey,
              totalSwitches: categoryOptions.length,
              radiusStyle: true,
              cornerRadius: 20.0,
              labels: categoryOptions,
              animate: true,
              animationDuration: 200,
              onToggle: (index) {
                return setCategory(categoryOptions[index!]);
              },
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.all(10)),
        MembershipSummaryDisplay(church: widget.church)
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> titles = [];

    if (category == 'Services') {
      titles = widget.church.serviceWeeks.map((service) => 'Wk ${service.week}').toList();
    }

    if (category == 'Bussing') {
      titles = widget.church.bussingWeeks.map((bussing) => 'Wk ${bussing.week}').toList();
    }

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, // margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      showingTooltipIndicators: [0, 1],
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.presentBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.absentBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}

class MembershipSummaryDisplay extends StatelessWidget {
  const MembershipSummaryDisplay({
    super.key,
    required this.church,
  });

  final ChurchForMembershipAttendanceTrends church;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Column(
      children: [
        const Text('Membership Summary',
            style: TextStyle(fontSize: 18, color: PoimenTheme.textSecondary)),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${church.sheepCount} Sheep',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 215, 246, 181),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4.0)),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${church.goatsCount} Goats',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 248, 248, 158),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4.0)),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${church.deerCount} Deer',
                  style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 254, 142, 142)),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4.0)),
            IntrinsicWidth(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                tileColor: isDarkMode ? PoimenTheme.darkCardColor : PoimenTheme.lightCardColor,
                leading: const Icon(
                  FontAwesomeIcons.magnifyingGlassLocation,
                  color: Colors.white,
                ),
                minLeadingWidth: 20,
                title: church.lostCount == 0
                    ? const Text(
                        'No Lost Members',
                      )
                    : Text(
                        '${church.lostCount} Lost ${church.lostCount == 1 ? 'Member' : 'Members'}',
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
