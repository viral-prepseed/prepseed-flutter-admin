import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/colorPalate.dart';
import '../menu/menu_widget.dart';
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

  @override
  void initState() {
    startTimer1();
    _controller = TabController(length: list_que_tab.length, vsync: this,animationDuration: Duration.zero);
    var hours1;
    var mints1;
    var secs1;
    hours1 = int.parse("03");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
    reset1();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            actionWidgets(),
            // buildQuestionTabs(),
            selectQueList(),
            questionWidget(),
          ],
        ),
      ),
    );
  }


/*  buildQuestionTabs(){
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
                                *//*if(convertstr['entityMap']!=null) {
                                 print('empty');
                               }else{
                                 opetionsimage = convertstr['entityMap']['0']['data']['url'];
                               }*//*


                                return RadioListTile(
                                  value: idx,
                                  groupValue: _value,
                                  onChanged: (ind) => setState(() => _value = ind),
                                  title: (opetions != '')? Math.tex(opetions.replaceAll("\$", '')) : (optionImage != '' ) ?
                                  Image(image: NetworkImage(optionImage),
                                    height: 140,
                                    fit: BoxFit.fill,)  : (optionText != '' ) ? Math.tex(optionText.replaceAll("\$", '')) : Text('') ,
                                );

                                *//*return RadioListTile(
                                 value: idx,
                                 groupValue: _value,
                                 onChanged: (ind) => setState(() => _value = ind),
                                 title: (opetions != '')? Text(opetions) : (optionImage != '' ) ?
                                 Image(image: NetworkImage(optionImage),
                                   height: 140,
                                   fit: BoxFit.fill,)  : (optionText != '' ) ? Text(optionText) : Text('') ,
                               );*//*
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
  }*/

  /*==================================================== List Questions ============================================================*/

  Widget selectQueList(){
    final List<Map> data = List.generate(10,
            (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});
    return Container(
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
                  color: /*(tappedIndex == index)
                      ? Colors.green
                      :*/ Colors.white,
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 0.0),
                    onTap: () {
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
                /*(index == tappedIndex)? const Positioned(
                  child: Icon(Icons.remove_red_eye_outlined, size: 12,),
                  right: 0,
                  top: -26,
                  bottom: 0,
                ) :*/ Container()
              ],
            ); },

        ),
      ),
    );
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
  const questionWidget({Key? key}) : super(key: key);

  @override
  _questionWidgetState createState() => _questionWidgetState();
}

class _questionWidgetState extends State<questionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
/*    return PageView.builder(
      itemCount: ,
      itemBuilder: (context, index){
        return buildQuestion();
      },
      physics: NeverScrollableScrollPhysics(),
    );*/
  }
}