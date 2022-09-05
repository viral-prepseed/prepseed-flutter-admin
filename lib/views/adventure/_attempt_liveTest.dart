import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prepseed/views/adventure/widgets/build_queAns.dart';
import 'package:prepseed/views/adventure/widgets/header.dart';

import '../../constants/colorPalate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/provider/testsProvider.dart';
import '../../model/execute/tests/list_questions.dart';
import '../../model/questions.dart';


class attempt_liveTestt extends StatefulWidget {
  const attempt_liveTestt({Key? key}) : super(key: key);

  @override
  State<attempt_liveTestt> createState() => _attempt_liveTesttState();
}

class _attempt_liveTesttState extends State<attempt_liveTestt> with SingleTickerProviderStateMixin {

  Duration duration1 = Duration();
  var hours1;
  var mints1;
  var secs1;
  Timer? timer1;
  static var countdownDuration1 = Duration(minutes: 10);
  TabController? _controller;
  List tabValues = [];

  late List<Map> data;
  List topicQue = [];
  var setQID = 0;
  List<QuestionClass> questions = [];
  Map listTopics = {};
  Map sectionListAnswer = {};
  dynamic _value = 1;
  var prevTabValue = 0;

  bool isMarked = false;
  var nextPrev = "Next";
  @override
  void initState() {


    // setQID = Provider.of<TestProviderClass>(context,listen: false).setQID;
    hours1 = int.parse("03");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
    list_questions lq = Provider.of<TestProviderClass>(context, listen: false).assessment;
    lq.core!.sections!.forEach((element) {
      tabValues.add(element.name);
      topicQue.add(element.questions?.length);
    });

    listTopics = Provider.of<TestProviderClass>(context, listen: false).listTopics;
    questions = listTopics.values.elementAt(0);
    _controller = TabController(length: tabValues.length, vsync: this,animationDuration: Duration.zero);
    _controller!.addListener(() {
      if(Provider.of<TestProviderClass>(context, listen: false).selectedRadioValues.isNotEmpty){
        sectionListAnswer[prevTabValue] = (Provider.of<TestProviderClass>(context, listen: false).selectedRadioValues);
      }
        print(sectionListAnswer);
      prevTabValue = _controller!.index;
      questions = listTopics.values.elementAt(_controller!.index);
      setState(() {
        questions;
        setQID = 0;
        // print(questions.elementAt(_controller!.index).text);
      });
    });
    /*    reset1();
    startTimer1();*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(),
            // actionWidgets(),
            buildTopicTabs(),
            bottomActionWidget()
          ],
        ),
      ),
    );
  }


  /*==================================================== bottomActionWidget  ============================================================*/
  bottomActionWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 40, width: double.infinity,
          /*color: Constants.blacklight.withOpacity(1),
                padding: EdgeInsets.only(top: 20, bottom: 20),
                margin: EdgeInsets.only(top:20),*/
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /*Expanded(
                child: RaisedButton(
                  elevation: 0,
                  onPressed: (){
                    setState(() {
                      isMarked = !false;
                      // _stackkey.currentState.
                    });
                  },
                  child: Text("Mark", style: GoogleFonts.poppins(fontSize: 17,
                      color: Constants.backgroundColor.withOpacity(1),
                      fontWeight: FontWeight.bold,letterSpacing: 2),),
                  // colorBrightness: Brightness.dark,
                  color: Constants.grey.withOpacity(1),
                ),
                ),
              ),*/
              (Provider.of<TestProviderClass>(context,listen: false).isReset == true) ?
              Expanded(
                child: RaisedButton(
                  elevation: 0,
                  onPressed: (){
                    setState(() {
                      _value = -1;
                      Provider.of<TestProviderClass>(context,listen: false).selectedRadioValues[setQID] = '';
                      Provider.of<TestProviderClass>(context,listen: false).textController.clear();
                      // Provider.of<TestProviderClass>(context,listen: false).selectedIndex.remove(value)
                      Provider.of<TestProviderClass>(context, listen: false).optionVal = '';
                    });
                  },
                  child: Text("Reset", style: GoogleFonts.poppins(fontSize: 15,
                      color: Constants.backgroundColor.withOpacity(1),
                      fontWeight: FontWeight.bold,letterSpacing: 2),),
                  // colorBrightness: Brightness.dark,
                  color: Constants.grey.withOpacity(1),
                ),
              )
                  : Container(),
              Expanded(
                child: RaisedButton(
                  elevation: 0,
                  onPressed: (){
                    setState(() {
                      /*Provider.of<TestProviderClass>(context,listen: false).selectedRadioValues[setQID] =
                      Provider.of<TestProviderClass>(context,listen: false).selectedIndex;*/
                      Provider.of<TestProviderClass>(context,listen: false).selectedIndex.clear();
                      if(setQID+1 < data.length){
                        nextPrev = "Next";
                        setQID = setQID + 1;
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("You have reached end of the questions."),
                        ));
                        /*nextPrev = "Prev";
                        setQID = setQID - 1;*/
                      }
                    });
                  },
                  child: Text(nextPrev, style: GoogleFonts.poppins(fontSize: 15,
                      color: Constants.backgroundColor.withOpacity(1),
                      fontWeight: FontWeight.bold,letterSpacing: 2),),
                  // colorBrightness: Brightness.dark,
                  color: Constants.grey.withOpacity(1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*==================================================== buildTopicTabs  ============================================================*/
  buildTopicTabs(){
    return Expanded(
      // height: 70,
      child: DefaultTabController(
        length: tabValues.length,
        child: Column(
          children: [
            TabBar(
              onTap: (index){
                // topicQue.elementAt(_controller!.index);
              },
              controller: _controller,
              indicatorColor: Constants.blue,
              labelColor: Constants.white.withOpacity(0.8),
              unselectedLabelColor: Constants.white.withOpacity(0.5),
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
              tabs: List.generate(tabValues.length, (index) => Text(tabValues[index])),
            ),
            Expanded(child: TabBarView(
              controller: _controller,
              children: List.generate(tabValues.length, (index) => selectQueList(),
              ),
            ),)
          ],
        ),
      ),
    );
  }

  Widget selectQueList(){
    // calQueTime();
    data = List.generate(topicQue.elementAt(_controller!.index),
            (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // width: double.maxFinite,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 780,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 50,
                    mainAxisSpacing: 10
                ),
                // physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index)
                {
                  // isMarked = false;
                  return Stack(
                    // key: _stackkey,
                    children: [
                      Card(
                        key: ValueKey(data[index]['name']),
                        color: (setQID == index)
                            ? Colors.green : Colors.white,
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          onTap: () {

                            // print(data[index]['id'] + 1);
  /*                          Map postmap = {
                              "flow":[
                                {
                                  "section": _controller!.index,
                                  "question": setQID,
                                  "response": (_value > 0) ? questions[_value].options.elementAt(_value).id : null,
                                  "time": timeBetweenTaps(),
                                  "state": 1
                                }
                              ]
                            };
                            _save(postmap);
                            _read();
                            // functions().postFlowLogs(postmap);
                            print(postmap);*/
                            // timeBetweenTaps();
                            setState(() {
                              if(questions[setQID].type == "RANGE"){
                                Provider.of<TestProviderClass>(context, listen: false).selectedRadioValues[setQID] =
                                    Provider.of<TestProviderClass>(context,listen: false).textController.text;
                              }
                              print(setQID);
                              print(Provider.of<TestProviderClass>(context,listen: false).textController.text);
                              setQID = data[index]['id'];
                              Provider.of<TestProviderClass>(context, listen: false).selectedIndexes = [];
                              print(Provider.of<TestProviderClass>(context, listen: false).selectedRadioValues);
                              // print(questions.length);
                            });
                            /*_store.add(setQID);
                            print(_store);*/
                          },
                          title: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                (_controller!.index != 0)?
                                calLength((data[index]['id'] + 1))
                                    : (data[index]['id'] + 1).toString(),
                                style: GoogleFonts.poppins(fontSize: 11),
                              )),
                        ),
                      ),
                      /*(index == setQID)? const Positioned(
                        child: Icon(Icons.remove_red_eye_outlined, size: 12,),
                        right: 0,
                        top: -26,
                        bottom: 0,
                      ) : Container()*/
                    ],
                  ); },

              ),
            ),
          ),
          questionWidget(queId: questions.elementAt(setQID),selectedQID: setQID),
        ],
      ),
    );
  }

  calLength(dataIndex){
    num addLength = 0;
    int i = _controller!.index;
    for(i=_controller!.index - 1; i>=0; i--){
      var _queLength = topicQue.elementAt(i);
      // print(_queLength.runtimeType);
      (addLength != 0)?addLength = addLength + _queLength :
      addLength = topicQue.elementAt(i);
    }
    return (addLength + dataIndex).toString();
  }

