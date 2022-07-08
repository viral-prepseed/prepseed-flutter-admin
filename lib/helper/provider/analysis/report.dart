import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../constants/strings.dart';
import '../../../model/assesments/reports.dart';
import '../../sharedPref.dart';
class ReportClass extends ChangeNotifier {

  bool isLoading = false;
  List<Map> allList = [];
  List testNames = [];

  List<Map> get listOfColumns => allList;

  set listOfColumns(List<Map> value) {
    allList = value;

    isLoading = false;
    notifyListeners();
  }

  getReportsAPI() async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.reports;

    // print(url);
    // try {
    var response = await http.get(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer $token',
        });

    var responseJson = json.decode(response.body);
    // print(response.statusCode);
    if (200 == response.statusCode) {

      Report _reports = Report.fromJson(responseJson);

      List<Map> _listOfColumns = [];
      List _repAllList = [];
      List finalListData = [];
      Map finalMapData = {};

      Map mapUserSelf = {};
      Map mapTopperHigh = {};
      Map mapStatsAvg = {};
      // Map mapStatsPercentile = {};
      Map allMarksSelf = {};
      Map allMarksHigh = {};
      Map allMarksAvg = {};
      Map allMaxCP = {};

      for(var rep in _reports.items!){
        List listData = rep.user!.toJson().keys.toList();
        rep.details!.forEach((element) {
          _repAllList.add(element.toJson());
          finalMapData['Name'] = element.name;
          finalMapData['Date'] = element.availableFrom;
        }
        );


        mapUserSelf = rep.user!.toJson();
        mapTopperHigh = rep.topper!.toJson();
        mapStatsAvg = rep.statsBySection!.toJson();
        // print(mapStatsAvg);


        for(var elements in mapUserSelf.keys){
          // allMarksSelf = {elements : mapUserSelf[elements]};
          allMarksSelf[elements] = Overall.fromJson(mapUserSelf[elements]).marks;
        }


        for(var elements in mapStatsAvg.keys){
          // allMarksHigh = {elements : mapTopperHigh[elements]};
          allMarksHigh[elements] = StatsBySectionOverall.fromJson(mapStatsAvg[elements]).highestMarks;
        }

        for(var elements in mapStatsAvg.keys){
          // allMarksAvg = {elements : StatsBySectionOverall.fromJson(mapStatsAvg[elements]).averageMarks};
          allMarksAvg[elements] = StatsBySectionOverall.fromJson(mapStatsAvg[elements]).averageMarks;
        }

        for(var elements in mapStatsAvg.keys){
          // allMarksAvg = {elements : StatsBySectionOverall.fromJson(mapStatsAvg[elements]).averageMarks};
          allMaxCP[elements] = StatsBySectionOverall.fromJson(mapStatsAvg[elements]).percentile;
        }


        listData.forEach((element) {
          allMarksSelf.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
            }
          });

          allMarksHigh.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
              // finalMapData[key] = value;
            }
          });
          /*finalMapData[element] = finalListData;
          finalListData = [];*/
          allMarksAvg.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
              // finalMapData[key] = value;
            }
          });
          finalMapData[element] = finalListData;

          finalListData = [];
        });
        _listOfColumns.add(finalMapData);
        // print(_listOfColumns);
        finalMapData = {};
        // print(finalMapData);
      }



      listOfColumns = _listOfColumns;



/*      print(allMarksSelf);
      print(allMarksHigh);
      print(allMarksAvg);
      print(allMaxCP);
      print(_repAllList);*/



      /*mapUser.forEach((key, value) {
        allMarks = {keys : value['marks']};
        print(allMarks);
      });*/

      // allReportsList = _repAllList;


    } else {
      return [];
    }
/*    } catch (e) {
      print(e);
      return [];
    }*/
  }

}