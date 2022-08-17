import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prepseed/helper/api/functions.dart';
import 'package:prepseed/model/getAnalysis/submission.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';
import 'package:prepseed/model/userDetails/stats.dart';
import 'package:prepseed/model/userDetails/topics.dart';
import 'package:prepseed/model/usertopics.dart';
import 'package:prepseed/views/learn/assignments.dart';

import '../../constants/strings.dart';
import '../../model/getAnalysis/analysis.dart';
import '../../model/execute/tests/list_questions.dart';
import '../../views/execute/test/viewAnalysis.dart';
import '../api/functions/topics.dart';
import '../sharedPref.dart';
class UserClass extends ChangeNotifier {

  bool isLoading = false; //loading parameter
  List<US_Topics> post = [];
  List<List<TopicsList>> topicpost = [];
  List<List<TopicsList>> topicFullPost = [];
  List<GASections> postList = [];
  List<Roadmap> roadmapList = [];
  List<ChartSampleData> chartList = [];
  List TabValues = [];
  GAMeta? metaData;
  List<AssessmentWrappers> TabContainList = [];
  Map<dynamic, dynamic> TabContainMap = {};
  List<US_Topics> get listData => post;
  List<List<TopicsList>> get topicListData => topicpost;
  List<List<TopicsList>> get topicListFullData => topicFullPost;


  set listData(List<US_Topics> value) {
    post = value;

    isLoading = false;
    notifyListeners();
  }

  set topicListData(List<List<TopicsList>> value) {
    topicpost = value;

    isLoading = false;
    notifyListeners();
  }

  set topicListFullData(List<List<TopicsList>> value) {
    topicFullPost = value;

    isLoading = false;
    notifyListeners();
  }

  ProviderClass() {
    post = [];
  }

  apiCall() async {
    var datalist = await sharedPref().getSharedPref('stats');
    UserStats list = UserStats.fromJson(json.decode(datalist)) ;
    print(list.runtimeType);
    /*var userStats = US_Topics.fromJson(list);
    print(userStats);*/
    for(var elelist in list.topics!){
      listData.add((elelist));
      var value = await FuncTopics().getObjectsById(elelist.id!);
      topicListData.add(value);
    }

    var topicValue = await FuncTopics().getObjects();
    topicListFullData.add(topicValue);
    topicListFullData.toSet().toList();
    // print(topicListData.elementAt(0).elementAt(0).name);
  }

   signInApiCall(email,password) async {

    // await SubmissionDetails(userId,wrapperId);
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.signIn;
    var bodydata = {
      "user":
      {
        "email":email,
        "password": password
      },
      "portal":"preparation"
    };
    // try {
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type' : 'application/json',
        },
        body: json.encode(bodydata));

    var responseJson = json.decode(response.body);
    if (200 == response.statusCode) {
      // print(response.body);

      List<dynamic> _topics =  (responseJson['user']['stats']['topics']);

      for(var ustopic in _topics){
        listData.add(US_Topics.fromJson(ustopic));
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