/*===================================================================*/

  Widget actionWidgets(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              "Time Left",
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Constants.grey),
            ),
            Container(
              // width: MediaQuery.of(cxontext).size.width/2,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: buildTime1()
            ),
          ],
        ),
        VerticalDivider(color: Constants.grey,),


        ElevatedButton(
          onPressed: (){
            print('Finish');
          },
          child: Text('Finish Test'),
        )
      ],
    );
  }


  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Constants.grey)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.grey),),
        // Spacer(),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.grey),),
        // Spacer(),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ]),
    );
  }
  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Constants.grey,
                      fontSize: 15),
                ),

              ],
            ),
          ),
/*          SizedBox(
            height: 24,
          ),
          Text(header, style: GoogleFonts.poppins(color: Colors.black45)),*/
        ],
      );
  void startTimer1() {
    timer1 = Timer.periodic(Duration(seconds: 1), (_) => addTime1());
  }
  void reset1() {
    setState(() => duration1 = countdownDuration1);
  }
  void addTime1() {

    final addSeconds = 1;
    if (mounted) {
      setState(() {
        final seconds = duration1.inSeconds - addSeconds;
        if (seconds < 0) {
          timer1?.cancel();
        } else {
          duration1 = Duration(seconds: seconds);
          // print(duration1);
        }
      });
    }
  }
}
