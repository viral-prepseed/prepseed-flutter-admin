import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:prepseed/model/getAnalysis/submission.dart';
import 'package:prepseed/model/getwrapper.dart';
import 'package:prepseed/views/learn/assignments.dart';

import '../../constants/strings.dart';
import '../../model/getAnalysis/analysis.dart';
import '../../model/list_questions.dart';
import '../../views/execute/test/viewAnalysis.dart';
import '../sharedPref.dart';
class AnalysisClass extends ChangeNotifier {

  bool isLoading = false; //loading parameter
  List<metaSections> post = [];
  List<GASections> postList = [];
  List<Roadmap> roadmapList = [];
  List<ChartSampleData> chartList = [];
  List TabValues = [];
  GAMeta? metaData;
  List<AssessmentWrappers> TabContainList = [];
  Map<dynamic, dynamic> TabContainMap = {};
  List<metaSections> get listData => post;
  List<GASections> get sectionList => postList;
  List<Roadmap> get rmapList => roadmapList;
  List<ChartSampleData> get chartSampleList => chartList;
  var maxMarks = 0;
  var marksObtained = 0;
  var overallRank = 0;
  var percentile = 0;
  var questionsAttempted = 0;
  var correctQuestions = 0;
  var incorrectQuestions = 0;
  var correctTime;
  var incorrectTime;
  var unattemptedTime;
  var precision;
  var marksAttempted;
  var marksGained;
  var marksLost;

  Map<dynamic, dynamic> get tabContains => TabContainMap;

  get totalMarks => maxMarks;
  set totalMarks(dynamic marks){
    maxMarks = marks;
  }

  GAMeta? get alldatas => metaData;
  set setData(GAMeta meta){
    metaData = meta;
    notifyListeners();
  }

  set sectionList(List<GASections> value) {
    postList = value;

    isLoading = false;
    notifyListeners();
  }

  set roadmaplist(List<Roadmap> value) {
    roadmapList = value;

    isLoading = false;
    notifyListeners();
  }
  set chartlist(List<ChartSampleData> value) {
    chartList = value;

    isLoading = false;
    notifyListeners();
  }

  set listData(List<metaSections> value) {
    post = value;

    isLoading = false;
    notifyListeners();
  }

  ProviderClass() {
    post = [];
  }

  Future<List<metaSections>> apiCall(userId,wrapperId) async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getAnalysis;
    var bodydata = {
      "fetchSubmission": true,
      "userId": userId,
      "wrapperId": wrapperId
    };
    // try {
      var response = await http.post(Uri.parse(url),
          headers: {
            'Content-type' : 'application/json',
            'authorization': 'Bearer $token',
          },
          body: json.encode(bodydata));
      if (200 == response.statusCode) {
        // print(response.body);


        List<GASections>? gafilesList = [];
        List<Roadmap>? _roadmaplist = [];
        var responseJson = json.decode(response.body);

        GASubmission submission = GASubmission.fromJson(responseJson['submission']);
        for (var element in submission.meta!.sections!) {
          gafilesList.add(element);
        }
        sectionList = gafilesList;

        List<ChartSampleData> _chartlist = [];
        for (var element in submission.roadmap!) {
          _roadmaplist.add(element);
          if(element.timeCategory == 'perfect' ){ //&& element.result == 0
            _chartlist.add(ChartSampleData(x: (element.lastVisit/60000), y: element.totalTime, yValue: -0.03, secondSeriesYValue: 0.10,
                text: '${(element.questionNo!)}'),);
          }
        }
        roadmaplist = _roadmaplist;
        chartlist = _chartlist;



        var coreobj = CoreAnalysis_main.fromJson(responseJson['coreAnalysis']);
        totalMarks = coreobj.maxMarks;
        List<metaSections>? filesList = [];
        var resbodyWrapper = Analysis.fromJson(responseJson);
        setData = GAMeta.fromJson(responseJson['submission']['meta']);
        // print(resbodyWrapper.assessmentWrappers!.length);

        /*for (var element in resbodyWrapper.submission.ro) {
          filesList.add(element);
        }*/
        // print(resbodyWrapper.submission!.meta!.marks);
        listData = filesList;
        return listData;
      } else {
        return [];
      }
/*    } catch (e) {
      print(e);
      return [];
    }*/
  }
}