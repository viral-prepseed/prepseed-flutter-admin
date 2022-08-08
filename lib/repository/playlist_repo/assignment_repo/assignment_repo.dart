//get the assignments with id

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../../constants/strings.dart';
import '../../../helper/sharedPref.dart';
import '../../../model/playlist_model/assignment_model/assignment_model.dart';

class AssignmentRepo {

  Future<AssignmentModel>getAssignments(String id) async {

    AssignmentModel _model;
    var isCachedExist = await APICacheManager().isAPICacheKeyExist("API_assignmentList");

    if(!isCachedExist){
      var token = await sharedPref().getSharedPref('token');
      var url = Uri.parse(Strings.videoUrl + id);
      var response = await http.get(url, headers: {
        'Content-type' : 'application/json',
        'authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("URLa: HIT");
        APICacheDBModel cacheDBModel = APICacheDBModel(key: "API_assignmentList", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        _model = AssignmentModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Assignments');
      }
      return _model;
    }else{
      var cacheData = await APICacheManager().getCacheData("API_videos");
      _model = AssignmentModel.fromJson(json.decode(cacheData.syncData));
      print("CACHEa: HIT");
      return _model;
    }

  }
}