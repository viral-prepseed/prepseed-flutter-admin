import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:prepseed/constants/strings.dart';
import 'package:prepseed/model/stats_analysis_model/reports/videos_attendance.dart';

import '../../sharedPref.dart';


class VideoAttendanceProviderClass extends ChangeNotifier {

  bool isLoading = false; //loading parameter
  List<Items> post = []; // videos_attendance empty parameter
  int _count = 1; // dummy parameter to check working!!
  int get count => _count; //to set value for _count
  List<Items> get listData => post; //to set value for post


  set listData(List<Items> value) {
    //function to update list data and notify
    post = value;
    isLoading = false;
    notifyListeners();
  }

  Future<List<Items>> apiCall() async {
    //function to call API using Http package
    var phaseId = await sharedPref().getSharedPref('phaseId');
    String url = Strings.videoAttendance+'/628c8a6d7640243d911a6cc6';//+phaseId;
    // try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      // var resp = json.decode(response.body)['items'];
      if (200 == response.statusCode) {
        final List<Items> lst = [];
        // print(response.body);
        final videos_attendance filesList = videos_attendance.fromJson(json.decode(response.body));
/*        if(filesList.items != null){
          if(filesList.items!.first.resourceModel == "Video"){
            listData.addAll(filesList.items!);
          }
        }*/
        print(filesList.items);
        return lst;
      } else {
        return [];
      }
/*    } catch (e) {
      print(e);
      return [];
    }*/
  }
}