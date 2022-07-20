import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prepseed/helper/api/functions.dart';
import 'package:prepseed/model/execute/tests/list_questions.dart';
import 'package:prepseed/model/questions.dart';

import '../../constants/colorPalate.dart';

import 'package:provider/provider.dart';
import '../../helper/provider/testsProvider.dart';
import '../menu/menu_widget.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';

class attempt_liveTest extends StatefulWidget {
  const attempt_liveTest({Key? key}) : super(key: key);

  @override
  _attempt_liveTestState createState() => _attempt_liveTestState();
}

class _attempt_liveTestState extends State<attempt_liveTest> with SingleTickerProviderStateMixin {


  Duration duration1 = Duration();
  Timer? timer1;
  TabController? _controller;
  static var countdownDuration1 = Duration(minutes: 10);

  late List list_que_tab = [];
  var setQID = 0;
  List tabValues = [];
  List topicQue = [];
  List<QuestionClass> questions = [];
  Map listTopics = {};

  @override
  void initState() {
    listTopics = Provider.of<TestProviderClass>(context, listen: false).listTopics;
    // questions = Provider.of<TestProviderClass>(context, listen: false).questionsList;
    questions = listTopics.values.elementAt(0);
    list_questions lq = Provider.of<TestProviderClass>(context, listen: false).assessment;
    lq.core!.sections!.forEach((element) {
      tabValues.add(element.name);
      topicQue.add(element.questions?.length);
    });
    startTimer1();
    _controller = TabController(length: tabValues.length, vsync: this,animationDuration: Duration.zero);
    var hours1;
    var mints1;
    var secs1;
    hours1 = int.parse("03");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    setQID = _controller!.index;
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
    reset1();
    _controller!.addListener(() {
      questions = listTopics.values.elementAt(_controller!.index);
      setState(() {
        questions;
        setQID = 0;
        print(questions.elementAt(_controller!.index).text);
      });
    });
/*    questions.forEach((element) {
      (element.options!.forEach((element) {
        print(element.text);
      }));
    });*/

    // print(listTopics.values.elementAt(0));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            actionWidgets(),
            buildTopicTabs(),
            // selectQueList(),
          ],
        ),
      ),
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
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17),
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

  /*==================================================== List Questions ============================================================*/
  Widget selectQueList(){
    final List<Map> data = List.generate(topicQue.elementAt(_controller!.index),
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
                            ? Colors.green
                            : Colors.white,
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          onTap: () {

                            // print(data[index]['id'] + 1);
                            /*Map postmap = {
                              "flow":[
                                {
                                  "section": _controller!.index,
                                  "question": tappedIndex,
                                  "response": (_value > 0) ? quedata?.question?.options![_value].sId : null,
                                  "time": totalTimeTaken,
                                  "state": 1
                                }
                              ]
                            };*/
                            // functions().postFlowLogs(postmap);
                            // print(postmap);
                            setState(() {
                              setQID = data[index]['id'];
                              // print(questions.length);
                            });
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
                      /*(index == tappedIndex)? const Positioned(
                        child: Icon(Icons.remove_red_eye_outlined, size: 12,),
                        right: 0,
                        top: -26,
                        bottom: 0,
                      ) :*/

                    ],
                  ); },

              ),
            ),
          ),
          questionWidget(queId: questions.elementAt(setQID)),
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

  /*==================================================== Header ============================================================*/
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
        /*Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Constants.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('+ ${quedata?.correctMark!.toString()}.00',style: GoogleFonts.poppins(color: Colors.green),),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Constants.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${quedata?.incorrectMark!.toString()}.00', style: GoogleFonts.poppins(color: Colors.redAccent),),
                              ),
                            ),
                          ],
                        ),*/

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

/*==================================================== Questions ============================================================*/


class questionWidget extends StatefulWidget {
  final dynamic queId;
  const questionWidget({Key? key, required this.queId}) : super(key: key);

  @override
  _questionWidgetState createState() => _questionWidgetState();
}

class _questionWidgetState extends State<questionWidget> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    return buildQuestion(widget.queId);
  }
}

linked_ques(QuestionClass question){
  LinkQuestions _linkQue;

  if(question.linkedText != null && question.type == "LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT"){
    _linkQue = question.linkedText;
    var rawCont = _linkQue.content!.rawContent!;
    if(rawCont.runtimeType.toString() == "String"){
      rawCont = json.decode(_linkQue.content!.rawContent!);
    }
    var _linkText = QuestionContents.fromJson(rawCont).blocks!.first.text ?? '';

  return Column(
    children: [
      Text(_linkText, style: GoogleFonts.poppins(fontSize: 13),),
      SizedBox(height: 10,)
    ],
  );
  }
  return Container();
}

buildQuestion(QuestionClass question){
  // var quesText = question.text.replaceAll('\$', '');
  // print(question.type);
  Map<String, dynamic> linkNum= {
    'A' : 1,
    'B' : 2,
    'C' : 3,
    'D' : 4,
    "E" : 5,
    "/" : " ",
  };
  String? optionVal;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(question.type, style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        linked_ques(question),
        Text(question.text, style: GoogleFonts.poppins(fontSize: 13),),
        (question.queImage != '')?
            Image(image: NetworkImage(question.queImage)) :
        Container(),


        (question.type == 'MULTIPLE_CHOICE_MULTIPLE_CORRECT') ?
        Column(
          children: List.generate(question.options.length, (index) {
            return ListTile(
              leading: Radio(
                  value: "123",
                  groupValue: optionVal,
                  onChanged: (value){
                    /*setState(() {
                      gender = value.toString();
                    });*/
                  }),
              title: Text(question.options.elementAt(index).text),
            );
          }),
        ):
        (question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
            question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT'
        ) ?
        Column(
          children: List.generate(question.options.length, (index) {
            return ListTile(
              title: Text((question.options.elementAt(index).text != 'ABC')?
              question.options.elementAt(index).text : '${linkNum.values.where((element) => element == index)}'),
              leading: Radio(
                  value: "123",
                  groupValue: optionVal,
                  onChanged: (value){
                    /*setState(() {
                      gender = value.toString();
                    });*/
                  }),
            );
          }),
        )
        : (question.type == 'RANGE') ?
        const TextField(
          decoration: InputDecoration(labelText: "Your Answer"),
          keyboardType: TextInputType.number,
        ) : Column(
          children: List.generate(question.options.length, (index) {
            return ListTile(
              title: Text(question.options.elementAt(index).text),
            );
          }),
        )
      ],
    ),
  );
}