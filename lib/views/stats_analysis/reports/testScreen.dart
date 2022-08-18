import 'package:flutter/material.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../helper/api/functions.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../../helper/sharedPref.dart';
import '../../../init/InitializeProviderScreen.dart';
import '../../adventure/attempt_liveTest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {

  List list;
  TestScreen({required this.list});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                    widget.list[0].tags[1].value.toString() /*model.playlist!.title.toString()*/,
                    style: Style.textStyleBold15
                )
              ],
            ),
            Style.divider(),
            Expanded(
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    mainAxisExtent: 170.0
                ),
                padding: EdgeInsets.all(10.0),
                itemCount: widget.list.length,
                itemBuilder: (context,index){
                  return Container(
                  //  padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration:conDecoration,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.list[index].name.toString(),
                            style: Style.textStyleRegular13Black,overflow: TextOverflow.ellipsis,),
                          ),
                          Style.divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Questions', style: Style.textStyleRegular13Black,),
                                Text('20', style: Style.textStyleRegular13Black,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Durations', style: Style.textStyleRegular13Black,),
                                Text('${(widget.list[index].core.duration/60).toInt().toString()} mins', style: Style.textStyleRegular13Black,)
                              ],
                            ),
                          ),
                          Style.divider(),
                          Expanded(
                            child: /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock,size: 15.0,),
                                TextButton(
                                    onPressed: (){
                                      print('hey');
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => InitializeProviderScreen())
                                      );
                                    }, child: Text('Unlock Now',style: TextStyle(
                                  fontSize: 13.0
                                ),)),
                              ],
                            ),*/
                            Container(
                              child: FutureBuilder<String>(
                                future: functions().getWrapperApiCall('${widget.list[index].sId}'),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot,) {
                                  if (snapshot.hasData) {
                                    return ElevatedButton(
                                       style:ElevatedButton.styleFrom(
                                           primary: Colors.white,
                                           side: BorderSide(width:1, color:Colors.grey),
                                           elevation: 1, //elevation of button
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10)
                                           ),
                                       ),
                                        onPressed: (){
                                      var assessmentWrapperId = widget.list[index].sId;
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