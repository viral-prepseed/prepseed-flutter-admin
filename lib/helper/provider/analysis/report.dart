import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../constants/strings.dart';
import '../../../model/assesments/reports.dart';
import '../../sharedPref.dart';
class ReportClass extends ChangeNotifier {

  bool isLoading = false;
  List<Map> allList = [];
  List<Items> itemsList = [];
  List testNames = [];

  List<Map> get listOfColumns => allList;
  List<Items> get items => itemsList;

  set listOfColumns(List<Map> value) {
    allList = value;

    isLoading = false;
    notifyListeners();
  }

  set items(List<Items> value) {
    itemsList = value;

    isLoading = false;
    notifyListeners();
  }
  Report reportModel = Report();
  /*Map mapStatsMax = {};*/
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


    // print(response.statusCode);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      Report _reports = Report.fromJson(responseJson);
      List<Items>? _items = _reports.items;

      items = _items!;


      List<Map> _listOfColumns = [];
      List _repAllList = [];
      List finalListData = [];
      Map finalMapData = {};

      Map mapUserSelf = {};
      Map mapTopperHigh = {};
      Map mapStatsAvg = {};
      Map mapMax = {};

      // Map mapStatsPercentile = {};
      Map allPercentage = {};
      Map allMarksSelf = {};
      Map allMarksHigh = {};
      Map allMarksTopper = {};
      Map allMarksAvg = {};
      Map allPercentile = {};
      Map allCP = {};
      Map mapStatsMax = {};
      List listData = [];
      for(var rep in _reports.items!){
        rep.details!.forEach((element) {
          _repAllList.add(element.toJson());
          finalMapData['Name'] = element.name;
          finalMapData['Date'] = element.availableFrom;
        }
        );
        if(rep.user != null){
          listData = rep.user!.toJson().keys.toList();
          mapUserSelf = rep.user!.toJson();
        }
        mapTopperHigh = rep.topper!.toJson();
        mapStatsAvg = rep.statsBySection!.toJson();
        mapStatsMax = rep.maxMarks!.toJson();

        for(var elements in mapUserSelf.keys){
          if(mapStatsMax[elements] != null){
            var calval = (Overall.fromJson(mapUserSelf[elements]).marks! / mapStatsMax[elements]) * 100;
            allPercentage[elements] = double.parse(calval.toString()).toStringAsFixed(2);}
        }

        for(var elements in mapUserSelf.keys){
          // allMarksSelf = {elements : mapUserSelf[elements]};
          allMarksSelf[elements] = Overall.fromJson(mapUserSelf[elements]).marks;
        }

        /*   for(var elements in mapStatsMax.keys){
          mapMax[elements] = MaxMarks.fromJson(mapStatsMax[elements]).overall;
        }*/
        for(var elements in mapTopperHigh.keys){
          // allMarksSelf = {elements : mapUserSelf[elements]};
          allMarksTopper[elements] = Overall.fromJson(mapTopperHigh[elements]).marks;
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
          allPercentile[elements] = StatsBySectionOverall.fromJson(mapStatsAvg[elements]).percentile;
        }

        for(var elements in mapStatsAvg.keys){
          // allMarksAvg = {elements : StatsBySectionOverall.fromJson(mapStatsAvg[elements]).averageMarks};
          allCP[elements] = StatsBySectionOverall.fromJson(mapStatsAvg[elements]).cumulativePercentile;
        }


        listData.forEach((element) {
          allMarksSelf.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
            }
          });
          allCP.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
            }
          });
          mapStatsMax.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
            }
          });
          /* allMarksHigh.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
              // finalMapData[key] = value;
            }
          });*/
          /*finalMapData[element] = finalListData;
          finalListData = [];*/
          allMarksAvg.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
              // finalMapData[key] = value;
            }
          });
          allMarksHigh.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
            }
          });
          allMarksTopper.forEach((key, value) {
            if(key == element){
              finalListData.add(value);
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
     /* print(allMarksSelf);
      print(allPercentage);
      print(allMarksAvg);
      print(allMarksHigh);
      print(allMarksTopper);
      print(allPercentile);
      print(allCP);
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