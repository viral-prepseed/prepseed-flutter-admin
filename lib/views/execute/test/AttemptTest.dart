import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prepseed/helper/api/functions.dart';
import 'package:prepseed/helper/api/functions/execute.dart';
import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/model/list_questions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/strings.dart';
import 'package:http/http.dart' as http;

import '../../login/prepseed_loginScreen.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/src/ast/syntax_tree.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:flutter_tex/flutter_tex.dart';

class AttemptTest extends StatefulWidget {
  const AttemptTest({Key? key}) : super(key: key);

  @override
  _AttemptTestState createState() => _AttemptTestState();
}

class _AttemptTestState extends State<AttemptTest> with SingleTickerProviderStateMixin {
  TeXViewRenderingEngine? renderingEngine =  const TeXViewRenderingEngine.mathjax();
  TabController? _controller;
  var assessmentWrapperId;
  late var coreobjlist = [];
  late List sunintr = [];
  bool activeSession = false;
  Map<dynamic,List<SubInstructions>> maplist = {};
  Map<dynamic,dynamic> topic_subtopic = {};
  GlobalKey _stackkey = GlobalKey();
  bool isMarked = false;

  static var countdownDuration1 = Duration(minutes: 10);
  Duration duration1 = Duration();
  Timer? timer1;

  Duration calduration1 = Duration();
  Timer? caltimer1;
  var totalTimeTaken = 0;

  bool countDown1 = true;

  late List list_que_tab = [];
  late List list_questions = [];

  int activeStep = 1; // Initial step set to 5.
  int upperBound = 6;
  var tappedIndex = 0;
  late List visitedTappedIndex = [];
  var vcol;
  Questions? quedata;
  String question_content = '';
  List<String> listStr = [];
  List<String> mathListStr = [];
  String original_question_content = '';
  dynamic _value = -1;
  var errorCodeMsg = '';
  Map mapQueList = {};
  SyntaxTree? ast;


  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getQuestion();
    var hours1;
    var mints1;
    var secs1;
    hours1 = int.parse("03");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
    calduration1 = Duration(hours: int.parse('00'), minutes: int.parse('00'), seconds: int.parse('00'));
    startTimer1();
    reset1();
    getAssessment();




  }

  // https://napi.prepseed.com/assessment/60decca7f2b4680cba7e86ce

  calculateQue(corelist){

    for (var element in corelist) {
    var questionsObj = Sections.fromJson(element);

      if(questionsObj.questions!.isNotEmpty){
        list_que_tab.add(questionsObj.name);
        list_questions.add(questionsObj.questions);
      }else{
      }
    }
    
    setState(() {
      list_que_tab;
      list_questions;
      _controller = TabController(length: list_que_tab.toSet().toList().length, vsync: this,animationDuration: Duration.zero);
    });

    _controller!.addListener(() {
      setState(() {

        // tappedIndex = _controller!.index;
        tappedIndex = 0;
        _value = -1;
        _buildQuestions(list_questions.elementAt(_controller!.index), tappedIndex);
      });
  });
    _buildQuestions(list_questions.elementAt(0), tappedIndex);
        }

  getAssessment() async {
    var token = await sharedPref().getSharedPref('token');
    var assessmentWrapperId = await sharedPref().getSharedPref('assessmentWrapperId');
    var url = Strings.ASSESSMENT_BASE+'/'+assessmentWrapperId;
    print(assessmentWrapperId);
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // success
      var response = json.decode(res.body);
      var coreList = response["core"]['sections'];
      calculateQue(coreList);
      return coreList;
    } else if(res.statusCode == 404){
      print('404');
    } else if(res.statusCode == 500){
      print('server not responding');
    } else if(res.statusCode == 401){
      var newRoute = MaterialPageRoute(builder: (BuildContext context) => prepSeed_login());
      Navigator.of(context).pushReplacement(newRoute);
    } else{
      print(res.statusCode);
      print('Something went wrong');
    }
  }


  getCore(dynamic assessment) async {
    for(var eleinst in assessment['core']['instructions']){
      var coreobj = Instructions.fromJson(eleinst);

      // coreobj.instructions?.forEach((element) {
      maplist[coreobj.instruction] = (coreobj.subInstructions!.isNotEmpty)? ((coreobj.subInstructions!)) : [];
      coreobjlist.add(coreobj.instruction);
      // });

      // print(maplist);
      setState(() {
        maplist;
        coreobjlist;
      });
    }



    // var topicId = '5d641d2d2e8a7c5406d44465';

    // dynamic resdata = await functions().getObjectsById(topicId);
    // print(resdata);
    // resdata.forEach((element) {element.name;});

/*    coreobj.syllabus?.topics?.forEach((topics){
      topics.subTopics?.forEach((subtopics) {
        var subtopicId = subtopics.id;
        functions().getObjectsBySubId(subtopicId!).then((subids){
          for (var element in subids) {
            *//*print(element.name);
            print(element.tag);*//*
          }
        });
      });
    });

    coreobj.syllabus?.topics?.forEach((element) async {
      var topicId = element.id;
      functions().getObjectsById(topicId!).then((datas){
        // datas.forEach((element) { print(element.name); });
      });
      element.subTopics?.forEach((subtopics) {
        var subtopicId = subtopics.id;
        functions().getObjectsBySubId(subtopicId!).then((subids){
          for (var element in subids) {
            *//*print(element.name);
            print(element.tag);*//*
          }
        });
      });
      topic_subtopic[element.id] = (element.subTopics!.isNotEmpty)? ((element.subTopics!)) : [];
    });*/

    // showDialogBox();
    return coreobjlist;
  }

  getQuestion() async {
    var res = await executeFunc().assignment();
    var response = json.decode(res.body);
    if(response['success'] == false){
      setState(() {
        errorCodeMsg = response['error']['code'];
      });
      // Navigator.of(context).pop(errorCodeMsg);
      // print(response['error']['code']);
      return true;
    }
    else if (res.statusCode == 200) {
      // print(response);
      getCore(response);
      return response;
    } else if(res.statusCode == 404){
      print('404');
    } else if(res.statusCode == 500){
      print('server not responding');
    } else {
      print('Something went wrong');
    }
  }
  
