//get the videos with id

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../constants/strings.dart';

import '../../../helper/sharedPref.dart';
import '../../../model/execute/tests/practice/getquestion.dart';
import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import 'package:http/http.dart' as http;
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../model/execute/tests/practice/close_session.dart';

class GetQuestionRepo {

  CloseSession? closeSessionModel;
  GetQuestion? model;
  getQuestions(String id) async {
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse("https://napi.prepseed.com/session/new");
    var response = await http.post(url,headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    },
      body: jsonEncode({
        "filters":[
          {
            "subTopic": id
          }
        ],
      }),
    );
    if (response.statusCode == 200) {
      model = GetQuestion.fromJson(json.decode(response.body));
    } else if(response.statusCode == 422) {
      //getSession(json.decode(response.body));
      closeSessionModel = CloseSession.fromJson(json.decode(response.body));
      var url = Uri.parse("https://napi.prepseed.com/session/newQuestion?id="+"${closeSessionModel!.sessionId}");
      var resp = await http.get(url, headers: {
        'Content-type' : 'application/json',
        'authorization': 'Bearer $token',
      });
      if (resp.statusCode == 200) {
        var data = json.decode(resp.body);
        if(data['question']['core']['content']['rawContent'].runtimeType == String){
          print('isString');
          data['question']['core']['content']['rawContent'] = json.decode(data['question']['core']['content']['rawContent']);
        }
        else{
          print('Not String');

        }
        if(data['question']['core']['options'][0]['content']['rawContent'].runtimeType == String){
          print('isString');
          data['question']['core']['options'].forEach((element){
            element['content']['rawContent'] =  json.decode( element['content']['rawContent']);
          });
          // data['question']['core']['options']['content']['rawContent'] = json.decode(data['question']['core']['options']['content']['rawContent']);
        }
        else{
          print('Not String');

        }
        print(data);
        model = GetQuestion.fromJson(data);

       // model.question.core.content.rawContent.runtimeType == String;
      }
      print(model);
    }
    else{
      throw Exception('Failed to Get Questions');
    }
    return model;

  }
  closeSession() async {
    var token = await sharedPref().getSharedPref('token');
    //closeSessionModel = CloseSession.fromJson(decode);
    CloseSession modelCloseSession = CloseSession();
    var url = Uri.parse("https://napi.prepseed.com/session/end?id="+"${closeSessionModel!.sessionId}");
    var resp = await http.post(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    });
    if(resp.statusCode == 200){
      modelCloseSession = CloseSession.fromJson(json.decode(resp.body));
    }
    print(resp);
    return modelCloseSession;
  }
}