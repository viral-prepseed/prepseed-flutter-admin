import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepseed/model/execute/tests/list_questions.dart';
import 'package:prepseed/model/questions.dart';

import '../../../constants/colorPalate.dart';

import 'package:provider/provider.dart';
import '../../../helper/api/functions.dart';
import '../../../helper/provider/testsProvider.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:google_fonts/google_fonts.dart';

class attempt_practice extends StatefulWidget {
  const attempt_practice({Key? key}) : super(key: key);

  @override
  _attempt_practiceState createState() => _attempt_practiceState();
}

class _attempt_practiceState extends State<attempt_practice> with SingleTickerProviderStateMixin {

  List _store = [];
  Duration duration1 = Duration();
  Timer? timer1;
  TabController? _controller;
  static var countdownDuration1 = Duration(minutes: 10);

  Duration calduration1 = Duration();
  Timer? caltimer1;
  var totalTimeTaken = 0;
  dynamic _value = 1;

  bool isMarked = false;
  var nextPrev = "Next";

  late List list_que_tab = [];
  var setQID = 0;
  List tabValues = [];
  List topicQue = [];
  List<QuestionClass> questions = [];
  Map listTopics = {};
  late List<Map> data;
  DateTime? clickNow;
  DateTime? clickPrev;

  @override
  void initState() {
    clickPrev = DateTime.now();
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
    calduration1 = Duration(hours: int.parse('00'), minutes: int.parse('00'), seconds: int.parse('00'));
    var hours1;
    var mints1;
    var secs1;
    hours1 = int.parse("03");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    setQID = _controller!.index;
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
    // startTimer1();
    reset1();
    _controller!.addListener(() {
      questions = listTopics.values.elementAt(_controller!.index);
      setState(() {
        questions;
        setQID = 0;
        // print(questions.elementAt(_controller!.index).text);
      });
    });
/*    questions.forEach((element) {
      (element.options!.forEach((element) {
        print(element.text);
      }));
    });*/

    // print(listTopics.values.elementAt(0));
  }