/*  (){
    functions().getObjectsById(list, 'topicId');
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: (){
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: /*(!activeSession) ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (errorCodeMsg.isEmpty)? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(('Read all the instructions before begin the test')),
                          ElevatedButton(onPressed: (){showDialogBox();},child: Text('Instructions'))
                        ],
                ) : Container(child: Center(child: Text(errorCodeMsg)),),
                    ],
                ) :*/ setQuetions(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 60, width: double.infinity,
                /*color: Constants.blacklight.withOpacity(1),
                padding: EdgeInsets.only(top: 20, bottom: 20),
                margin: EdgeInsets.only(top:20),*/
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
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
                    Expanded(
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: (){
                          setState(() {
                            _value = -1;
                          });
                        },
                        child: Text("Reset", style: GoogleFonts.poppins(fontSize: 17,
                            color: Constants.backgroundColor.withOpacity(1),
                            fontWeight: FontWeight.bold,letterSpacing: 2),),
                        // colorBrightness: Brightness.dark,
                        color: Constants.grey.withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: (){
                          setState(() {
                          });
                        },
                        child: Text("Next", style: GoogleFonts.poppins(fontSize: 17,
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
          ),
        ],
      )
    );
  }

  setQuetions(){
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Wrap(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 05,
                ),
                IntrinsicHeight(
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Time Left",
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          // width: MediaQuery.of(cxontext).size.width/2,
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: buildTime1()
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
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: buildQuestionTabs()
                    ),

                  ],
                ),
              ]),
        ],
      ),
    );
  }
