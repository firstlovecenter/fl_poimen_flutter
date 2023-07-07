import 'package:flutter/material.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/widgets/user_header_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MembershipTrendsWidget extends StatefulWidget {
  const MembershipTrendsWidget({Key? key, required this.church}) : super(key: key);
  final ChurchForMembershipAttendanceTrends church;

  final Color presentBarColor = Colors.greenAccent;
  final Color absentBarColor = Colors.redAccent;
  final Color avgColor = Colors.yellowAccent;
  @override
  State<MembershipTrendsWidget> createState() => _MembershipTrendsWidgetState();
}

class _MembershipTrendsWidgetState extends State<MembershipTrendsWidget> {
  final double width = 20;

  late List<BarChartGroupData> rawBarGroups = [];
  late List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final items = widget.church.services.map((service) {
      return makeGroupData(
        widget.church.services.indexOf(service),
        service.membersPresentFromFellowshipCount.toDouble(),
        service.membersAbsentFromFellowshipCount.toDouble(),
      );
    }).toList();

    rawBarGroups = items.reversed.toList();

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const UserHeaderWidget(),
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
                    const Text(
                      'Weekday Service',
                      style: TextStyle(color: Colors.white, fontSize: 22),
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
                                color: Colors.white,
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
                          sideTitles: SideTitles(showTitles: false),
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
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
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
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // show serviceDate for the bottomTitles

    final titles = widget.church.services.map((service) {
      final DateTime date = service.serviceDate.date;
      final DateFormat formatter = DateFormat.MMMd();
      return formatter.format(date);
    }).toList();

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
      space: 16, //margin top
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
