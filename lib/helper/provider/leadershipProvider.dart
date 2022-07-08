import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prepseed/model/getAnalysis/submission.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';
import 'package:prepseed/model/leaderboard/phase_user.dart';
import 'package:prepseed/model/leaderboard/ranks.dart';
import 'package:prepseed/views/learn/assignments.dart';
import 'package:prepseed/views/stats_analysis/analysis/leaderboard.dart';

import '../../constants/strings.dart';
import '../../model/getAnalysis/analysis.dart';
import '../../model/list_questions.dart';
import '../../views/execute/test/viewAnalysis.dart';
import '../sharedPref.dart';
class LeadershipClass extends ChangeNotifier {

  bool isLoading = false; //loading parameter
  getRanks? post;
  List<Leaderboard>? LeaderboardPost;
  List<GASections> postList = [];
  List<Roadmap> roadmapList = [];
  List<ChartSampleData> chartList = [];
  List TabValues = [];
  GAMeta? metaData;
  List<AssessmentWrappers> TabContainList = [];
  Map<dynamic, dynamic> TabContainMap = {};
  getRanks? get listData => post;
  List<Leaderboard>? get leaderBoardData => LeaderboardPost;


  set listData(getRanks? value) {
    post = value;

    isLoading = false;
    notifyListeners();
  }

  set leaderBoardData(List<Leaderboard>? value) {
    LeaderboardPost = value;

    isLoading = false;
    notifyListeners();
  }

  Future<getRanks?> apiCall() async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getranks+'?phase='+phaseId;

    // print(url);
    // try {
    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });


    if (200 == response.statusCode) {
      var responseJson = json.decode(response.body);
      getRanks ranks = getRanks.fromJson(responseJson);
      // print(responseJson);
      listData = ranks;

      await leaderBoard();
      return listData;

    } else {
      // return [];
    }
/*    } catch (e) {
      print(e);
      return [];
    }*/
  }

  Future<getRanks?> leaderBoard() async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getPhaseLeaderBoard+'/'+phaseId;

    // print(url);
    // try {
    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });


    if (200 == response.statusCode) {
      var responseJson = json.decode(response.body);
      PhaseLeaderboard phaseLeaderboard = PhaseLeaderboard.fromJson(responseJson);
      // print(responseJson);

      List<Leaderboard> _leaderboard = [];
      for(var element in phaseLeaderboard.leaderboard!){
        _leaderboard.add(element);
      }
      leaderBoardData = _leaderboard;

      return listData;

    } else {
      // return [];
    }
/*    } catch (e) {
      print(e);
      return [];
    }*/
  }




}