  timeBetweenTaps(){
    clickNow = DateTime.now();
    if(clickPrev != null){
      var diff = clickPrev!.difference(clickNow!);
      // print();
      clickPrev = clickNow;
      return diff.inMilliseconds;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            actionWidgets(),
            buildTopicTabs(),
            bottomActionWidget()
            // selectQueList(),
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

  /*==================================================== List Questions ============================================================*/
  Widget selectQueList(){
    calQueTime();
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
/*                            Map postmap = {
                              "flow":[
                                {
                                  "section": _controller!.index,
                                  "question": setQID,
                                  "response": (_value > 0) ? questions[_value].options.elementAt(_value).id : null,
                                  "time": timeBetweenTaps(),
                                  "state": 1
                                }
                              ]
                            };*/

                            // functions().postFlowLogs(postmap);
                            // print(postmap);
                            // timeBetweenTaps();
                            setState(() {
                              setQID = data[index]['id'];
                              // print(questions.length);
                            });
                            _store.add(setQID);
                            print(_store);
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
          questionWidget(queId: questions.elementAt(setQID)),
        ],
      ),
    );
  }

  void resetQueTime() {
    setState(() {
      calduration1 = Duration(hours: int.parse('00'), minutes: int.parse('00'), seconds: int.parse('00'));
    });
  }

  void calQueTime() {
    // print(totalTimeTaken);
    resetQueTime();
    caltimer1 = Timer.periodic(Duration(seconds: 1), (_) => addCalQueTime());
  }

  void addCalQueTime() {

    final addSeconds = 1;
    if (mounted) {
      setState(() {
        // totalTimeTaken = 0;
        final seconds = calduration1.inMinutes + addSeconds;
        if (seconds < 0) {
          caltimer1?.cancel();
        } else {
          calduration1 = Duration(seconds: seconds);
          seconds;
          totalTimeTaken = calduration1.inMinutes;
          /*print(seconds);
          print(calduration1.inMilliseconds);*/
        }
      });
    }
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

  String optionVal = '';
  
  
@override
  Widget build(BuildContext context) {

  QuestionClass question = widget.queId;
  String s = (question.text);
    // print(s);

  var selectedIndexes = Provider.of<TestProviderClass>(context, listen: false).selectedIndex;
/*  if(question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
      question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT'){
    Provider.of<TestProviderClass>(context,listen: false).isReset = true;
  }else{
    Provider.of<TestProviderClass>(context,listen: false).isReset = false;
  }*/
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(question.type, style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500),),
          const SizedBox(height: 10,),
          linked_ques(question),
          (s.toString() != '') ?
          TeXView(
          child: TeXViewColumn(children: [
            _teXViewWidget((s.toString())),
            // TeXViewDocument(s ?? '', style: TeXViewStyle.fromCSS('padding: 15px; color: white; background: green'))
          ]),
        style: const TeXViewStyle(
          elevation: 10,
          borderRadius: TeXViewBorderRadius.all(25),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              // borderColor: Colors.blue,
              // borderStyle: TeXViewBorderStyle.solid,
              borderWidth: 5)),
          backgroundColor: Colors.white,
        ),
      ) : Container(),

          // Text(question.text, style: GoogleFonts.poppins(fontSize: 13),),
          (question.queImage != '')?
          Image(image: NetworkImage(question.queImage),
            // height: 190,
            fit: BoxFit.contain,) :
          Container(),
          (question.type == 'MULTIPLE_CHOICE_MULTIPLE_CORRECT' ||
              question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT" ) ?
          Column(
            children: List.generate(question.options.length, (index) {
              return CheckboxListTile(
                title:
                TeXView(
                  child: TeXViewColumn(children: [
                    _teXViewWidget((question.options.elementAt(index).text.toString()) ?? ''),
                  ]),
                ),
                // Text(question.options.elementAt(index).text.toString()),
                // subtitle: Text(this.noteList[position].actn_on),
                value: selectedIndexes.contains(question.options.elementAt(index).id),
                onChanged: (_) {
                  if (selectedIndexes.contains(question.options.elementAt(index).id)) {
                    selectedIndexes.remove(question.options.elementAt(index).id);   // unselect
                  } else {
                    selectedIndexes.add(question.options.elementAt(index).id);  // select
                  }
                  // print(selectedIndexes);
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
          ):
          (question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
              question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT') ?
          Column(
            children: List.generate(question.options.length, (index) {
              return RadioListTile(
                title: TeXView(
                  child: TeXViewColumn(children: [
                    _teXViewWidget((question.options.elementAt(index).text.toString()) ?? ''),
                    ]),
                ),
                // Text(question.options.elementAt(index).text.toString()),
                  value: question.options.elementAt(index).text.toString(),
                  groupValue: Provider.of<TestProviderClass>(context, listen: false).optionVal,
                  onChanged: (value){
                    setState(() {
                      Provider.of<TestProviderClass>(context, listen: false).optionVal = value.toString();
                    });
                  });
            }),
          ) : (question.type == 'RANGE') ?
          TextField(
            controller: Provider.of<TestProviderClass>(context,listen: false).textController,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r"(\-)?\d+\.?\d{0,30}"), allow: true),
            ],
            decoration: const InputDecoration(labelText: "Your Answer"),
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

  static TeXViewWidget _teXViewWidget( String body) {
    return TeXViewColumn(
        style: const TeXViewStyle(
            margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.groove,
                borderColor: Colors.green))),
        children: [/*
          TeXViewDocument(title,
              style: const TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  // textAlign: TeXViewTextAlign.center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Colors.green)),*/
          TeXViewDocument(body,
              style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
        ]);
  }


  linked_ques(QuestionClass question){
    LinkQuestions _linkQue;

    if(question.linkedText != null && question.type == "LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT"||
        question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT"){
      _linkQue = question.linkedText;
      var rawCont = _linkQue.content!.rawContent!;
      if(rawCont.runtimeType.toString() == "String"){
        rawCont = json.decode(_linkQue.content!.rawContent!);
      }
      // var _linkText = QuestionContents.fromJson(rawCont).blocks!.first.text ?? '';
      List<String> _linkList = [];
      String _linkText;
      String _linkImage;
      for(var blockString in QuestionContents.fromJson(rawCont).blocks!){
        _linkList.add(functions().convertLetX(blockString.text.toString()));
      }

      _linkText = _linkList.join('\n');
      _linkImage = QuestionContents.fromJson(rawCont).entityMap;


    return Column(
        children: [
          ExpansionTile(title: Flexible(child: Text(_linkText,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.poppins(),)),
            children: [TeXView(
              child: TeXViewColumn(children: [
                _teXViewWidget((_linkText)),
              ]),
            ),],

          ),
/*          TeXView(
            child: TeXViewColumn(children: [
              _teXViewWidget((_linkText)),
            ]),
          ),*/
          // Text(convertLetX(_linkText), style: GoogleFonts.poppins(fontSize: 13),),
          const SizedBox(height: 10,)
        ],
      );
    }
    return Container();
  }

}