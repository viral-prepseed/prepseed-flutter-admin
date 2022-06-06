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

class quantized_sheet_new extends StatefulWidget {
  const quantized_sheet_new({Key? key}) : super(key: key);

  @override
  _quantized_sheet_newState createState() => _quantized_sheet_newState();
}

class _quantized_sheet_newState extends State<quantized_sheet_new> {
  late List subject = [];
  late List<String> keys = [];
  late List listData = [];

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
      'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNjI0MTE5Y2RmYjdkMWM5NDhhYzc5OSIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNjU5MzMwMjQ5LCJwaHMiOnt9LCJpYXQiOjE2NTQxNDYyNDh9.yF4d_-X_86IDCrXuN0YZzTRBbajhD_ShhnImaxC1gm4',
    });

    if (res.statusCode == 200) {
      // success
      var response = json.decode(res.body);
      List<dynamic> gwList = response["assessmentWrappers"];
      List list = [];

    for (var elementlist in gwList) {
      var gw = AssessmentWrappers.fromJson(elementlist);
      // print(gw.tags);




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
      print(listData);
      listData = [];
    }




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
    // getWrappers();
    return Container();
  }
}
