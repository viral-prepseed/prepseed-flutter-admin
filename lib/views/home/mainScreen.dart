import 'package:prepseed/model/playlist_model/assignment_model/upload_assi_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:prepseed/helper/provider/analysis/report.dart';
import 'package:prepseed/helper/provider/leadershipProvider.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';
import 'package:prepseed/repository/playlist_provider/videos_provider.dart';
import 'package:prepseed/views/menu/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../constants/theme/style.dart';
import '../../helper/api/functions.dart';
import '../../helper/provider/analysisProvider.dart';
import '../../helper/provider/tests/assessmentWrappers.dart';
import '../../helper/provider/testsProvider.dart';
import '../../helper/sharedPref.dart';
import '../../init/InitializeProviderScreen.dart';
import '../../model/assesments/reports.dart';
import '../../repository/playlist_provider/videos_provider.dart';
import '../adventure/attempt_liveTest.dart';
import '../execute/test/AttemptTest.dart';
import '../execute/test/viewAnalysis.dart';


class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late var username = '';
  late List<Map>? listOfColumns;
  List<Items> listOfItems = [];
   //TooltipBehavior _tooltipBehavior = TooltipBehavior();
  @override
  void initState() {
    fetchPref();
   /* Future.microtask(() async => {
      await Provider.of<VideosProvider>(context, listen: false)
          .getSubscriptions(),
      await Provider.of<ReportClass>(context, listen: false)
          .getReportsAPI(),
      await Provider.of<TestProviderClass>(context, listen: false)
          .apiCall(),
    });*/
    initProvider();
    getAssesmentId();
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

  initProvider(){
    Future.microtask(() async => {
      await Provider.of<ReportClass>(context, listen: false)
          .getReportsAPI(),
      await Provider.of<VideosProvider>(context, listen: false)
          .getVideos(),
      await Provider.of<VideosProvider>(context, listen: false)
          .getAnnouncement(),
      await Provider.of<VideosProvider>(context, listen: false)
          .getDoubt(),
      await Provider.of<VideosProvider>(context, listen: false)
          .getSubscriptions(),
      await Provider.of<LeadershipClass>(context, listen: false)
          .apiCall(),
      await Provider.of<AssessmentWrappersClass>(context, listen: false)
          .getWrappersAPI(),
    });
  }
  fetchPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username')!;
  }
  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<TestProviderClass>(context);
    final myModel = Provider.of<AnalysisClass>(context);
    final vdoProv = Provider.of<VideosProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: Consumer<LeadershipClass>(builder: (context, prov, child){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const[
                         MenuWidget(),
                        // Text(username,style: GoogleFonts.poppins(color: Constants.black),),
                      ],
                    ),
                    Container(
                      height: 200.0,
                      padding: EdgeInsets.all(10.0),
                      //elevation: 2.0,
                      decoration:conDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Progress',
                            style: GoogleFonts.poppins(
                                color: Constants.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 10.0,),
                  /*        Style.divider(),*/
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                              ChangeNotifierProvider.value(
                                value: vdoProv,
                                child: Consumer(builder: (context, vdo, child){
                                   return vdoProv.config ? Container(
                                     margin: const EdgeInsets.all(10.0),
                                     padding: const EdgeInsets.all(10.0),
                                     width: MediaQuery.of(context).size.width - 70,
                                     height: 100,
                                     decoration: BoxDecoration(
                                       borderRadius: const BorderRadius.all(Radius.circular(10)),
                                       color: Constants.blacklight,
                                     ),
                                     child: Row(
                                       crossAxisAlignment:
                                       CrossAxisAlignment.center,
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: <Widget>[
                                         CircularPercentIndicator(
                                           radius: 70.0,
                                           animation: true,
                                           animationDuration: 2200,
                                           lineWidth: 07.0,
                                           percent: 0.0,
                                           center: Text(
                                             "0%",
                                             style: const TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 12.0),
                                           ),
                                           circularStrokeCap:
                                           CircularStrokeCap.butt,
                                           backgroundColor: Colors.white,
                                           progressColor: Colors.blue,
                                         ),
                                         Text(
                                           'Question Practiced',
                                           style: GoogleFonts.poppins(
                                               fontWeight: FontWeight.w500,
                                               color: Constants.black,
                                               fontSize: 15),
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                         ),
                                         const SizedBox(height: 10.0,)
                                         // Image.asset('assets/mastercard.png', width: 48.0)
                                       ],
                                     ),
                                   )
                                       :  Container();
                                }),
                              ),
                               Consumer<AssessmentWrappersClass>(builder: (context, aswModel, child){
                                  return Container(
                                    margin: const EdgeInsets.all(10.0),
                                    padding: const EdgeInsets.all(10.0),
                                    width: MediaQuery.of(context).size.width - 70,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      color: Constants.blacklight,
                                    ),
                                    child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              animation: true,
                                              animationDuration: 2200,
                                              lineWidth: 07.0,
                                              percent: 0.4,
                                              center: Text(
                                                "${aswModel.listData.length}/${aswModel.allAswList.length}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0),
                                              ),
                                              circularStrokeCap:
                                              CircularStrokeCap.butt,
                                              backgroundColor: Colors.white,
                                              progressColor: Colors.blue,
                                            ),
                                            Text(
                                              'Tests Taken',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Constants.black,
                                                  fontSize: 15),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 10.0,)
                                            // Image.asset('assets/mastercard.png', width: 48.0)
                                          ],
                                        ),
                                  );
                                }),
                               Consumer(builder: (context, vdo, child){
                                  return vdoProv.config ? Container(
                                    margin: const EdgeInsets.all(10.0),
                                    padding: const EdgeInsets.all(10.0),
                                    width: MediaQuery.of(context).size.width - 70,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      color: Constants.blacklight,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CircularPercentIndicator(
                                          radius: 70.0,
                                          animation: true,
                                          animationDuration: 2200,
                                          lineWidth: 07.0,
                                          percent: 0.0,
                                          center: Text(
                                            "0/3",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          ),
                                          circularStrokeCap:
                                          CircularStrokeCap.butt,
                                          backgroundColor: Colors.white,
                                          progressColor: Colors.blue,
                                        ),
                                        Text(
                                          'Videos Watched',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Constants.black,
                                              fontSize: 15),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10.0,)
                                        // Image.asset('assets/mastercard.png', width: 48.0)
                                      ],
                                    ),
                                  )
                                  : Container();
                               })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Weak Categories
                    Container(
                      //elevation: 2.0,
                     decoration:conDecoration,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Weak categories',
                                style: GoogleFonts.poppins(
                                    color: Constants.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ),
                           // Style.divider(),
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: const BoxDecoration(
                                borderRadius:  BorderRadius.all(Radius.circular(10)),
                                color:  Color(0xBCF4664A),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Isomerism & IUPAC Nomenclature',
                                    style: GoogleFonts.poppins(
                                        color: Constants.blacktext,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Organic Chemistry 1',
                                    style: GoogleFonts.poppins(
                                        color: Constants.blacktext,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                             // width: MediaQuery.of(context).size.width - 32,
                              // height: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFFC0ECCF),
                              ),
                              //height: 100,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Math for physics',
                                    style: GoogleFonts.poppins(
                                        color: Constants.blacktext,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Mechanics 1',
                                    style: GoogleFonts.poppins(
                                        color: Constants.blacktext,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      //elevation: 2.0,
                      decoration:conDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Test Recommendation',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                         // Style.divider(),
                          Container(
                            height: 220.0,
                            // width: 200.0,
                            child: ChangeNotifierProvider.value(
                              value: provMdl,
                              child: Consumer(builder: (context, dataItems, _) {
                                return ListView.builder(
                                  itemCount: provMdl.tabLength,
                                  itemBuilder: (context,index){
                                    return  Container(
                                      height: 220.0,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(10.0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: provMdl.tabContains.values.elementAt(index).length == null ? 0 : provMdl.tabContains.values.elementAt(index).length,
                                        itemBuilder: (BuildContext context, int idx) {
                                          List<AssessmentWrappers> asw = provMdl.tabContains.values.elementAt(index);
                                          // print(tablen);
                                          return Container(
                                            height: 200.0,
                                            width: 150.0,
                                            padding: const EdgeInsets.all(10.0),
                                            margin: const EdgeInsets.only(right: 15.0),
                                            // width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              color: Constants.grey.withOpacity(.2),
                                                border: Border.all(
                                                    color: Colors.black26,
                                                    width: 1.0),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: ListView(
                                              physics: const NeverScrollableScrollPhysics(),
                                              children: [
                                                const SizedBox(height: 10,),
                                                Text('${asw.elementAt(idx).name}',
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,),
                                                const SizedBox(height: 10,),
                                                Style.divider(),

                                                const SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: const [
                                                     Text('Questions'),
                                                     SizedBox(width: 10.0,),
                                                     Text('54'),
                                                  ],
                                                ),
                                                const SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Duration'),
                                                    const SizedBox(width: 10.0,),
                                                    Text(provMdl.printDuration(Duration(seconds: asw.elementAt(idx).core!.duration!))),
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                Style.divider(),
                                                const SizedBox(height: 10,),
                                                FutureBuilder<String>(
                                                  future: functions().getWrapperApiCall('${asw.elementAt(idx).sId}'),
                                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot,) {
                                                    if (snapshot.hasData) {
                                                      return ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),//to set border radius to button
                                                            ),
                                                          ),
                                                          onPressed: (){
                                                            var assessmentWrapperId = asw.elementAt(idx).sId;
                                                            sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                            Future.microtask(() async => {
                                                              Provider.of<TestProviderClass>(context, listen: false).assessments(assessmentWrapperId),
                                                            });

                                                            var route = MaterialPageRoute(builder: (BuildContext context) =>
                                                            // attempt_liveTest() :
                                                            const InitializeProviderScreen() );

                                                            (snapshot.data!.contains('Attempt'))? showDialogBox() :
                                                            Navigator.of(context).push(route);
                                                            /*var route = MaterialPageRoute(builder: (BuildContext context) => AttemptTest());
                                                  Navigator.of(context).push(route);*/
                                                          },
                                                          child: Text(
                                                            snapshot.data!,
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(
                                                              fontSize: 11.0,
                                                            ),)
                                                      );
                                                    } else {
                                                      return const Text('Loading data');
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                );}
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: conDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Video Watched',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                         // Style.divider(),
                          const SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ChangeNotifierProvider.value(
                              value: myModel,
                              child: Consumer(builder: (context, dataItems, _) {
                                return myModel.core != null
                                    ? SfCartesianChart(
                                    primaryXAxis: NumericAxis(
                                        isVisible: false
                                      /*minimum: 0,
                              maximum: 100,
                              interval: 10*/
                                    ),

                                    primaryYAxis:NumericAxis(
                                        minimum: 0,
                                        interval: 10,
                                        labelFormat: '{value}%',
                                        axisLine: const AxisLine(width: 0),
                                        minorTickLines: const MinorTickLines(size: 0)
                                    ),
                                    enableAxisAnimation: true,

                                    // Chart title
                                    // title: ChartTitle(text: '% Marks'),
                                    // Enable legend
                                    legend: Legend(isVisible: false),
                                    // Enable tooltip
                                    // tooltipBehavior: _tooltipBehavior,

                                    series: <ChartSeries>[
                                      SplineAreaSeries<Percentage, int>(
                                          borderWidth: 3,
                                          borderColor: Constants.primaryBlue,
                                          color: Constants.primaryBlue.withOpacity(0.25),
                                          splineType: SplineType.cardinal,
                                          dataSource:

                                          List.generate(myModel.core!.hist!.length, (index) =>
                                              Percentage(index, myModel.core!.hist!.elementAt(index) ),
                                          )
                                          /*[
                                  *//*Percentage(100, 4),
                                  Percentage(10, 3),
                                  Percentage(50, 11),
                                  Percentage(50, 10),
                                  Percentage(70, 2),
                                  Percentage(90, 2),*//*

                                  Percentage(' ', 4),
                                  Percentage('Feb', 3),
                                  Percentage('March', 11),
                                  Percentage('Apr', 10),
                                  Percentage('May', 2),
                                  Percentage('June', 2),
                                ]*/,
                                          xValueMapper: (Percentage sales, _) => sales.student,
                                          yValueMapper: (Percentage sales, _) => sales.marks,
                                          // Enable data label
                                          dataLabelSettings: const DataLabelSettings(isVisible: false)
                                      )
                                    ]
                                )
                                : Center(child: CircularProgressIndicator());}
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Behaviour needed
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: conDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Behaviour needed',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            //width: MediaQuery.of(context).size.width - 32,
                            color: Constants.blacklight,
                           // height: 400,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/logo.jpg',height: 100,fit: BoxFit.contain,),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Intent',style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.textcolor,
                                    fontSize: 15),),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'You need to attempt questions properly and spend more time in each question to improve your performance.'
                                      'You have made too many bluffs in the assessment.'
                                      'You haven\'t attempted many questions in the assessment.'
                                      'You have finished the assessment too early.',
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Constants.blacktext,
                                      fontSize: 12),
                                  maxLines: 50,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    testDetails(),
                  ],
                ),
              ),
            );
          }
      ),
    ),
    );
  }

  /*============================================== Details ==================================================*/
  Widget testDetails(){
    final provMdl = Provider.of<ReportClass>(context);
    listOfColumns = Provider.of<ReportClass>(context).listOfColumns;
    listOfItems = Provider.of<ReportClass>(context).items;

    /*listOfColumns =  [{'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]},
    {'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]}];
    */
    /*listOfColumns = Provider.of<ReportClass>(context, listen: false).listOfColumns;
    print(listOfColumns);*/

    // final List<Map> listOfColumns = Provider.of<ReportClass>(context, listen: false).listOfColumns;
   /* print(provMdl.mapStatsMax);*/
    return Consumer(builder: (context, reportsModel, child){
      // print(listOfColumns);
      // print(reportsModel.allReportsList.first.user!.overall!.marks);
      print(listOfItems);
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border:  TableBorder.all(width:1, color:Colors.black45),
            columns: [
                  DataColumn(label:  Text("Name")),
                  DataColumn(label:  Text("Date")),
                  DataColumn(label:  Text("Self")),
                  DataColumn(label:  Text("High")),
                  DataColumn(label:  Text("Avg")),
                  DataColumn(label:  Text("Self")),
                   DataColumn(label:  Text("High")),
                  DataColumn(label:  Text("Avg")),
                  DataColumn(label:  Text("Self")),
                  DataColumn(label:  Text("High")),
                  DataColumn(label:  Text("Avg")),
                  DataColumn(label:  Text("Self")),
                  DataColumn(label:  Text("High")),
                  DataColumn(label:  Text("Avg")),
                  DataColumn(label:  Text("Max")),
            ],
            rows: listOfItems.map((element) =>
                DataRow(
                cells: [
                  DataCell(Text(element.details![0].name.toString())),
                  DataCell(Text(element.details![0].availableFrom.toString())),
                  element.user != null ? DataCell(Text(element.user!.physics!.marks.toString()/*element['physics'].elementAt(0).toString()*/)) : DataCell(Text("0")),
                  element.topper!.physics != null ? DataCell(Text(element.topper!.physics!.marks.toString())) : DataCell(Text("0")),
                  DataCell(Text(element.statsBySection!.physics!.averageMarks.toString())),
                  element.user != null ? DataCell(Text(element.user!.mathematics!.marks.toString()/*element['mathematics'].elementAt(0).toString()*/)) : DataCell(Text("0")),
                  element.topper!.mathematics != null ?DataCell(Text(element.topper!.mathematics!.marks.toString())) : DataCell(Text("0")),
                  DataCell(Text(element.statsBySection!.mathematics!.averageMarks.toString())),
                  element.user != null ? DataCell(Text(element.user!.chemistry!.marks.toString()/*(element['chemistry'].elementAt(0).toString()*/)) : DataCell(Text("0")),
                  element.topper!.chemistry != null ? DataCell(Text(element.topper!.chemistry!.marks.toString())) : DataCell(Text("0")),
                  DataCell(Text(element.statsBySection!.chemistry!.averageMarks.toString())),
                  element.user != null ? DataCell(Text(element.user!.overall!.marks.toString()/*element['overall'].elementAt(0).toString()*/)) : DataCell(Text("0")),
                  element.topper!.overall!.marks != null ? DataCell(Text(element.topper!.overall!.marks.toString())) : DataCell(Text("0")),
                  DataCell(Text(element.statsBySection!.overall!.averageMarks.toString())),
                  DataCell(Text(element.maxMarks!.overall.toString())),
                ]
            )).toList()
          ),
        ),
      );
    });
  }

  /*============================================== Test Recommendations ==================================================*/
  Widget testRecommendation(){
    return Consumer<AssessmentWrappersClass>(builder: (context, aswModel, child){
      List<AssessmentWrappers> aswList = aswModel.allAswList;
      return FutureBuilder(builder: (context,snapshot){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Recommendations',
              style: GoogleFonts.poppins(
                  color: Constants.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 20),
              // color: Constants.red,
              height: 220,
              width: double.maxFinite,
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: (1 / .8),
                crossAxisSpacing: 10,
                mainAxisSpacing: 18,
                padding: const EdgeInsets.all(5.0),
                children: List.generate(aswList.length, (index) {
                  AssessmentWrappers asw = aswList.elementAt(index);

                  //bool assessment_attemp = false;
                  return Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Constants.backgroundColor,
                        // border: Border.all(color: Constants.grey),
                        boxShadow: const [BoxShadow(
                          color: Constants.grey,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Tooltip(
                              message: '${asw.name}',
                              child: Text('${asw.name}',
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,),
                            ),
                          ),
                          const Divider(color: Constants.grey,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const[
                               Text('Questions'),
                               Text('54'),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:const [
                               Text('Duration'),
                               Text('3 hrs'),
                            ],
                          ),
                          const Divider(color: Constants.grey,),

                          FutureBuilder<String>(
                            future: functions().getWrapperApiCall('${asw.sId}'),
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<String> snapshot,
                                ) {
                              if (snapshot.hasData) {
                                return ElevatedButton(onPressed: (){
                                  var assessmentWrapperId = asw.sId;
                                  sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                  var route = MaterialPageRoute(builder: (BuildContext context) => (snapshot.data!.contains('Attempt'))?
                                  const AttemptTest() : const viewAnalysis() );
                                  Navigator.of(context).push(route);
                                },
                                    child: Text(snapshot.data!)
                                );
                              } else {
                                return const Text('Loading data');
                              }
                            },
                          )

                        ],
                      ),
                    ),
                  );
                }
                ),
              ),
            ),
          ],
        );
      });
    });
  }

  /*============================================== Courses ==================================================*/
  Widget courses(){
    return Column(
      children: [
        Text(
          'Courses by {Client Name}',
          style: GoogleFonts.poppins(
              color: Constants.black,
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 32,
          // height: 400,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: Constants.blacklight,
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: const Color(0xDFA5A4A4),
                                child: Container(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      //image
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width - 40,
                              // height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('CBSE Class 10th Revision Course',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(fontWeight:
                                      FontWeight.w600,fontSize: 14,color: Constants.blacktext),),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('₹ 4555',style:
                                        GoogleFonts.poppins(fontWeight:
                                        FontWeight.w600,fontSize: 17,color: Constants.buttontextcolor),),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                  color: Constants.backgroundColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: const Text('Buy Now'),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }
  showDialogBox(){
    Map<dynamic,List<SubInstructions>> maplist = {};
    Future.delayed(Duration.zero, () async {
      return showDialog(context: context, builder: (context){
        return Dialog(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Constants.blue,
                    labelColor: Constants.white.withOpacity(0.8),
                    unselectedLabelColor: Constants.white.withOpacity(0.5),
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17),
                    tabs: const [
                      Tab(text: 'Instruction'),
                      Tab(text: 'Syllabus'),
                    ],
                  ),
                  Expanded(child: TabBarView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: maplist.length,
                                itemBuilder: (context,index ){
                                  var keys = maplist.keys.elementAt(index);
                                  List<SubInstructions> values = maplist.values.elementAt(index);
                                  return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(keys,style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: values.length,
                                          itemBuilder: (cntx,idx){
                                            var data = values.elementAt(idx).instruction;
                                            return Text(data??'', style: GoogleFonts.poppins(fontSize: 12,));
                                          }),
                                      const SizedBox(height: 5,)
                                    ],
                                  ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                // activeSession = true;
                              });
                              Navigator.of(context).pop();



                              var route = MaterialPageRoute(builder: (BuildContext context) => const attempt_liveTest());
                              Navigator.of(context).push(route);
                            }, child: const Text('Begin Test')),
                          ),
                        ],
                      ),
                      Container()
                      // Container(child: Text('smdfnjskfb'),),
                    ],
                  ))
                ],
              ),
            )
        );
      });
    });
  }

 BoxDecoration conDecoration = BoxDecoration(
     border: Border.all(
         color: Colors.grey,
     ),
     borderRadius: const BorderRadius.all(
         Radius.circular(10.0))
 );
}
