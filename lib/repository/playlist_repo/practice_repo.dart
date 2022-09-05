//get the Questions with id

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../constants/strings.dart';

import '../../../helper/sharedPref.dart';
import '../../../model/execute/tests/practice/getquestion.dart';
import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import 'package:http/http.dart' as http;
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../constants/common/imageurl.dart';
import '../../model/execute/tests/practice/close_session.dart';
import '../../model/execute/tests/practice/getanswer.dart';

class GetQuestionRepo {

  SessionProgress? closeSessionModel;
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
      var data = json.decode(response.body);
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
      }
      else{
        print('Not String');

      }
      model = GetQuestion.fromJson(data);
    }
    else if(response.statusCode == 422) {
      final isImageUrl = RegExp(r'data:image/(.+?);base64');
      closeSessionModel = SessionProgress.fromJson(json.decode(response.body));
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
        }
        else{
          print('Not String');

        }
        if(data['question']['core']['content']['rawContent']['entityMap'].runtimeType == String){
          print('isString');
          data['question']['core']['options'].forEach((element){
            element['content']['rawContent'] =  json.decode( element['content']['rawContent']);
          });
        }
        else{
          print('Not String');

        }
        print(data);
        if(data['question']['core']['content']['rawContent']['entityMap'] != null && data['question']['core']['content']['rawContent']['entityMap'].length != 0) {
          if (data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]
              .keys.toString() == "(content)") {
            data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]["content"] =
            data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]["content"];
          }
          else{
            data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]["content"] = null;
          }

          if(isImageUrl.hasMatch(data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]["url"]) == true){
            data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]["url"] = networkImageToBase64(data['question']['core']['content']['rawContent']['entityMap']["0"]["data"]["url"]);
          }
        }



        model = GetQuestion.fromJson(data);
       // model.question.core.content.rawContent.runtimeType == String;
      }
      else if(resp.statusCode == 422){
        closeSession();
      }
    }
    else{
      throw Exception('Failed to Get Questions');
    }
    return model;

  }
  closeSession() async {
    var token = await sharedPref().getSharedPref('token');
    //closeSessionModel = CloseSession.fromJson(decode);
    SessionProgress modelCloseSession = SessionProgress();
    var url = Uri.parse("https://napi.prepseed.com/session/end?id="+"${closeSessionModel!.sessionId}");
    var resp = await http.post(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    });
    if(resp.statusCode == 200){
      modelCloseSession = SessionProgress.fromJson(json.decode(resp.body));
    }
    return modelCloseSession;
  }

  GetAnswer getAnswers = GetAnswer();
  getAnswer(String ansId, String queId) async {
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse("https://napi.prepseed.com/session/answer?id=${closeSessionModel!.sessionId}");
    var resp = await http.post(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    },
    body: jsonEncode({
        "answer": ansId,
        "questionId": queId
    }),
    );
      if (resp.statusCode == 200) {
        var data = json.decode(resp.body);
        if(data['question']['core']['solution']['rawContent'].runtimeType == String){
          print('isString');
          data['question']['core']['solution']['rawContent'] = json.decode(data['question']['core']['solution']['rawContent']);
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

        if(data['question']['core']['solution']['rawContent']["entityMap"] != null && data['question']['core']['solution']['rawContent']["entityMap"].length != 0){
          /*if(){

          }*/
        DataUrl ans = DataUrl.fromJson(data['question']['core']['solution']['rawContent']["entityMap"]["0"]["data"]);
        print(ans);
        }

        getAnswers = GetAnswer.fromJson(data);
        // model.question.core.content.rawContent.runtimeType == String;
      }
    return getAnswers;

  }
}