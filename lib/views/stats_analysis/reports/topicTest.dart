import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../helper/api/functions.dart';
import '../../../helper/api/functions/execute.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../../helper/sharedPref.dart';
import '../../../init/InitializeProviderScreen.dart';
import '../../adventure/attempt_liveTest.dart';
import '../../menu/menu_widget.dart';
import 'package:provider/provider.dart';

class TopicTest extends StatefulWidget {
  const TopicTest({Key? key}) : super(key: key);

  @override
  State<TopicTest> createState() => _TopicTestState();
}

class _TopicTestState extends State<TopicTest> {
  List<AssessmentWrappers> list = [];
  @override
  Widget build(BuildContext context) {
    list = [];
    final myModel = Provider.of<TestProviderClass>(context);
     list.addAll(myModel.tagValue) ;
    return Scaffold(
      appBar: AppBar(
        leading: MenuWidget(),
        elevation: 0,
        // title: Text('${context.watch<TestProviderClass>().tabValues}',style: GoogleFonts.poppins(color: Constants.black),),
        backgroundColor: Constants.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "LiveTest",
              style: Style.textStyleBold15,
            ),
          ),
          SizedBox(height: 10.0,),
          Style.divider(),
          SizedBox(height: 10.0,),
          Expanded(
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    mainAxisExtent: 180.0
                ),
                padding: EdgeInsets.all(10.0),
                itemCount: list.length,
                itemBuilder: (context,index){
                  print(list.length);
                  return  Container(
                    //  padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration:conDecoration,
                      child: Column(
                        children: [
                          Container(
                            height: 50.0,
                            padding: const EdgeInsets.all(10.0),
                            child: Text(list[index].name.toString()),
                          ),
                          Style.divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Questions'),
                                Text('20')
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Durations'),
                                Text('${(list[index].core!.duration!/60).toInt().toString()} mins')
                              ],
                            ),
                          ),
                          Style.divider(),
                          Expanded(
                            // padding: EdgeInsets.all(10.0),
                           // height: 40.0,
                            child:/* Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock,size: 15.0),
                                TextButton(
                                    onPressed: (){}, child: Text('Unlock Now',style: TextStyle(
                                    fontSize: 13.0
                                ),)),
                              ],
                            ),*/
                            Container(
                              child: FutureBuilder<String>(
                                future: functions().getWrapperApiCall('${list[index].sId}'),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot,) {
                                  if (snapshot.hasData) {
                                    return ElevatedButton(
                                        style:ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          side: BorderSide(width:1, color:Colors.grey),
                                          elevation: 1, //elevation of button
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0)
                                          ),
                                        ),
                                        onPressed: (){
                                          var assessmentWrapperId = list[index].sId;
                                          sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                          Future.microtask(() async => {
                                            Provider.of<TestProviderClass>(context, listen: false).assessments(assessmentWrapperId),
                                          });
                                          var route = MaterialPageRoute(builder: (BuildContext context) =>
                                          // attempt_liveTest() :
                                          InitializeProviderScreen() );
                                          (snapshot.data!.contains('Attempt')) ? showDialogBox() :
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) =>InitializeProviderScreen())
                                          );
                                          // var route = MaterialPageRoute(builder: (BuildContext context) => AttemptTest());
                                        },
                                        child: Text(snapshot.data!,style: Style.textStyleRegular13Black,)
                                    );
                                  } else {
                                    return Text('Loading data');
                                  }
                                },
                              ),
                              padding: EdgeInsets.all(10.0),
                              //margin: EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                      )
                  );
                },
              )
          )
        ],
      ),
    );
  }
  BoxDecoration conDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: const BorderRadius.all(
          Radius.circular(10.0))
  );




  showDialogBox() async {
    var res = await executeFunc().assignment();
    var response = json.decode(res.body);
    // getCore(response);
    Map<dynamic, List<SubInstructions>> maplist = {};
    late var coreobjlist = [];
    List topicList = [];
    List subtopicList = [];
    Map topic_subTopics = {};

    for (var eleinst in response['core']['instructions']) {
      var coreobj = Instructions.fromJson(eleinst);

      // coreobj.instructions?.forEach((element) {
      maplist[coreobj.instruction] =
      (coreobj.subInstructions!.isNotEmpty) ? ((coreobj.subInstructions!)) : [];
      coreobjlist.add(coreobj.instruction);
      // });

      setState(() {
        maplist;
        coreobjlist;
      });
    }

    var syllabusObj = Syllabus
        .fromJson(response['core']['syllabus'])
        .topics;

    for (var eleSyllabus in syllabusObj!) {
      var data = await functions().getObjectsById(eleSyllabus.id!);
      if (data.isNotEmpty) {
        topicList.add(data.first.name);
      }
      // print(data.first.name);

      for (var eleTopics in eleSyllabus.subTopics!) {
        var datas = await functions().getObjectsBySubId(
            eleSyllabus.id!, eleTopics.id!);
        if (datas.isNotEmpty) {
          subtopicList.add(datas.first.name);
          topic_subTopics[data.first.name] = datas.first.name;
        }
        // print(datas.first.name);
      }
    }

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
                      // Container(child: Text('smdfnjskfb'),),
                    ],
                  ))
                ],
              ),
            )
        );
      });
    });

/*  showDialogBox(){
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
                                // activeSession = true;
                              });
                              Navigator.of(context).pop();



                              var route = MaterialPageRoute(builder: (BuildContext context) => attempt_liveTest());
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
  }*/
  }



}
