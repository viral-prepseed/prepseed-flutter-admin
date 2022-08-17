import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prepseed/helper/api/functions.dart';
import 'package:prepseed/init/InitializeProviderScreen.dart';
import 'package:prepseed/views/adventure/attempt_liveTest.dart';
import 'package:prepseed/views/menu/menu_widget.dart';

import '../../../constants/colorPalate.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../helper/api/functions/execute.dart';
import '../../model/assesments/getwrapper.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/sharedPref.dart';
import '../execute/test/AttemptTest.dart';
import '../execute/test/viewAnalysis.dart';

class livetest extends StatefulWidget {
  const livetest({Key? key}) : super(key: key);

  @override
  _livetestState createState() => _livetestState();
}

class _livetestState extends State<livetest> {
  late dynamic getWrappers_res;
  late List<dynamic> listt = [];
  List<dynamic> uniquelabel = [];
  Map finalMap = Map();
  Map finalMapTopicMock = Map();
  late Map<String, List<dynamic>> testMapped = {};

  @override
  void initState() {
     Future.microtask(() async => {
      await Provider.of<TestProviderClass>(context, listen: false)
          .apiCall(),
    });
    // getWrappers_res = getWrappers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: MenuWidget(),
              elevation: 0,
              // title: Text('${context.watch<TestProviderClass>().tabValues}',style: GoogleFonts.poppins(color: Constants.black),),
              backgroundColor: Constants.backgroundColor,
            ),
            // backgroundColor: Constants.backgroundColor,
            body: Consumer<TestProviderClass>(builder: (context, myModel, child){
              return DefaultTabController(
                length: myModel.tabLength,
                child: Scaffold(
                  body: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Constants.blue,
                        labelColor: Constants.white.withOpacity(0.8),
                        unselectedLabelColor: Constants.white.withOpacity(0.5),
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                        ),
                        tabs: List.generate(myModel.tabLength, (index) {
                          return Tab(
                            text: '${context.watch<TestProviderClass>().tabValues.elementAt(index)}',);
                        }
                      ),
                      ),
                      SizedBox(height: 15.0,),
                      Expanded(child:
                      TabBarView(
                        children:
                        List.generate(myModel.tabLength, (index) {
                          // print(myModel.tabContains);
                          var tablen = myModel.tabContains.values.elementAt(index).length;
                          return ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(height: 20,),
                            itemCount: myModel.tabContains.values.elementAt(index).length == null ? 0 : myModel.tabContains.values.elementAt(index).length,
                            itemBuilder: (BuildContext context, int idx) {
                              List<AssessmentWrappers> asw = myModel.tabContains.values.elementAt(index);
                              // print(tablen);
                              return Padding(
                                padding: const EdgeInsets.only(left: 25,right: 25),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 2,
                                  child: Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Constants.grey.withOpacity(.2)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Tooltip(
                                              message: '${asw.elementAt(idx).name}',
                                              child: Text('${asw.elementAt(idx).name}',
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
                                              Text(myModel.printDuration(Duration(seconds: asw.elementAt(idx).core!.duration!))),
                                            ],
                                          ),
                                          Divider(color: Constants.grey,),

                                          FutureBuilder<String>(
                                            future: functions().getWrapperApiCall('${asw.elementAt(idx).sId}'),
                                            builder: (BuildContext context, AsyncSnapshot<String> snapshot,) {
                                              if (snapshot.hasData) {
                                                return ElevatedButton(onPressed: (){
                                                  var assessmentWrapperId = asw.elementAt(idx).sId;
                                                  sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                  Future.microtask(() async => {
                                                    Provider.of<TestProviderClass>(context, listen: false).assessments(assessmentWrapperId),
                                                  });

                                                  var route = MaterialPageRoute(builder: (BuildContext context) =>
                                                  // attempt_liveTest() :
                                                      InitializeProviderScreen() );

                                                  (snapshot.data!.contains('Attempt'))? showDialogBox() :
                                                  Navigator.of(context).push(route);
                                                  /*var route = MaterialPageRoute(builder: (BuildContext context) => AttemptTest());
                                                  Navigator.of(context).push(route);*/
                                          },
                                              child: Text(snapshot.data!)
                                          );
                                              } else {
                                                return Text('Loading data');
                                              }
                                            },
                                          )

                                          /*ElevatedButton(onPressed: (){
                                            *//*var route = MaterialPageRoute(builder: (BuildContext context) => AttemptTest());
                                            Navigator.of(context).push(route);*//*
                                          },
                                              child: Text('${functions().getWrapperApiCall('${asw.elementAt(idx).sId}').then((String value) => value)}')
                                          )*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        })
                      )
                      ),
                    ],
                  ),
                ),
              );
            })
        )
    );
  }



  showDialogBox() async {
    var res = await executeFunc().assignment();
    var response = json.decode(res.body);
    // getCore(response);
    Map<dynamic,List<SubInstructions>> maplist = {};
    late var coreobjlist = [];
    List topicList = [];
    List subtopicList = [];
    Map topic_subTopics = {};

    for(var eleinst in response['core']['instructions']){
      var coreobj = Instructions.fromJson(eleinst);

      // coreobj.instructions?.forEach((element) {
      maplist[coreobj.instruction] = (coreobj.subInstructions!.isNotEmpty)? ((coreobj.subInstructions!)) : [];
      coreobjlist.add(coreobj.instruction);
      // });

      setState(() {
        maplist;
        coreobjlist;
      });
    }

    var syllabusObj = Syllabus.fromJson(response['core']['syllabus']).topics;

    for(var eleSyllabus in syllabusObj!){

      var data = await functions().getObjectsById(eleSyllabus.id!);
      if(data.isNotEmpty){
        topicList.add(data.first.name);
      }
      // print(data.first.name);

      for(var eleTopics in eleSyllabus.subTopics!){
        var datas = await functions().getObjectsBySubId(eleSyllabus.id!,eleTopics.id!);
        if(datas.isNotEmpty){
          subtopicList.add(datas.first.name);
          topic_subTopics[data.first.name] = datas.first.name;
        }
        // print(datas.first.name);
      }
    }

/*    print(topicList);
    print(subtopicList);
    print(topic_subTopics);*/


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
                                              return Text(data??'', style: GoogleFonts.poppins(fontSize: 12,
                                                  color: Constants.black));
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
                                // activeSession = true;
                              });
                              Navigator.of(context).pop();
                              var route = MaterialPageRoute(builder: (BuildContext context) => attempt_liveTest());
                              Navigator.of(context).push(route);
                            }, child: const Text('Begin Test')),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(topic_subTopics.length, (index) => Column(
                            children: [
                              Text(topic_subTopics.keys.elementAt(index),
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                              Text(topic_subTopics.values.elementAt(index)),
                              const Divider(color: Colors.grey,)
                            ],
                          )),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )
        );
      });
    });
  }



}