/*  showDialogBox(){
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

                                // print(values.runtimeType);
                                return Container(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(keys,style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: values.length,
                                          itemBuilder: (cntx,idx){
                                            var data = values.elementAt(idx).instruction;
                                            return Text(data??'', style: GoogleFonts.poppins(fontSize: 12,));
                                          }),
                                      const SizedBox(height: 5,)
                                    ],
                                  ),
                                ),);
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              activeSession = true;
                            });
                            Navigator.of(context).pop();
                          }, child: const Text('Begin Test')),
                        ),
                      ],
                    ),
                    Container(child: Text('smdfnjskfb'),),
                  ],
                ))
              ],
            ),
          )
        );
      });
    });
  }*/

  /*=========================================================================================*/
  buildQuestionTabs(){
    int _currentTimeValue = 1;
    return DefaultTabController(
      length: list_que_tab.length,
      child: Wrap(
        children: [
          TabBar(
            controller: _controller,
            indicatorColor: Constants.blue,
            labelColor: Constants.white.withOpacity(0.8),
            unselectedLabelColor: Constants.white.withOpacity(0.5),
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17),
            tabs: List.generate(list_que_tab.length, (index) =>
                Tab(text: list_que_tab[index],),
            ),
          ),
          Container(
            height: 1100,
            child: TabBarView(
              controller: _controller,
              children: List.generate(list_que_tab.length, (index) {
                List<Questions> queobjlist = list_questions.elementAt(index);
                mapQueList[index] = queobjlist.length;
                // print(mapQueList[1]);
                final List<Map> data = List.generate(queobjlist.length,
                        (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});
                // return Text(queobjlist.elementAt(0).correctMark.toString());
                 return Column(
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
                             color: (tappedIndex == index)
                             ? Colors.green
                                 : Colors.white,
                             elevation: 5,
                             child: ListTile(
                             contentPadding: const EdgeInsets.symmetric(
                             vertical: 0.0, horizontal: 0.0),
                             onTap: () {
                             Map postmap = {
                             "flow":[
                             {
                             "section": _controller!.index,
                             "question": tappedIndex,
                             "response": (_value > 0) ? quedata?.question?.options![_value].sId : null,
                             "time": totalTimeTaken,
                             "state": 1
                             }
                             ]
                             };
                             // functions().postFlowLogs(postmap);
                             print(postmap);
                             setState(() {
                             _value = -1;
                             (data[index]['isSelected'] == true )? data[index]['isSelected'] = false : data[index]['isSelected'] =  true;
                             tappedIndex = index;
                             vcol;
                             visitedTappedIndex.add(tappedIndex);
                             _buildQuestions(queobjlist, tappedIndex);
                             });
                             },
                             title: Align(
                             alignment: Alignment.topCenter,
                             child: Text(
                             (data[index]['id'] + 1).toString(),
                             style: GoogleFonts.poppins(fontSize: 11),
                           )),
                           ),
                           ),
                               (index == tappedIndex)? const Positioned(
                                 child: Icon(Icons.remove_red_eye_outlined, size: 12,),
                                 right: 0,
                                 top: -26,
                                 bottom: 0,
                               ) : Container()
                             ],
                           ); },

                         ),
                       ),
                     ),
                     Divider(color: Constants.grey,thickness: 1.0,),

                     Padding(
                       padding: const EdgeInsets.only(left: 10, right: 10),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(child: Text('${list_que_tab[_controller!.index]} > ${(quedata?.question!.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT')? 'Single Correct' :
                           (quedata?.question!.type == 'RANGE')? 'Numeric' : '---' // (quedata?.question!.type == 'SINGLE_CORRECT')? 'Single Correct' :
                           }'),),
                           Row(
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
                           ),
                         ],
                       ),
                     ),

                     Divider(color: Constants.grey,thickness: 1.0,),

                     if(question_content.isNotEmpty)
                     Column(
                       children: [
                         Container(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: (quedata?.question!.dataType == 'text')? (original_question_content.contains('\$')) ?
                                 ListView.builder(
                                     itemBuilder: (cntx,indexx){
                                       var alllist = listStr.elementAt(indexx);
                                       for(var convtext in mathListStr){
                                         // if(convtext.contains(alllist)){
                                           var trimdata = convtext.substring(1,convtext.length-1);
                                           return Column(
                                             children: [
                                               (alllist.contains(convtext.substring(1,convtext.length-1)))?
                                               // KaTeX(laTeXCode: Text(convtext.substring(1,convtext.length-1)))
                                               Math.tex(convtext.substring(1,convtext.length-1),
                                                 textStyle: GoogleFonts.poppins(fontSize: 14,),
                                               ) : Text(alllist,)
                                             ],
                                           );
                                       }
                                       return Container();
                                 },
                                 shrinkWrap: true,
                                 itemCount: listStr.length,) : ((original_question_content.contains('''text{'''))) ? SelectableMath.tex(question_content,
                             textStyle: GoogleFonts.poppins(fontSize: 14,),
                             )
                                 : (question_content.contains('s3.ap-south-1.amazonaws.com'))?
                             Image(
                               key: UniqueKey(),
                               fit: BoxFit.contain,
                               height: 200,
                               width: double.infinity,
                               image: NetworkImage(question_content),
                             )
                                 : Text(question_content,style: GoogleFonts.poppins(fontSize: 12),)
                                 : Image(
                                   key: UniqueKey(),
                                   fit: BoxFit.contain,
                                   height: 200,
                                   width: double.infinity,
                                   image: NetworkImage(question_content),
                             ),
                           )
                         ),
                         (quedata?.question!.type == 'RANGE')? const Padding(
                           padding: EdgeInsets.all(8.0),
                           child: TextField (
                              decoration: InputDecoration(
                              // border: InputBorder.none,
                              labelText: 'Your Answer',
                              ),
                              ),
                         ) :
                         (quedata?.question!.type == 'IMAGE')? Column(
                           children: <Widget>[
                             for (int i = 1; i < 5; i++)
                               RadioListTile(
                                 groupValue: _value,
                                 title: Text((i == 1)?'A':(i == 2)?'B':(i == 3)?'C':(i == 4)?'D':'',
                                   // style: Theme.of(context).textTheme.subtitle1?.copyWith(color: i == 5 ? Colors.black38 : Colors.black),
                                 ),
                                 onChanged: i == 5 ? null : (value) {
                                   setState(() {
                                     _value = value;
                                   });
                                 },
                                 value: i,
                               ),
                           ],
                         ) :
                         (quedata?.question!.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT')?
                         (quedata?.question!.dataType == 'image' || question_content.contains('s3.ap-south-1.amazonaws.com') )? Column(
                           children: <Widget>[
                             for (int i = 1; i < 5; i++)
                               RadioListTile(
                                 groupValue: _value,
                                 title: Text((i == 1)?'A':(i == 2)?'B':(i == 3)?'C':(i == 4)?'D':'',
                                   // style: Theme.of(context).textTheme.subtitle1?.copyWith(color: i == 5 ? Colors.black38 : Colors.black),
                                 ),
                                 onChanged: i == 5 ? null : (value) {
                                   setState(() {
                                     _value = value;
                                   });
                                 },
                                 value: i,
                               ),
                           ],
                         )  :
                         ListView.builder(
                             itemBuilder: (ctx, idx){
                               var convertstr;
                               var opetions = '';
                               var optionImage = '';
                               var optionText = '';
                               if(quedata?.question?.options![idx].content?.rawContent.runtimeType == String){
                                  convertstr = json.decode(quedata?.question?.options![idx].content?.rawContent);
                               }
                               else{
                                 convertstr = (quedata?.question?.options![idx].content?.rawContent);
                               }
                               // print(convertstr['entityMap']['0']['data']['url']);
                               opetions = convertstr['blocks'][0]['text'];
                               if(opetions == ''){
                                 optionImage = convertstr['entityMap']['0']['data']['url'] ?? '';
                               }
                               if(opetions == '' && optionImage == ''){
                                 optionText = convertstr['entityMap']['0']['data']['content'] ?? '';
                                 // print(optionText);
                               }
                               // print(convertstr['entityMap'].runtimeType);
                               /*if(convertstr['entityMap']!=null) {
                                 print('empty');
                               }else{
                                 opetionsimage = convertstr['entityMap']['0']['data']['url'];
                               }*/


                               return RadioListTile(
                                 value: idx,
                                 groupValue: _value,
                                 onChanged: (ind) => setState(() => _value = ind),
                                 title: (opetions != '')? Math.tex(opetions.replaceAll("\$", '')) : (optionImage != '' ) ?
                                 Image(image: NetworkImage(optionImage),
                                   height: 140,
                                   fit: BoxFit.fill,)  : (optionText != '' ) ? Math.tex(optionText.replaceAll("\$", '')) : Text('') ,
                               );

                               /*return RadioListTile(
                                 value: idx,
                                 groupValue: _value,
                                 onChanged: (ind) => setState(() => _value = ind),
                                 title: (opetions != '')? Text(opetions) : (optionImage != '' ) ?
                                 Image(image: NetworkImage(optionImage),
                                   height: 140,
                                   fit: BoxFit.fill,)  : (optionText != '' ) ? Text(optionText) : Text('') ,
                               );*/
                         },
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                         itemCount: quedata?.question?.options!.length,)
                             :
                         Container()
                       ],
                     ),


                   ],
                 );
                  })
            ),
          )
        ],
      ),
    );
  }
