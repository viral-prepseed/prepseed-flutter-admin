import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/views/stats_analysis/analysis/leaderboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../constants/colorPalate.dart';

class overall extends StatefulWidget {
  const overall({Key? key}) : super(key: key);

  @override
  _overallState createState() => _overallState();
}

class _overallState extends State<overall> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late TooltipBehavior _tooltipBehavior;



  @override
  void initState() {
    // TODO: implement initState
    _tooltipBehavior =  TooltipBehavior(enable: true);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData('Correct', 4, Colors.green),
      ChartData('Incorrect', 13, Colors.red),
      ChartData('Unattempted', 73, Colors.grey),
    ];

    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 32,
            // height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: Constants.blacklight,
                child: Container(
                  // height: 200,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Ranking',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            Divider(
                              color: Constants.black,
                            ),
                            IntrinsicHeight(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text('Ranking'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '1533',
                                      style: GoogleFonts.poppins(
                                          color: Constants.primaryBlue,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                VerticalDivider(color: Constants.black),
                                Column(
                                  children: [
                                    Text('Overall Rank'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '#32',
                                      style: GoogleFonts.poppins(
                                          color: Constants.primaryBlue,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Constants.black,
                                ),
                                Column(
                                  children: [
                                    Text('Percentile'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '31.25%',
                                      style: GoogleFonts.poppins(
                                          color: Constants.primaryBlue,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),



          Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: Constants.blacklight,
                child: Container(
                  // height: 200,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TabBar(
                              unselectedLabelColor: Colors.black,
                              labelColor: Colors.red,
                              tabs: const [
                                Tab(
                                  text: 'Overall',
                                ),
                                Tab(
                                  text: 'Tpoic 1',
                                ),
                                Tab(
                                  text: 'Tpoic 2',
                                ),
                                Tab(
                                  text: 'Tpoic 3',
                                )
                              ],
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SfCircularChart(
                                    // Enables the tooltip for all the series in chart
                                      tooltipBehavior: _tooltipBehavior,
                                      legend: Legend(isVisible: true),
                                      series: [
                                        // Initialize line series
                                        PieSeries<ChartData, String>(
                                          // Enables the tooltip for individual series
                                          enableTooltip: true,
                                          explode: true,
                                          explodeAll: true,
                                          dataSource: chartData,
                                          xValueMapper: (ChartData data, _) => data.x,
                                          yValueMapper: (ChartData data, _) => data.y,
                                          pointColorMapper: (ChartData data, _) => data.color,
                                        )
                                      ]
                                  ),
                                  Container(child: Center(child: Text('people'))),
                                  Text('Person'),
                                  Text('Person'),
                                ],
                                controller: _tabController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),

          Container(
            width: MediaQuery.of(context).size.width - 32,
            // height: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: Constants.blacklight,
                child: Container(
                  // height: 200,
                  child: Stack(
                    children: [
                      LeaderBoard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),


        ],
      )),
    );
  }
}
class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.red]);
  final String x;
  final double y;
  Color color ;
}