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
import '../../constants/theme/style.dart';
import '../../helper/api/functions/execute.dart';
import '../../model/assesments/getwrapper.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/sharedPref.dart';
import '../execute/test/AttemptTest.dart';
import '../execute/test/viewAnalysis.dart';
import '../stats_analysis/reports/testScreen.dart';

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




 /* @override
  @override
  void initState() {
     Future.microtask(() async => {
      await Provider.of<TestProviderClass>(context, listen: false)
          .apiCall(),
    });
    // getWrappers_res = getWrappers();
  }
*/
  @override
  Widget build(BuildContext context) {
    BoxDecoration conDecoration = BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(
            Radius.circular(10.0))
    );
    final myModel = Provider.of<TestProviderClass>(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: MenuWidget(),
              elevation: 0,
              // title: Text('${context.watch<TestProviderClass>().tabValues}',style: GoogleFonts.poppins(color: Constants.black),),
              backgroundColor: Constants.backgroundColor,
            ),
            // backgroundColor: Constants.backgroundColor,
            body: ChangeNotifierProvider.value(
              value: myModel,
              child: Consumer(builder: (context, model, child){
                return myModel.mapItemsList.isNotEmpty ?
                Column(
                    children: [
                      SizedBox(height: 15.0,),

                      Expanded(
                          child: ListView.builder(
                            itemCount: myModel.mapItemsList.length,
                            itemBuilder: (context,index){
                              return Container(
                                child: ExpansionTile(
                                  title: Text(myModel.mapItemsList.keys.elementAt(index).toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                                  children: [
                                    Container(
                                     /* height : MediaQuery.of(context).size.height/4,*/
                                      child: GridView.builder(
                                        physics: ScrollPhysics(),

                                        shrinkWrap: true,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 1.0,
                                            crossAxisSpacing: 1.0,
                                            mainAxisExtent: 90.0
                                        ),
                                        itemCount: myModel.mapItemsList.values.elementAt(index).length,
                                       // scrollDirection: Axis.horizontal,
                                        itemBuilder: (context,ind){
                                          return InkWell(
                                            onTap: (){
                                              print('hyy');
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => TestScreen(list: myModel.mapItemsList.values.elementAt(index).values.elementAt(ind))));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              margin: const EdgeInsets.all(10.0),
                                              decoration:conDecoration,
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(myModel.mapItemsList.values.elementAt(index).keys.elementAt(ind).toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Style.textStyleRegular13Black),
                                                  SizedBox(height: 10.0,),
                                                  Text('0/${myModel.mapItemsList.values.elementAt(index).values.elementAt(ind).length}',
                                                      style: Style.textStyleRegular13Black)
                                                ],
                                              ),
                                            ),
                                          );
                                        },

                                      ),
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )


                      ),
                    ],
                  ) : Center(child: Text("No Live Test Found..."),);

              }),
            )
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