/*=========================================================================================*/


  _buildQuestions(queobjlist, tappedIndex){
    setState(() {
      listStr = [];
      mathListStr = [];
    });
    quedata = queobjlist.elementAt(tappedIndex);
    var dummyopetions = quedata?.question?.content?.rawContent;
    Map resjson ;

    if(dummyopetions.runtimeType == String)
      {
        resjson = json.decode(dummyopetions!);
      }else{
      resjson = (dummyopetions!);
    }

    // Map resjsonoptions = json.decode(quedata?.question?.options![0].content?.rawContent);
    List<dynamic> listelezero = resjson.values.elementAt(0);
    Map mapelezero = listelezero[0];
    // print(resjson.values);
    // Map mapeleone = (resjson.values.elementAt(1));

    // print(mapelezero['text']);
    if(quedata?.question!.dataType == 'image'){
      var dataimg = resjson['entityMap']['0']['data']['url'];
      // print(dataimg);
      // print(map.values.elementAt(0)['data']['url']);
      // print(quedata?.question?.type.toString());
      question_content = dataimg.toString();
    }else if(quedata?.question!.dataType == 'text'){
      // var globContent;
      var datatext;
      datatext = mapelezero['text'] ?? '';
      // globContent =  datatext;
      if(datatext == ''){
        datatext = (resjson['entityMap']['0']['data']['content'] ?? '');
        // globContent =  dataimgcontent;
      }if(datatext == ''){
        datatext = (resjson['entityMap']['0']['data']['url'] ?? '');
        // globContent =  datatext;
      }

      // print(map.values.elementAt(0)['data']['url']);
      // print(quedata?.question?.type.toString());
      question_content = datatext.toString();
    }
    // print(question_content);
    calQueTime();

/*    try {
      ast = SyntaxTree(greenRoot: TexParser(question_content, TexParserSettings()).parse());
    } on ParseException catch (e) {
      print(e);
    }*/

    const removeChar = "\$";

    RegExp exp = new RegExp(r'\$(.*?)\$');
    Iterable<RegExpMatch> matches = exp.allMatches(question_content);

    matches.forEach((match) {
      mathListStr.add(question_content.substring(match.start, match.end));
      // print(question_content.substring(match.start, match.end));
    });

    listStr = question_content.split(removeChar);
    listStr.removeWhere((element) => element.isEmpty);
    mathListStr.removeWhere((element) => element.isEmpty);

    setState(() {
      print(listStr);
      print(mathListStr);
      listStr;
      mathListStr;
      original_question_content = question_content;
      question_content;
      // question_content = question_content.replaceAll("\$", '');
    });
    // return Text(temp!);
  }

