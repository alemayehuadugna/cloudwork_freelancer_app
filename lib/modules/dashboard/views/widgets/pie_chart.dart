import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// class StaticChart extends StatelessWidget {
//   const StaticChart({Key? key, required this.total}) : super(key: key);

//   final int total;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: Stack(
//         children: [
//           PieChart(
//             PieChartData(
//               sectionsSpace: 0,
//               centerSpaceRadius: 70,
//               startDegreeOffset: -90,
//               sections: pieChartSelectionData,
//             ),
//           ),
//           Positioned.fill(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   "Total",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline4!
//                       .copyWith(fontWeight: FontWeight.w600, height: 0.5),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("$total"),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class DashboardStatic extends StatelessWidget {
  const DashboardStatic({
    Key? key,
    required this.cancelledJobs,
    required this.completedJobs,
    required this.ongoingJobs,
  }) : super(key: key);

  final int ongoingJobs;
  final int completedJobs;
  final int cancelledJobs;

  double _getPercent(int value) {
    var total = cancelledJobs + completedJobs + ongoingJobs;
    if (total == 0) {
      return 0;
    }
    return (completedJobs / (cancelledJobs + completedJobs + ongoingJobs)) *
        100;
  }

  @override
  Widget build(BuildContext context) {
    print("_getPercent: ${_getPercent(5)}");
    List<PieChartSectionData> pieChartSelectionData = [
      PieChartSectionData(
        color: const Color(0xFF26E5FF),
        value: 20,
        showTitle: false,
        radius: _getPercent(completedJobs),
      ),
      PieChartSectionData(
        color: const Color(0xFFFFCF26),
        value: 10,
        showTitle: false,
        radius: _getPercent(cancelledJobs),
      ),
      PieChartSectionData(
        color: Colors.blue.withOpacity(0.1),
        value: 25,
        showTitle: false,
        radius: _getPercent(ongoingJobs),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Static Analysis",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 70,
                        startDegreeOffset: -90,
                        sections: pieChartSelectionData,
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Total",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.w600, height: 0.5),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "${(completedJobs + ongoingJobs + cancelledJobs)}"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // StaticChart(total: ),
              ChartDetail(
                title: "Completed Jobs",
                color: Colors.cyanAccent,
                percentage: completedJobs,
              ),
              ChartDetail(
                title: " Ongoing Proposals",
                color: Color(0XFFfa6ca4),
                percentage: ongoingJobs,
              ),
              ChartDetail(
                title: "Cancelled Proposals",
                color: Color(0XFFfacd3a),
                percentage: cancelledJobs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartDetail extends StatelessWidget {
  const ChartDetail(
      {Key? key,
      required this.title,
      required this.color,
      required this.percentage})
      : super(key: key);

  final String title;
  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Icon(
                Icons.circle,
                color: color,
                size: 18,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            Text("$percentage"),
          ],
        ),
      ),
    );
  }
}
