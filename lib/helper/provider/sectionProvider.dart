/*
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:prepseed/model/getwrapper.dart';
import 'package:prepseed/views/learn/assignments.dart';

import '../../constants/strings.dart';
import '../../model/list_questions.dart';
import '../sharedPref.dart';
class sectionProviderClass extends ChangeNotifier {

  bool isLoading = false; //loading parameter
  List<Sections> post = [];
  List TabValues = [];
  List<AssessmentWrappers> TabContainList = [];
  Map<dynamic, dynamic> TabContainMap = {};
  List<Sections> get listData => post;

  get listLength => listData.length;

  get tabLength => TabValues.toSet().toList().length;
  get tabValues => TabValues.toSet().toList();

*/
/*  get tabLength => TabValues.toSet().toList().length;
  get tabValues => TabValues.toSet().toList();*//*


  Map<dynamic, dynamic> get tabContains => TabContainMap;


  set listData(List<Sections> value) {
    post = value;
    for (var element in value) {
      TabValues.add(element.type);
    }

    for(var tabval in TabValues){
      value.forEach((element) {
        if(element.type! == (tabval)){
          TabContainList.add(element);
        }
      });
      TabContainMap[tabval] = TabContainList;
      TabContainList = [];
    }

    isLoading = false;
    notifyListeners();
  }

  ProviderClass() {
    post = [];
  }

  Future<List<Sections>> apiCall() async {
    //function to call API using Http package
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getWrapper+'/'+phaseId;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer $token',
      });
      if (200 == response.statusCode) {
        // print(response.body);
        List<Sections>? filesList = [];
        var responseJson = json.decode(response.body);
        getwrappers resbodyWrapper = getwrappers.fromJson(responseJson);
        // print(resbodyWrapper.assessmentWrappers!.length);


        for (var element in resbodyWrapper.assessmentWrappers!) {
          filesList.add(element);
        }

        listData = filesList;
        // print(listData);
        return listData;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}*/