/*=========================================================================================*/
  Future<bool> _onWillPop() async {
    timer1!.cancel();
    caltimer1!.cancel();
    /*final isRunning = timer1 == null ? false : timer1!.isActive;
    if (isRunning) {
      timer1!.cancel();
    }*/
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }
  void reset1() {
    if (countDown1) {
      setState(() => duration1 = countdownDuration1);
    } else {
      setState(() => duration1 = Duration());
    }
  }

  void resetQueTime() {
      setState(() => calduration1 = Duration(hours: int.parse('00'), minutes: int.parse('00'), seconds: int.parse('00')));
  }
  void startTimer1() {
    timer1 = Timer.periodic(Duration(seconds: 1), (_) => addTime1());
  }

  void calQueTime() {
    print(totalTimeTaken);
    resetQueTime();
    caltimer1 = Timer.periodic(Duration(seconds: 1), (_) => addcalQueTime());
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

  void addcalQueTime() {
    final addSeconds = 1;
    if (mounted) {
      setState(() {
        final seconds = calduration1.inSeconds + addSeconds;
        if (seconds < 0) {
          caltimer1?.cancel();
        } else {
          calduration1 = Duration(seconds: seconds);
          seconds;
          totalTimeTaken = calduration1.inMilliseconds;
          /*print(seconds);
          print(calduration1.inMilliseconds);*/
        }
      });
    }
  }


  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constants.grey)
      ),
      child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

        buildTimeCard(time: hours, header: 'HOURS'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.black),),
        // Spacer(),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.black),),
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
                      color: Colors.black,
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
/*=========================================================================================*/
  
  
}



