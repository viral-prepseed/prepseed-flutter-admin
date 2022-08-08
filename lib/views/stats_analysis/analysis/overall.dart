import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/helper/api/functions.dart';
import 'package:prepseed/helper/provider/userDerailsProvider.dart';
import 'package:prepseed/model/usertopics.dart';
import 'package:prepseed/views/stats_analysis/analysis/leaderboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../constants/colorPalate.dart';
import 'package:provider/provider.dart';

import '../../../helper/provider/leadershipProvider.dart';

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

    Future.microtask(() async => {
      await Provider.of<LeadershipClass>(context, listen: false)
          .apiCall(),
      await Provider.of<UserClass>(context, listen: false)
          .apiCall(),
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData('Correct', 4, Colors.green),
      ChartData('Incorrect', 13, Colors.red),
      ChartData('Unattempted', 73, Colors.grey),
    ];

    return SingleChildScrollView(
      child: Consumer<LeadershipClass>(builder: (context, myModel, child){
        return Column(

          children: [
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ranking',
                  style: GoogleFonts.poppins(
                      color: Constants.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
                SizedBox(height: 10,),
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
                                  /*Divider(
                                    color: Constants.black,
                                  ),*/
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
                                                '${myModel.listData!.rating}',
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
                                                '#${myModel.listData!.rank}',
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
                                                '${myModel.listData!.percentile}%',
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Topic Stats',
                  style: GoogleFonts.poppins(
                      color: Constants.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
                SizedBox(height: 10,),
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
                              child:
                              Consumer<UserClass>(builder: (context, userModel, child){
                                return DefaultTabController(
                                  length: userModel.listData.length,
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TabBar(
                                      unselectedLabelColor: Colors.black,
                                      labelColor: Colors.red,
                                      isScrollable: true,
                                      labelStyle: TextStyle(color: Constants.black),
                                      tabs: List.generate(userModel.listData.length, (index)
                                      {
                                        // print(userModel.topicpost);
                                        var listTopics = userModel.topicpost.elementAt(index);
                                        return (listTopics.isEmpty) ? const Tab(text: ' ') :
                                        Tab(
                                          text: '${listTopics.elementAt(0).name ?? ''}',
                                        );

                                      }),
                                      // controller: _tabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children:
                                    // [

                                          List.generate(userModel.listData.length, (index) =>
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
                                                      dataSource: [
                                                        ChartData('Correct', userModel.listData.elementAt(index).testPerformance?.correct!, Colors.green),
                                                        ChartData('Incorrect', userModel.listData.elementAt(index).testPerformance?.incorrect!, Colors.red),
                                                        ChartData('Unattempted', userModel.listData.elementAt(index).testPerformance?.unattempted!, Colors.grey),
                                                      ],
                                                      xValueMapper: (ChartData data, _) => data.x,
                                                      yValueMapper: (ChartData data, _) => data.y,
                                                      pointColorMapper: (ChartData data, _) => data.color,
                                                    )
                                                  ]
                                              ),
                                          )

                                          /*Container(child: Center(child: Text('people'))),
                                          Text('Person'),
                                          Text('Person'),*/
                                        // ],
                                        // controller: _tabController,
                                      ),
                                    ),
                                  ],
                              ),
                                );

      })
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
              ],
            ),

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
        );
      })



    );
  }
}
class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.red]);
  final String x;
  final int? y;
  Color color ;
}