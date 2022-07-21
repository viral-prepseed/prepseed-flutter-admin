import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:prepseed/helper/api/functions/execute.dart';
import 'package:prepseed/views/execute/test/viewAnalysis.dart';
import 'package:prepseed/views/menu/menu_widget.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/strings.dart';
import '../../../helper/api/functions.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../../helper/sharedPref.dart';
import '../../../model/assesments/getwrapper.dart';
import '../../login/prepseed_loginScreen.dart';
import 'AttemptTest.dart';
import 'package:provider/provider.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  late dynamic getWrappers_res;
  late List<dynamic> listt = [];
  List<dynamic> uniquelabel = [];
  Map finalMap = Map();
  Map finalMapTopicMock = Map();
  late Map<String, List<dynamic>> testMapped = {};




  @override
  void initState() {
    /*Future.microtask(() async => {
      Provider.of<TestProviderClass>(context, listen: false)
          .apiCall(), //provider to call API and update data....
    });*/
    getWrappers_res = getWrappers();
  }


  getWrappers() async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getWrappers+'/'+phaseId;
    print(token);
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // success
      var response = json.decode(res.body);
      print(res.statusCode);

      List<AssessmentWrappers> posts = List<AssessmentWrappers>.from(response["assessmentWrappers"].map((model)=> AssessmentWrappers.fromJson(model)));

      uniquelabel = checkLength(posts);

      // print(uniquelabel.runtimeType);


      var test = [
        {"title": 'Avengers', "release_date": '10/01/2019'},
        {"title": 'Creed', "release_date": '10/01/2019'},
        {"title": 'Jumanji', "release_date": '30/10/2019'},
      ];

      dynamic map =  response['assessmentWrappers'];

      var list = map.map((item) => AssessmentWrappers.fromJson(item));

      // print(list.length);
      var phoneGroup = groupBy(list, (obj) => (obj as AssessmentWrappers).label);
      // print(phoneGroup);
      /*var type = groupBy(list, (obj) => (obj as AssessmentWrappers).type);

    print(phoneGroup.keys);*/
      for (var phone in phoneGroup.keys) {
        // print(phoneGroup[phone]);
        var map = Map();
        var topicmockmap = Map();
        var originCountryGroup = groupBy(phoneGroup[phone]!, (obj) => ((obj as AssessmentWrappers)));
        var topicmock = groupBy(phoneGroup[phone]!, (obj) => ((obj as AssessmentWrappers)));
        for (var originCountry in originCountryGroup.keys) {
          // print(originCountryGroup.keys);
          if(originCountry.type == 'LIVE-TEST'){
            var spaceGroup = originCountry;//groupBy(originCountryGroup[originCountry]!, (obj) => (obj as AssessmentWrappers).type);
            map[originCountry] = spaceGroup;
          }
        }

        if(map.isNotEmpty){
          map = { phone : map };
        }
        for (var topicmockele in topicmock.keys) {
          if(topicmockele.type!.isNotEmpty){
            if(topicmockele.type == 'FULL-MOCK'){
              // print(topicmockele);
              var spaceGroup = topicmockele;//groupBy(originCountryGroup[originCountry]!, (obj) => (obj as AssessmentWrappers).type);
              topicmockmap[topicmockele] = spaceGroup;
            }
          }


        }
        if(topicmockmap.isNotEmpty){
          topicmockmap = { phone : topicmockmap };
        }

        setState(() {
          finalMap = {...finalMap, ...map};
          finalMapTopicMock = {...finalMapTopicMock, ...topicmockmap};
        });
      }
      // print(jsonEncode(finalMapTopicMock));

      return response["assessmentWrappers"];

    } else if(res.statusCode == 404){
      // not found
      print('404');
      return true;
    } else if(res.statusCode == 500){
      // server not responding.
      print('server not responding');
    } else if(res.statusCode == 401) {
      // some other error or might be CORS policy error. you can add your url in CORS policy.

      var newRoute = MaterialPageRoute(builder: (BuildContext context) => prepSeed_login());
      Navigator.of(context).push(newRoute);
    }else{
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: MenuWidget(),
            elevation: 0,
            backgroundColor: Constants.backgroundColor,
          ),
          // backgroundColor: Constants.backgroundColor,
          body: /*Consumer<TestProviderClass>(builder: (context, myModel, child){
            return ListView.builder(
              itemCount: myModel.post == null
                  ? 0
                  : myModel.post.length, //length according to data present
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: FlutterLogo(),
                    title: Text(Provider.of<TestProviderClass>(context, listen: false).post[index].success!.toString()),
                    trailing: Icon(Icons.more_vert),
                  ),
                );
              },
            );
          }*/



          (finalMap.values.isNotEmpty || finalMapTopicMock.values.isNotEmpty)? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Constants.backgroundColor,
              resizeToAvoidBottomInset: false,
              /*appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: ClipPath(
                // clipper: Customshape(),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  // color: Constants.blue.withOpacity(0.7),
                  // child:
                ),
              ),
            ),*/
              body: Column(
                children: [
                  TabBar(
                    indicatorColor: Constants.blue,
                    labelColor: Constants.white.withOpacity(0.8),
                    unselectedLabelColor: Constants.white.withOpacity(0.5),
                    labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17
                    ),
                    tabs: const [
                      Tab(text: 'Live'),
                      Tab(text: 'Mocks'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                          child: (finalMap.isNotEmpty)? ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 4,),
                            itemCount: finalMap.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = finalMap.keys.elementAt(index);
                              Map<dynamic, dynamic> value = finalMap[key];
                              List valdata = value.values.toList();
                              // valdata.removeWhere((element) => element.isEmpty);
                              // print(valdata);
                              return Container(
                                // height: 500,
                                decoration: BoxDecoration(
                                  color: Constants.blacklight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: (valdata.isEmpty)? Container() : (finalMap.length <= 1)? Container(
                                  height: 550,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: GridView.count(
                                          crossAxisCount: 1,
                                          childAspectRatio: (1 / .6),
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          padding: EdgeInsets.all(5.0),
                                          children: List.generate(valdata.length, (index) {
                                            AssessmentWrappers asw = valdata.elementAt(index);

                                            bool assessment_attemp = false;
                                            return Container(
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Constants.backgroundColor
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Tooltip(
                                                        message: '${asw.name}',
                                                        child: Text('${asw.name}',
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
                                                        Text('3 hrs'),
                                                      ],
                                                    ),
                                                    Divider(color: Constants.grey,),

                                                    FutureBuilder<String>(
                                                      future: functions().getWrapperApiCall('${asw.sId}'),
                                                      builder: (
                                                          BuildContext context,
                                                          AsyncSnapshot<String> snapshot,
                                                          ) {
                                                        if (snapshot.hasData) {
                                                          return ElevatedButton(onPressed: (){
                                                            var assessmentWrapperId = asw.sId;
                                                            sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                            var route = MaterialPageRoute(builder: (BuildContext context) => (snapshot.data!.contains('Attempt'))?
                                                            AttemptTest() : viewAnalysis() );
                                                            Navigator.of(context).push(route);
                                                          },
                                                              child: Text(snapshot.data!)
                                                          );
                                                        } else {
                                                          return Text('Loading data');
                                                        }
                                                      },
                                                    )

                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          ),
                                        )
                                    ),
                                  ),
                                ) :
                                ExpansionTile(
                                  // initiallyExpanded: true,
                                  title: Container(
                                    child: Text((key != "")?key:'Other',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: GoogleFonts.poppins(color: Constants.black,
                                            fontSize: 18, fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ),
                                  tilePadding: const EdgeInsets.all(20),
                                  children: [
                                    Container(
                                      height: 550,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Center(
                                            child: GridView.count(
                                              crossAxisCount: 1,
                                              childAspectRatio: (1 / .6),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              padding: EdgeInsets.all(5.0),
                                              children: List.generate(valdata.length, (index) {
                                                AssessmentWrappers asw = valdata.elementAt(index);


                                            bool assessment_attemp = false;
                                                return Container(
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Constants.backgroundColor
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Tooltip(
                                                            message: '${asw.name}',
                                                            child: Text('${asw.name}',
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
                                                            Text('3 hrs'),
                                                          ],
                                                        ),
                                                        Divider(color: Constants.grey,),
                                                        FutureBuilder<String>(
                                                          future: functions().getWrapperApiCall('${asw.sId}'),
                                                          builder: (
                                                              BuildContext context,
                                                              AsyncSnapshot<String> snapshot,
                                                              ) {
                                                            if (snapshot.hasData) {
                                                              return ElevatedButton(onPressed: (){
                                                                var assessmentWrapperId = asw.sId;
                                                                sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                                var route = MaterialPageRoute(builder: (BuildContext context) => (snapshot.data!.contains('Attempt'))?
                                                            AttemptTest() : viewAnalysis() );
                                                                Navigator.of(context).push(route);
                                                              },
                                                                  child: Text(snapshot.data!)
                                                              );
                                                            } else {
                                                              return Text('Loading data');
                                                            }
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              ),
                                            )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ) :
                          Center(child: Container(child: Text('No test available yet.'),)),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                          child: (finalMapTopicMock.isNotEmpty)? ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 4,),
                            itemCount: finalMapTopicMock.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = finalMapTopicMock.keys.elementAt(index);
                              Map<dynamic, dynamic> value = finalMapTopicMock[key];
                              List valdata = value.values.toList();
                              // valdata.removeWhere((element) => element.isEmpty);
                              // print(finalMapTopicMock);
                              return Container(
                                // height: 500,
                                decoration: BoxDecoration(
                                  color: Constants.blacklight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: (valdata.isEmpty)? Center(child: Container()) : (finalMapTopicMock.length <= 1)? Container(
                                  height: 550,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: GridView.count(
                                          crossAxisCount: 1,
                                          childAspectRatio: (1 / .6),
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          padding: EdgeInsets.all(5.0),
                                          children: List.generate(valdata.length, (index) {
                                            AssessmentWrappers asw = valdata.elementAt(index);


                                            bool assessment_attemp = false;
                                                return Container(
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Constants.backgroundColor
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Tooltip(
                                                        message: '${asw.name}',
                                                        child: Text('${asw.name}',
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
                                                        Text('3 hrs'),
                                                      ],
                                                    ),
                                                    Divider(color: Constants.grey,),

                                                    FutureBuilder<String>(
                                                      future: functions().getWrapperApiCall('${asw.sId}'),
                                                      builder: (
                                                          BuildContext context,
                                                          AsyncSnapshot<String> snapshot,
                                                          ) {
                                                        if (snapshot.hasData) {
                                                          return ElevatedButton(onPressed: (){
                                                            var assessmentWrapperId = asw.sId;
                                                            sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                            var route = MaterialPageRoute(builder: (BuildContext context) => (snapshot.data!.contains('Attempt'))?
                                                            AttemptTest() : viewAnalysis() );
                                                            Navigator.of(context).push(route);
                                                          },
                                                              child: Text(snapshot.data!)
                                                          );
                                                        } else {
                                                          return Text('Loading data');
                                                        }
                                                      },
                                                    )

                                                    /*ElevatedButton(onPressed: (){
                                                      var assessmentWrapperId = asw.sId;
                                                      sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                      var route = MaterialPageRoute(builder: (BuildContext context) => (snapshot.data!.contains('Attempt'))?
                                                            AttemptTest() : viewAnalysis() );
                                                      Navigator.of(context).push(route);
                                                    },
                                                        child: Text((assessment_attemp)?'View Analysis':'Attempt'))*/
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          ),
                                        )
                                    ),
                                  ),
                                ) :
                                ExpansionTile(
                                  // initiallyExpanded: true,
                                  title: Container(
                                    child: Text((key != "")?key:'Other',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: GoogleFonts.poppins(color: Constants.black,
                                            fontSize: 18, fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ),
                                  tilePadding: const EdgeInsets.all(20),
                                  children: [
                                    Container(
                                      height: 550,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Center(
                                            child: GridView.count(
                                              crossAxisCount: 1,
                                              childAspectRatio: (1 / .6),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              padding: EdgeInsets.all(5.0),
                                              children: List.generate(valdata.length, (index) {
                                                AssessmentWrappers asw = valdata.elementAt(index);


                                            bool assessment_attemp = false;
                                                return Container(
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Constants.backgroundColor
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Tooltip(
                                                            message: '${asw.name}',
                                                            child: Text('${asw.name}',
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
                                                            Text('3 hrs'),
                                                          ],
                                                        ),
                                                        Divider(color: Constants.grey,),

                                                        FutureBuilder<String>(
                                                          future: functions().getWrapperApiCall('${asw.sId}'),
                                                          builder: (
                                                              BuildContext context,
                                                              AsyncSnapshot<String> snapshot,
                                                              ) {
                                                            if (snapshot.hasData) {
                                                              return ElevatedButton(onPressed: (){
                                                                var assessmentWrapperId = asw.sId;
                                                                sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                                                                var route = MaterialPageRoute(builder: (BuildContext context) => (snapshot.data!.contains('Attempt'))?
                                                            AttemptTest() : viewAnalysis());
                                                                Navigator.of(context).push(route);
                                                              },
                                                                  child: Text(snapshot.data!)
                                                              );
                                                            } else {
                                                              return Text('Loading data');
                                                            }
                                                          },
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              ),
                                            )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ) :
                          Center(child: Container(child: Text('No test available yet.'),)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ) :
          const Center(child: CircularProgressIndicator(),


          ),
        )
    );
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
          (Map<K, List<E>> map, E element) =>
      map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

void addValueToMap<K, V>(Map<K, List<V>> map, K key, V value) =>
    map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

List<dynamic> checkLength(List<AssessmentWrappers> aw){
  List checklabel = [];
  List totalLiveTest = [];
  var seen ;
  aw.forEach((element) {
    if(element.type == 'LIVE-TEST') {
      checklabel.add(element.label);

      List<dynamic> keyList = checklabel;

      List<AssessmentWrappers> listOfValues = [];
      List<dynamic> valueList = [];

      listOfValues.add(element);

      Map<dynamic, AssessmentWrappers> mealsEachDay = new Map();
      // and here the relationship between the dates and the meals is done
      for(var i = 0; i < listOfValues.length; i++) {
        mealsEachDay[keyList[i]] = listOfValues[i];
      }

      seen = Set<String>();
      var assesobbj = Set<AssessmentWrappers>();
      List<AssessmentWrappers> uniquelist = aw.where((student) {
        return seen.add(student.label!);
      }).toList();


      // print(uniquelist);

      /*List<String> yourObjects = mealsEachDay.keys.map((date) {
        return "The date is '${(mealsEachDay[date]?.label! == '')?'Other':mealsEachDay[date]?.label!}' and the meal is '${mealsEachDay[date]?.name!}'";
      }).toList();

      yourObjects.forEach((s) {
        print(s);
      });*/
    }

    // print(checklabel);
    totalLiveTest = checklabel.toSet().toList();
  });

  return seen.toList();
/*
    if(!(checklabel.contains(liveTest.label))){
      checklabel.add(liveTest.label);
    }
    print(checklabel);*/
}
