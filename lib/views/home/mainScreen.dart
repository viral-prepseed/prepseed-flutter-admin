import 'package:flutter/cupertino.dart';
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
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../helper/api/functions.dart';
import '../../helper/provider/tests/assessmentWrappers.dart';
import '../../helper/sharedPref.dart';
import '../../repository/playlist_provider/videos_provider.dart';
import '../execute/test/AttemptTest.dart';
import '../execute/test/viewAnalysis.dart';

class mainScreen extends StatefulWidget {

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late var username = '';
  late List<Map>? listOfColumns;

  @override
  void initState() {
    // TODO: implement initState
    fetchPref();
    initProvider();
  }

  initProvider(){
    Future.microtask(() async => {
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
/*      await Provider.of<ReportClass>(context, listen: false)
          .getReportsAPI(),*/
    });
  }
  fetchPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username')!;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          /*appBar: AppBar(
            leading: InkWell(
              onTap: () => widget.zoomController.toggle(),
              child: Icon(Icons.menu),
            ),
          ),*/
          // backgroundColor: Constants.backgroundColor,
          body: Consumer<LeadershipClass>(builder: (context, myModel, child){
            // print(myModel.listData!.rank);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MenuWidget(),
                        // Text(username,style: GoogleFonts.poppins(color: Constants.black),),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Your Progress',
                          style: GoogleFonts.poppins(
                              color: Constants.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer<AssessmentWrappersClass>(builder: (context, aswModel, child){
                          return Container(
                            width: MediaQuery.of(context).size.width - 32,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Constants.blacklight,
                                child: Container(
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                CircularPercentIndicator(
                                                  radius: 70.0,
                                                  animation: true,
                                                  animationDuration: 2200,
                                                  lineWidth: 07.0,
                                                  percent: 0.4,
                                                  center: Text(
                                                    "${aswModel.listData.length}/${aswModel.allAswList.length}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12.0),
                                                  ),
                                                  circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                                  backgroundColor: Colors.white,
                                                  progressColor: Colors.blue,
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Tests Taken',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        color: Constants.black,
                                                        fontSize: 16),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                // Image.asset('assets/mastercard.png', width: 48.0)
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            /*Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              animation: true,
                                              animationDuration: 2200,
                                              lineWidth: 07.0,
                                              percent: 0.7,
                                              center: Text(
                                                "40/261",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.0),
                                              ),
                                              circularStrokeCap:
                                              CircularStrokeCap.butt,
                                              backgroundColor: Colors.white,
                                              progressColor: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Videos Watched',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.blacktext,
                                                    fontSize: 16),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        )*/
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Weak Categories
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weak categories',
                            style: GoogleFonts.poppins(
                                color: Constants.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Color(0xBCF4664A),
                                child: Container(
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Isomerism & IUPAC Nomenclature',
                                              style: GoogleFonts.poppins(
                                                  color: Constants.blacktext,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Organic Chemistry 1',
                                              style: GoogleFonts.poppins(
                                                  color: Constants.blacktext,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
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

                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Color(0xFFC0ECCF),
                                child: Container(
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Math for physics',
                                              style: GoogleFonts.poppins(
                                                  color: Constants.blacktext,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Mechanics 1',
                                              style: GoogleFonts.poppins(
                                                  color: Constants.blacktext,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
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

                          SizedBox(
                            height: 15,
                          ),

                          // Behaviour needed
                          Text(
                            'Behaviour needed',
                            style: GoogleFonts.poppins(
                                color: Constants.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Constants.blacklight,
                                child: Container(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(

                                              children: <Widget>[
                                                Image.asset('assets/images/logo.jpg',width: 100,),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Text('Intent',style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Constants.textcolor,
                                                    fontSize: 19),),
                                                Text(
                                                  'You need to attempt questions properly and spend more time in each question to improve your performance.'
                                                      'You have made too many bluffs in the assessment.'
                                                      'You haven\'t attempted many questions in the assessment.'
                                                      'You have finished the assessment too early.',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      color: Constants.blacktext,
                                                      fontSize: 16),
                                                  maxLines: 50,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                // Image.asset('assets/mastercard.png', width: 48.0)
                                              ],
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
                          SizedBox(
                            height: 15,
                          ),
                          // testDetails(),

                        ]),
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
    /*listOfColumns =  [{'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]},
    {'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]}];
    */
    /*listOfColumns = Provider.of<ReportClass>(context, listen: false).listOfColumns;
    print(listOfColumns);*/

    // final List<Map> listOfColumns = Provider.of<ReportClass>(context, listen: false).listOfColumns;

    return Consumer<ReportClass>(builder: (context, reportsModel, child){
      listOfColumns = reportsModel.listOfColumns;
      // print(listOfColumns);
      // print(reportsModel.allReportsList.first.user!.overall!.marks);
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(
                width: 1,
                color: Constants.grey
            ),
            columns:
            // List.generate(listOfColumns!.elementAt(0).length, (index) => DataColumn(label: Text(listOfColumns!.elementAt(0).keys.elementAt(index))),),


            [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Overall')),
              DataColumn(label: Text('physics	')),
              DataColumn(label: Text('chemistry	')),
              DataColumn(label: Text('mathematics	')),
            ],
            rows:
            listOfColumns! // Loops through dataColumnText, each iteration assigning the value to element
                .map(
              ((element) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(element["Name"]!)), //Extracting from Map element the value
                  DataCell(Text(element["Date"]!)),
                  DataCell(Text(element["overall"].elementAt(1).toString())),
                  DataCell(Text(element["physics"].elementAt(1).toString())),
                  DataCell(Text(element["chemistry"].elementAt(1).toString())),
                  DataCell(Text(element["mathematics"].elementAt(1).toString())),
                ],
              )),
            )
                .toList(),
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

                  bool assessment_attemp = false;
                  return Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                          Divider(color: Constants.grey,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Questions'),
                              Text('54'),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Duration'),
                              Text('3 hrs'),
                            ],
                          ),
                          Divider(color: Constants.grey,),

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
                                  AttemptTest() : viewAnalysis() );
                                  Navigator.of(context).push(route);
                                },
                                    child: Text(snapshot.data!)
                                );
                              } else {
                                return Text('Loading data');
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
        SizedBox(
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
                                color: Color(0xDFA5A4A4),
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
                                    SizedBox(
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
                                          child: Text('Buy Now'),
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


}
