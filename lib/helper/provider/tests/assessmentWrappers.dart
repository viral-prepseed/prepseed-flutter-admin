import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:prepseed/model/assesments/getwrapper.dart';
import '../../../constants/strings.dart';
import '../../sharedPref.dart';
class AssessmentWrappersClass extends ChangeNotifier {

  bool isLoading = false;
  List<AssessmentWrappers> aswList = [];
  List<AssessmentWrappers> aswAllList = [];
  List testNames = [];

  List<AssessmentWrappers> get listData => aswList;
  List<AssessmentWrappers> get allAswList => aswAllList;
  List get listTestNameData => testNames;
  set listData(List<AssessmentWrappers> value) {
    aswList = value;

    List _testNames = [];
    for(var element in value){
      _testNames.add(element.name);
    }
    testNames = _testNames;

    isLoading = false;
    notifyListeners();
  }

  set allAswList(List<AssessmentWrappers> value) {
    aswAllList = value;

    isLoading = false;
    notifyListeners();
  }

  getWrappersAPI() async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getWrappers+'/'+phaseId;

    // print(url);
    // try {
    var response = await http.get(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer $token',
        });

    var responseJson = json.decode(response.body);
    if (200 == response.statusCode) {

      List<dynamic> _asw =  (responseJson['assessmentWrappers']);

      List<AssessmentWrappers> _aswAllList = [];
      List<AssessmentWrappers> _aswlist = [];
      List testNameList = [];

      for(var asw in _asw){
        _aswAllList.add(AssessmentWrappers.fromJson(asw));
        testNameList.add(AssessmentWrappers.fromJson(asw).sId);
      }

      allAswList = _aswAllList;

      var apiurl = Strings.getSubmissions;
      var bodydata = {
        "wrapperIds": testNameList,
      };
      // print(json.encode(bodydata));
      var response = await http.post(Uri.parse(apiurl),
          headers: {
            'Content-type' : 'application/json',
            'authorization': 'Bearer $token',
          },
          body: json.encode(bodydata));
      if (200 == response.statusCode) {
        var responseJson = json.decode(response.body);

        Map submissionmap = responseJson['submissionMap'];
        // print(submissionmap.keys);

        for(var asw in _asw){
          if(submissionmap.containsKey(AssessmentWrappers.fromJson(asw).sId)){
            _aswlist.add(AssessmentWrappers.fromJson(asw));
          }
        }

        listData = _aswlist;

        return listData;
      } else {
        return [];
      }

      // print(listData.first.testPerformance!.correct);

    } else {
      return [];
    }
/*    } catch (e) {
      print(e);
      return [];
    }*/
  }

}