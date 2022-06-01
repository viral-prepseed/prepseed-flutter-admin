import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/model/getwrapper.dart';
import 'package:collection/collection.dart';

import '../../constants/colorPalate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants/strings.dart';

class quantized_sheet extends StatefulWidget {
  const quantized_sheet({Key? key}) : super(key: key);

  @override
  _quantized_sheetState createState() => _quantized_sheetState();
}

class _quantized_sheetState extends State<quantized_sheet> {
  late List subject = [];
  late List<String> keys = [];

  late Map alltagsmap = {};
  late Map finalMap = Map();
  late Map<String,dynamic> alldata = Map();

  @override
  void initState() {
    getWrappers();
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

    if (res.statusCode == 200) {
      // success
      var response = json.decode(res.body);
/*      for(int i =0; i<response["assessmentWrappers"].length; i++){
        AssessmentWrappers gw = AssessmentWrappers.fromJson(response["assessmentWrappers"][i]);

        if(gw.type == 'LIVE-TEST'){
          subject.add(gw.label);
        }

      }

      List result = subject.toSet().toList();
      print(result);*/
      List collapseData = [];

      dynamic res_map =  response['assessmentWrappers'];

      List<dynamic> tagmap = [];
      var compressedData = Map();
      var map = Map();
      for(int i=0; i<res_map.length; i++){
        tagmap = response['assessmentWrappers'][i]['tags'];


        var list = tagmap.map((item) => Tags.fromJson(item));
        // print(list.length);
        var phoneGroup = groupBy(list, (obj) => (obj as Tags).value);
        // print(phoneGroup.keys);
        /*var type = groupBy(list, (obj) => (obj as AssessmentWrappers).type);
        print(phoneGroup.keys);*/

        if(tagmap.isNotEmpty){
          keys.add((Tags.fromJson(response['assessmentWrappers'][i]['tags'][0]).value!).trim());
          var compressedData = tagmap
              .map((item) => item["value"])
              .reduce((value, element) => value + element);

        }



        // map = { tagmap[0]['value'] : tagmap[1]['value']};

       /*for (var phone in phoneGroup.keys) {
          var originCountryGroup = Tags.fromJson(tagmap[0]).key.toString();
          var map = Map();
          // map[phone] = originCountryGroup;
          map = { phone : originCountryGroup };
          finalMap = {...finalMap, ...map};
        }*/

      }
      // valuedata = [];
      late List<dynamic> valuedata = [];
      // print(keys.toSet().toList());

      for(var k in keys.toSet().toList()){


        for(int j=0;j<response['assessmentWrappers'].length; j++){ //
          if(response['assessmentWrappers'][j]['tags'].isNotEmpty){
              if(Tags.fromJson(response['assessmentWrappers'][j]['tags'][0]).value?.trim() == k){  //
                valuedata.add(Tags.fromJson(response['assessmentWrappers'][j]['tags'][1]).value);
              }
          }
        }
        // print(valuedata);
        if(valuedata.isNotEmpty){
          map[k] = valuedata;
        }

        valuedata = [];
        // valuedata = [];
        // break;
      }

      // finalMap = {...finalMap, ...map};
      Map<String,dynamic> mapcount = Map();
      List mappedcount = [];
              if(map.values.isNotEmpty){
                  for (var keyele in map.values) {
                    for (var element in keyele) {
                    if(!mapcount.containsKey(element)) {
                      mapcount[element] = 1;
                    } else {
                      mapcount[element] +=1;
                    }

                    }
                    // print(mapcount);
                    mappedcount.add(mapcount);
                    mapcount = {};
                }
        }

/*
      print(mappedcount.length);*/

      var count = 0;

      for(var x in keys.toSet().toList()){

        alldata[x] = mappedcount[count];
        count++;
      }

      // print(alldata);
      finalMap = {...finalMap, ...alldata};
      // print(finalMap);
// print(jsonEncode(finalMap));

      // print(keys.toSet().toList());

/*      print(keys);
      print(valuedata);*/

/*      for( var i = 0; i < valuedata.length; i++ ) {
        alltagsmap.addAll({keys[i]:valuedata[i]});
      }
      finalMap = {...finalMap, ...alltagsmap};
      print(jsonEncode(finalMap));*/



    } else if(res.statusCode == 404){
      print('404');
    } else if(res.statusCode == 500){
      print('server not responding');
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(finalMap.values.length);
    return Scaffold(
      body: DefaultTabController(
        length: finalMap.values.length,
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                // color: Constants.blue.withOpacity(0.7),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Constants.blue,
                  labelColor: Constants.white.withOpacity(0.8),
                  unselectedLabelColor: Constants.white.withOpacity(0.5),
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17
                  ),
                  tabs: List.generate(finalMap.values.length, (index) {
                     return Tab(
                        child: Text(finalMap.keys.elementAt(index)),
                     );
                  }),
                ),
              ),
            ),
          ),
          body: Container(
            child: TabBarView(
              children:
                List.generate(finalMap.keys.length, (idx) {
                 return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / .6),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          padding: EdgeInsets.all(5.0),
                          children: List.generate(finalMap.values.elementAt(idx).length, (index)
                          {
                            Map datamap = finalMap.values.elementAt(idx);
                            var title = datamap.keys.elementAt(index);
                            var noque = datamap.values.elementAt(index);
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Constants.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(title,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style:
                                        GoogleFonts.poppins(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          LinearProgressIndicator(
                                            value: 340,
                                          ),
                                          Text('0/${noque}')
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        )
                    ),
                  );
                }),

            ),
          ),
        ),
      ),

    );
  }
}
