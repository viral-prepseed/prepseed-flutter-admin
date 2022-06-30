import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/helper/api/functions.dart';
import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/model/getwrapper.dart';
import 'package:collection/collection.dart';
import 'package:prepseed/views/execute/quantized_sheet/inner_quantized_sheet.dart';

import '../../../constants/colorPalate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants/strings.dart';
import '../../menu/menu_widget.dart';

class quantized_sheet extends StatefulWidget {
  const quantized_sheet({Key? key}) : super(key: key);

  @override
  _quantized_sheetState createState() => _quantized_sheetState();
}

class _quantized_sheetState extends State<quantized_sheet> with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;
  late List keys = [];
  late List tabVal = [];
  late List<AssessmentWrappers> tabvaluedata = [];
  late Map tabviselist = {};
  late Map countmap = {};
  late List unique_tabviselist = [];

  late Map alltagsmap = {};
  late Map finalMap = Map();
  late Map<String,dynamic> alldata = Map();

  var jsonData;

  @override
  void initState() {
    getWrappers();
    // _controller = TabController(length: keys.toSet().toList().length, vsync: this);

  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  calculateKeys(List gwList){
    for (var elementlist in gwList) {
      var gw = AssessmentWrappers.fromJson(elementlist);
      if(elementlist['tags'].isNotEmpty) {
        keys.add(gw.tags?.first.value!.trim());
      }
    }
    setState(() {
      keys;
      _controller = TabController(length: keys.toSet().toList().length, vsync: this,animationDuration: Duration.zero);
      tabVal = keys.toSet().toList();
      // print(tabVal);
    });
    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
        buildgridlistitems(tabVal[_selectedIndex]);
      });

      // print("Selected Index: " + _controller!.index.toString());
    });
    if(tabVal.isNotEmpty){
      buildgridlistitems(tabVal[0]);
    }
  }

  buildgridlistitems(tabVal){
    setState(() {
      tabvaluedata = [];
      tabviselist = {};
      countmap = {};
      unique_tabviselist = [];
    });
    for (var elementlist in jsonData) {
      var gw = AssessmentWrappers.fromJson(elementlist);
      if (elementlist['tags'].isNotEmpty) {
        if (gw.tags?.first.value!.trim() == tabVal) {
          tabvaluedata.add(gw);
        }
      }
    }
    tabvaluedata.forEach((element) {
      if (element.tags?.first.value! == tabVal) {
        unique_tabviselist.add(element.tags?.last.value);
      }
    });

    unique_tabviselist.forEach((element) {
      if(!countmap.containsKey(element)) {
        countmap[element] = 1;
      } else {
        countmap[element] +=1;
      }
    });

    // print(countmap);

    setState(() {
      countmap;
      tabviselist;
      unique_tabviselist;
      // tabviselist[] = tabvaluedata;
      tabvaluedata;
    });

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
      List<dynamic> gwList = response["assessmentWrappers"];

      setState(() {
        jsonData = gwList;
      });
      calculateKeys(gwList);
      return gwList;

/*      for (var elementlist in gwList) {
        var gw = AssessmentWrappers.fromJson(elementlist);

        gw.tags?.forEach((element) {
          if(Tags.fromJson(element.toJson()).key == 'Section'){
            keys.add(Tags.fromJson(element.toJson()).value!.trim());
          }
        });
        if(elementlist['tags'].isNotEmpty) {
          for (var data in keys.toSet().toList()) {
            if(gw.tags?.first.value!.trim() == data){
              // listData.add(gw.tags?.last.value!);
              // finalMap.entries.where((element) => element.value == data);
            }
          }
        }
      }*/




      // print(keys.toSet().toList());




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
    // print(finalMap.values.length);
    return
     Scaffold(
       appBar: AppBar(
         backgroundColor: Constants.backgroundColor,
         elevation: 0,
         leading: MenuWidget(),
       ),
      body: (tabVal.isNotEmpty)? DefaultTabController(
        length: tabVal.length,
        child: (tabVal.isNotEmpty)?
        Scaffold(
          backgroundColor: Constants.backgroundColor,
          resizeToAvoidBottomInset: false,
          /*appBar: AppBar(
            // toolbarHeight: 60,
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
                child:
              ),
            ),
          ),*/
          body: Column(
            children: [
              TabBar(
                controller: _controller,
                isScrollable: true,
                indicatorColor: Constants.blue,
                labelColor: Constants.white.withOpacity(1.0),
                unselectedLabelColor: Constants.white.withOpacity(0.5),
                labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17
                ),
                onTap: (int) => buildgridlistitems(tabVal[_selectedIndex]),
                tabs: List.generate(tabVal.length, (index) {
                  return Tab(
                    child: Center(child: Text(tabVal[index]),),
                  );
                }),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children:
                    List.generate(tabVal.length, (idx) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / .6),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                padding: EdgeInsets.all(5.0),
                                children: List.generate(countmap.length, (index)
                                {
                                  Map sinkdata = {};
                                  var uniqObj = tabvaluedata[index];

                                  var title = countmap.keys.elementAt(index);
                                  var noque = countmap.values.elementAt(index);
                                  // print(sinkdata);
                                  return GestureDetector(
                                    onTap: (){
                                      sharedPref().setSharedPref('topicTitle', title);
                                      var route = MaterialPageRoute(builder: (BuildContext context) => inner_quantized_sheet(tabvaluedata));
                                      Navigator.of(context).push(route);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Constants.grey),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      // child: Text(title),
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
            ],
          ),
        )
            : const Center(child: CircularProgressIndicator(),),
      ) : Center(child: Container(child: Text('Oops..! No data available.'),)),

    );
  }
}
