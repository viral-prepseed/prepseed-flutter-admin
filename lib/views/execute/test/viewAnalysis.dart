import 'package:flutter/material.dart';
import 'package:prepseed/helper/provider/analysisProvider.dart';
import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/model/getAnalysis/submission.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../constants/colorPalate.dart';
import '../../stats_analysis/reports/livetestScreen.dart';

class viewAnalysis extends StatefulWidget {
  const viewAnalysis({Key? key}) : super(key: key);

  @override
  _viewAnalysisState createState() => _viewAnalysisState();
}

String _printDuration(Duration duration) {
  print(duration.inSeconds);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

 timeFormatter (double time) {
  Duration duration = Duration(milliseconds: time.round());

  return time/60000;
}

class _viewAnalysisState extends State<viewAnalysis> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<ChartSampleData>? chartData;
  List<ChartData>? timeUsagechartData;

  @override
  void initState() {
    // TODO: implement initState
    getAssesmentId();

    timeUsagechartData = [
      ChartData('Correct', 64.4, Constants.green),
      ChartData('Incorrect', 6.2, Constants.red),
      ChartData('Unattempted', 28.2, Constants.lightblue),
    ];
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: DateTime(2006), y: 0.01, yValue: -0.03, secondSeriesYValue: 0.10,),
      ChartSampleData(
          x: DateTime(2007), y: 0.03, yValue: -0.02, secondSeriesYValue: 0.08),
      ChartSampleData(
          x: DateTime(2008),
          y: -0.06,
          yValue: -0.13,
          secondSeriesYValue: -0.03),
      ChartSampleData(
          x: DateTime(2009), y: -0.03, yValue: -0.04, secondSeriesYValue: 0.04),
      ChartSampleData(
          x: DateTime(2010), y: 0.09, yValue: 0.07, secondSeriesYValue: 0.19),
      ChartSampleData(
          x: DateTime(2011), y: 0, yValue: 0.04, secondSeriesYValue: 0),
      ChartSampleData(
          x: DateTime(2012), y: 0.01, yValue: -0.01, secondSeriesYValue: -0.09),
      ChartSampleData(
          x: DateTime(2013), y: 0.05, yValue: 0.05, secondSeriesYValue: 0.10),
      ChartSampleData(
          x: DateTime(2014), y: 0, yValue: 0.08, secondSeriesYValue: 0.05),
      ChartSampleData(
          x: DateTime(2015), y: 0.1, yValue: 0.01, secondSeriesYValue: -0.04),
      ChartSampleData(
          x: DateTime(2016), y: 0.08, yValue: 0, secondSeriesYValue: 0.02),
    ];
  }
  getAssesmentId() async {
    var id = await sharedPref().getSharedPref('assessmentWrapperId');
    var userId = await sharedPref().getSharedPref('userId');
    // print(userId);

    Future.microtask(() async => {
       await Provider.of<AnalysisClass>(context, listen: false)
          .apiCall(userId,id),
    });
    // _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnalysisClass>(builder: (context, myModel, child){
        List<GASections> sectionList = myModel.sectionList;
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  IntrinsicHeight(
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Test Held On',style: GoogleFonts.poppins(color: Constants.black,fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Text('21-11-2021',style: GoogleFonts.poppins(color: Constants.greytxt,fontSize: 12),),
                            ],
                          ),
                          VerticalDivider(color: Constants.grey,),
                          Column(
                            children: [
                              Text('Test Submitted On',style: GoogleFonts.poppins(color: Constants.black,fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Text('21-06-2022',style: GoogleFonts.poppins(color: Constants.greytxt,fontSize: 12),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Scorecard', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Constants.grey.withOpacity(0.25),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        // columnWidths: {0: FractionColumnWidth(.4)},
                        border: TableBorder.symmetric(inside: BorderSide.none),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Marks Obtained'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.marks}/${myModel.maxMarks}'),],)
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Overall Rank'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.rank}'),],)
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Percentile'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.percentile}'),],)
                          ]),
                          /*TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Accuracy'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.percentile}'),],)
                          ]),*/
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Questions Attempted'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.questionsAttempted}'),],)
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Correct Questions'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.correctQuestions}'),],)
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Incorrect Questions'),
                            ),
                            Column(children: [Text('${myModel.alldatas!.incorrectQuestions}'),],)
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 20),
                    // width: MediaQuery.of(context).size.width - 32,
                    height: MediaQuery.of(context).size.height - 510,
                    child: Container(
                      child: Card(
                        color: Constants.grey.withOpacity(0.25),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: DefaultTabController(
                            length: sectionList.length,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TabBar(
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Colors.red,
                                  tabs: List.generate(sectionList.length, (index) {
                                    return Tab(text: sectionList.elementAt(index).name,);
                                  }),
                                  // controller: _tabController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: List.generate(sectionList.length, (index) {
                                      return Table(

                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Marks'),
                                            ),
                                            Column(children: [Text('${sectionList.elementAt(index).marks.toString()}'),],)
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Marks Attempted'),
                                            ),
                                            Column(children: [Text('${sectionList.elementAt(index).marksAttempted.toString()}'),],)
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Marks Lost'),
                                            ),
                                            Column(children: [Text('${sectionList.elementAt(index).marksLost.toString()}'),],)
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Marks Gained'),
                                            ),
                                            Column(children: [Text('${sectionList.elementAt(index).marksGained.toString()}'),],)
                                          ]),
                                          /*TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Accuracy'),
                                            ),
                                            Column(children: [Text('${sectionList.elementAt(index).marks.toString()}'),],)
                                          ]),*/
                                        ],
                                      );
                                    })
                                    // controller: _tabController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Know where you stand', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),)
                    ],
                  ),



                  const SizedBox(height: 10,),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        /*maximum: 100,
                        minimum: 0,*/
                        interval: 10
                      ),

                      primaryYAxis: NumericAxis(
                          /*maximum: 15.00,
                          minimum: 0.0,*/
                        // numberFormat: NumberFormat.percentPattern()
                      ),
                      enableAxisAnimation: true,

                      // Chart title
                      // title: ChartTitle(text: '% Marks'),
                      // Enable legend
                      legend: Legend(isVisible: false),
                      // Enable tooltip
                      // tooltipBehavior: _tooltipBehavior,

                      series: <ChartSeries>[
                          SplineAreaSeries<Percentage, String>(
                          borderWidth: 3,
                          borderColor: Constants.primaryBlue,
                          color: Constants.primaryBlue.withOpacity(0.25),
                          splineType: SplineType.cardinal,
                            dataSource:  [
                              /*Percentage(100, 4),
                              Percentage(10, 3),
                              Percentage(50, 11),
                              Percentage(50, 10),
                              Percentage(70, 2),
                              Percentage(90, 2),*/
                              Percentage(' ', 4),
                              Percentage('Feb', 3),
                              Percentage('March', 11),
                              Percentage('Apr', 10),
                              Percentage('May', 2),
                              Percentage('June', 2),
                            ],
                            xValueMapper: (Percentage sales, _) => sales.student,
                            yValueMapper: (Percentage sales, _) => sales.marks,
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: false)
                        )
                      ]
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Recommendations', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Constants.grey.withOpacity(0.25),
                    elevation: 0,
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Weak categories',style: GoogleFonts.poppins(color: Constants.black,fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      tileColor: Constants.backgroundColorlight,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: Text('Math for physics',style: GoogleFonts.poppins(color: Constants.black,fontSize: 14,fontWeight: FontWeight.w600),),
                                      subtitle: Text('Physics',style: GoogleFonts.poppins(color: Constants.greytxt,fontSize: 12,fontWeight: FontWeight.w600),),
                                    ),
                                    SizedBox(height: 10,),
                                    ListTile(
                                      tileColor: Constants.backgroundColorlight,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: Text('Math for physics',style: GoogleFonts.poppins(color: Constants.black,fontSize: 14,fontWeight: FontWeight.w600),),
                                      subtitle: Text('Physics',style: GoogleFonts.poppins(color: Constants.greytxt,fontSize: 12,fontWeight: FontWeight.w600),),
                                    ),
                                    SizedBox(height: 10,),
                                    ListTile(
                                      tileColor: Constants.backgroundColorlight,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: Text('Math for physics',style: GoogleFonts.poppins(color: Constants.black,fontSize: 14,fontWeight: FontWeight.w600),),
                                      subtitle: Text('Physics',style: GoogleFonts.poppins(color: Constants.greytxt,fontSize: 12,fontWeight: FontWeight.w600),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // VerticalDivider(color: Constants.grey,),
                          Column(
                            children: [
                              Text('Behaviour needed',style: GoogleFonts.poppins(color: Constants.black,fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Text('Intent',style: GoogleFonts.poppins(color: Constants.black,fontSize: 15,fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('''You need to attempt questions properly and spend more time in each question to improve your performance.'
You have made too many bluffs in the assessment.
You haven\'t attempted many questions in the assessment.
You have finished the assessment too early.''',style: GoogleFonts.poppins(color: Constants.greytxt,fontSize: 12),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Behaviour Analysis', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    // title: ChartTitle(text: isCardView ? '' : 'Export growth rate'),
                    // legend: Legend(isVisible: !isCardView),
                    /*primaryXAxis: DateTimeAxis(
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  majorGridLines: const MajorGridLines(width: 0),
                ),*/
                    primaryXAxis: NumericAxis(
                        minimum: 0,
                        // maximum: 180,
                        interval: 20
                    ),
                    primaryYAxis: NumericAxis(
                        minimum: 0,
                        interval: 5,
                        labelFormat: '{value}%',
                        axisLine: const AxisLine(width: 0),
                        minorTickLines: const MinorTickLines(size: 0)),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: [ScatterSeries<ChartSampleData, num>(
                        dataSource: myModel.chartSampleList,
                        opacity: 0.7,
                        xValueMapper: (ChartSampleData sales, _) => sales.x,
                        yValueMapper: (ChartSampleData sales, _) => sales.y!/10,
                        dataLabelMapper: (ChartSampleData sales, _) => sales.text ?? 'savdahgscvcs dcd',
                        markerSettings: const MarkerSettings(height: 10, width: 10,),
                        name: 'Brazil \nsffsdf sfffffffffffGreeehzv'
                    ),
                      /*ScatterSeries<ChartSampleData, DateTime>(
                      opacity: 0.7,
                      dataSource: chartData!,
                      xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      markerSettings: const MarkerSettings(height: 15, width: 15),
                      name: 'Canada'),
                  ScatterSeries<ChartSampleData, DateTime>(
                    dataSource: chartData!,
                    color: const Color.fromRGBO(0, 168, 181, 1),
                    xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
                    yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
                    name: 'India',
                    markerSettings: const MarkerSettings(height: 15, width: 15,isVisible: false),
                  )*/
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Time Usage', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartData, String>(
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
                            dataSource: timeUsagechartData!,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            pointColorMapper: (ChartData data, _) => data.color,
                          borderRadius: BorderRadius.circular(5),
                        )
                      ]
                  )
                ],
              ),
            ),
          ),
        );
    }),
    );
  }


/*  List<ScatterSeries<ChartSampleData, DateTime>> _getDefaultScatterSeries() {
    return <ScatterSeries<ChartSampleData, DateTime>>[

    ];
  }*/

}

class Percentage {
  Percentage(this.student, this.marks);
  final String student;
  final double marks;
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
        this.y,
        this.xValue,
        this.yValue,
        this.secondSeriesYValue,
        this.thirdSeriesYValue,
        this.pointColor,
        this.size,
        this.text,
        this.open,
        this.close,
        this.low,
        this.high,
        this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}

