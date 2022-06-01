import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import '../../constants/colorPalate.dart';
import '../../constants/strings.dart';
import '../../helper/sharedPref.dart';
import '../../model/getwrapper.dart';

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
  late Map<String, List<dynamic>> testMapped = {};

   MapByKey(String keyName, String newKeyName, String keyForNewName, List<dynamic> input) {
    Map<String, List<dynamic>> returnValue = Map<String, List<dynamic>>();
    for (var currMap in input) {
      if (currMap.containsKey(keyName)) {
        var currKeyValue = currMap[keyName];
        var currKeyValueForNewName = currMap[keyForNewName];
        if (!returnValue.containsKey(currKeyValue)){
          returnValue[currKeyValue!] = listt;
        }
        returnValue[currKeyValue]?.add(currKeyValueForNewName);
        // returnValue[currKeyValue]?[currKeyValue]?.add({newKeyName : currKeyValueForNewName!});
      }
    }
    return returnValue;
  }


  @override
  void initState() {
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
      'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNjI0MTE5Y2RmYjdkMWM5NDhhYzc5OSIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNjU5MjYwMzQ4LCJwaHMiOnt9LCJpYXQiOjE2NTQwNzYzNDd9.qIg3GBBYbUZU347iQv6X2MjvWwAA5FhENsK5MSNAlNM',
    });

    // if (res.statusCode == 200) {
      // success
      var response = json.decode(res.body);
      print(res.statusCode);

    List<AssessmentWrappers> posts = List<AssessmentWrappers>.from(response["assessmentWrappers"].map((model)=> AssessmentWrappers.fromJson(model)));

    uniquelabel = checkLength(posts);

    print(uniquelabel.runtimeType);


    var test = [
      {"title": 'Avengers', "release_date": '10/01/2019'},
      {"title": 'Creed', "release_date": '10/01/2019'},
      {"title": 'Jumanji', "release_date": '30/10/2019'},
    ];

    dynamic map =  response['assessmentWrappers'];
     testMapped = MapByKey("label", "name", "name",map);

    print(testMapped.runtimeType);
      /*for(int i =0; i<response["assessmentWrappers"].length; i++){
        AssessmentWrappers gw = AssessmentWrappers.fromJson(response["assessmentWrappers"][i]);

        if(gw.type == 'LIVE-TEST'){
          allTest.add(gw);
        }
      }
      totalLiveTest = allTest.toSet().toList();
      print(totalLiveTest);*/

    var list = map.map((item) => AssessmentWrappers.fromJson(item));
    print(list.length);
    var phoneGroup = groupBy(list, (obj) => (obj as AssessmentWrappers).label);
    /*var type = groupBy(list, (obj) => (obj as AssessmentWrappers).type);

    print(phoneGroup.keys);*/
    for (var phone in phoneGroup.keys) {
      var map = Map();
      var originCountryGroup =
      groupBy(phoneGroup[phone]!, (obj) => ((obj as AssessmentWrappers).type == 'LIVE-TEST')?(obj).name:'');
      for (var originCountry in originCountryGroup.keys) {
        // print(originCountryGroup.keys);
        var spaceGroup = originCountry;//groupBy(originCountryGroup[originCountry]!, (obj) => (obj as AssessmentWrappers).type);
        map[originCountry] = spaceGroup;
      }
      map = { phone : map };
      finalMap = {...finalMap, ...map};
    }
    print(jsonEncode(finalMap));

      return response["assessmentWrappers"];

    /*} else if(res.statusCode == 404){
      // not found
      print('404');
      return true;
    } else if(res.statusCode == 500){
      // server not responding.
      print('server not responding');
    } else {
      // some other error or might be CORS policy error. you can add your url in CORS policy.
      print('Something went wrong');
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor,
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Constants.backgroundColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: ClipPath(
                // clipper: Customshape(),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  // color: Constants.blue.withOpacity(0.7),
                  child: TabBar(
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
                ),
              ),
            ),
            body: Container(
              child: TabBarView(
                children: [
                  // allUserTasks(),

                  // Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 4,),
                  itemCount: finalMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = finalMap.keys.elementAt(index);
                    Map<dynamic, dynamic> value = finalMap[key];
                    List valdata = value.values.toList();
                    valdata.removeWhere((element) => element.isEmpty);
                    print(valdata);
                    return Container(
                      // height: 500,
                      decoration: BoxDecoration(
                        color: Constants.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: (valdata.isEmpty)? Container() :
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
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Center(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: (1 / 1.1),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    padding: EdgeInsets.all(5.0),
                                    children: List.generate(valdata.length, (index) => Container(
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
                                                message: '${valdata[index]}',
                                                child: Text('${valdata[index]}',
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
                                            ElevatedButton(onPressed: (){},
                                                child: Text('Attempt'))
                                          ],
                                        ),
                                      ),
                                    )
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

                       /*SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                          itemCount: testMapped.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = testMapped.keys.elementAt(index);
                            List<dynamic>? innerdata = testMapped[key];
                            print(innerdata!.length);
                            return  Container(
                              // height: 500,
                              decoration: BoxDecoration(
                                color: Constants.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ExpansionTile(
                                // initiallyExpanded: true,
                                title: Text('$key',
                                    style: GoogleFonts.poppins(color: Constants.black,
                                        fontSize: 18, fontWeight: FontWeight.bold
                                    )
                                ),
                                tilePadding: const EdgeInsets.all(20),
                                children: [
                                  Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
                                      child: Center(
                                          child: GridView.count(
                                            crossAxisCount: 2,
                                            childAspectRatio: (1 / 1.5),
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            padding: EdgeInsets.all(5.0),
                                            children: List.generate(innerdata.length, (index) => Container(
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
                                                      child: Text(innerdata[index]),
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
                                                    ElevatedButton(onPressed: (){},
                                                        child: Text('Attempt'))
                                                  ],
                                                ),
                                              ),
                                            )
                                            ),
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                    ),
                        ),
                      ),*/

                      /*if(snapshot.connectionState == ConnectionState.done){
                        List<AssessmentWrappers> posts = List<AssessmentWrappers>.from(data.map((model)=> AssessmentWrappers.fromJson(model)));

                        return _buildListView(posts);*/
                      /*}else{
                        return Center(child: CircularProgressIndicator());
                      }*/

                  // ),

                  /*SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [

                          Container(
                            // height: 500,
                            decoration: BoxDecoration(
                              color: Constants.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              // initiallyExpanded: true,
                              title: Text('Other',
                                  style: GoogleFonts.poppins(color: Constants.black,
                                      fontSize: 18, fontWeight: FontWeight.bold
                                  )
                              ),
                              tilePadding: const EdgeInsets.all(20),
                              children: [
                                Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          childAspectRatio: (1 / 1.1),
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          padding: EdgeInsets.all(5.0),
                                          children: List.generate(5, (index) => Container(
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
                                                    child: Text('ACT1 Paper2'),
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
                                                  ElevatedButton(onPressed: (){},
                                                      child: Text('Attempt'))
                                                ],
                                              ),
                                            ),
                                          )
                                          ),
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(height: 15,),
                          Container(
                            // height: 500,
                            decoration: BoxDecoration(
                              color: Constants.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              // initiallyExpanded: true,
                              title: Text('Test',
                                  style: GoogleFonts.poppins(color: Constants.black,
                                      fontSize: 18, fontWeight: FontWeight.bold
                                  )
                              ),
                              tilePadding: const EdgeInsets.all(20),
                              children: [
                                Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: Center(
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          childAspectRatio: (1 / 1.3),
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          padding: EdgeInsets.all(5.0),
                                          children: List.generate(3, (index) => Container(
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
                                                    child: Text('Path Finder_MCT-1_12-07-2021_Test paper'),
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
                                                  ElevatedButton(onPressed: (){},
                                                      child: Text('Attempt'))
                                                ],
                                              ),
                                            ),
                                          )
                                          ),
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  Center(
                    child: Container(
                      child: Text('No test available yet.',),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

Widget _buildListView(List<AssessmentWrappers> aw) {
  // checkLength(aw);
  return ListView.builder(
    itemBuilder: (ctx, idx) {
      var liveTest = aw[idx];

      // if(liveTest.type == 'LIVE-TEST'){
        return Container(
          // height: 500,
          decoration: BoxDecoration(
            color: Constants.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            // initiallyExpanded: true,
            title: Text((liveTest.label! == '')?'Other':liveTest.label!,
                style: GoogleFonts.poppins(color: Constants.black,
                    fontSize: 18, fontWeight: FontWeight.bold
                )
            ),
            tilePadding: const EdgeInsets.all(20),
            children: [
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Center(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1.1),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        padding: EdgeInsets.all(5.0),
                        children: List.generate(5, (index) => Container(
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
                                  child: Text('ACT1 Paper2'),
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
                                ElevatedButton(onPressed: (){},
                                    child: Text('Attempt'))
                              ],
                            ),
                          ),
                        )
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        );
      // }
      // return Container();
    },
    itemCount: 2,
  );
}