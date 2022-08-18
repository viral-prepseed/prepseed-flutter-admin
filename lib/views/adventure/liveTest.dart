
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
                return  Column(
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
                              );/* Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpansionTile(
                                    title: Text(myModel.mapItemsList.keys.elementAt(index).toString()),
                                    children: [
                                      ListView.builder(
                                        itemCount: myModel.mapItemsList.values.elementAt(index).length,
                                        scrollDirection: Axis.horizontal,
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
                                              width: 150.0,
                                              decoration:conDecoration,
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(myModel.mapItemsList.values.elementAt(index).keys.elementAt(ind).toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Style.textStyleBold13),
                                                  SizedBox(height: 10.0,),
                                                  Text('0/${myModel.mapItemsList.values.elementAt(index).values.elementAt(ind).length}',
                                                      style: Style.textStyleRegular13Black)
                                                ],
                                              ),
                                            ),
                                          );
                                        },

                                      ),
                                    ],
                                  ),
                                 *//* Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(myModel.mapItemsList.keys.elementAt(index).toString(),
                                        style: Style.textStyleBold15),
                                  ),
                                  SizedBox(
                                    height: 90,
                                    child: ListView.builder(
                                      itemCount: myModel.mapItemsList.values.elementAt(index).length,
                                      scrollDirection: Axis.horizontal,
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
                                            width: 150.0,
                                            decoration:conDecoration,
                                            child: Column(
                                             // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(myModel.mapItemsList.values.elementAt(index).keys.elementAt(ind).toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Style.textStyleBold13),
                                                SizedBox(height: 10.0,),
                                                Text('0/${myModel.mapItemsList.values.elementAt(index).values.elementAt(ind).length}',
                                                    style: Style.textStyleRegular13Black)
                                              ],
                                            ),
                                          ),
                                        );
                                      },

                                    ),
                                  )*//*
                                ],
                              );*/
                            },
                          )
                           /*ListView.separated(
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
                       // var route = MaterialPageRoute(builder: (BuildContext context) => AttemptTest());
                                                  Navigator.of(context).push(route);
                                          },
                                              child: Text(snapshot.data!)
                                          );
                                              } else {
                                                return Text('Loading data');
                                              }
                                            },
                                          ),

                       */
                          /* ElevatedButton(onPressed: (){
                                            var route = MaterialPageRoute(builder: (BuildContext context) => AttemptTest());
                                            Navigator.of(context).push(route);
                                          },
                                              child: Text('${functions().getWrapperApiCall('${asw.elementAt(idx).sId}').then((String value) => value)}')
                                          )*//*
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );*/

                      ),
                    ],
                  );

              }),
            )
        )
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
  }



}
