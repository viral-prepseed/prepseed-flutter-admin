import 'dart:convert';

import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/model/execute/tests/list_questions.dart';
import 'package:prepseed/model/usertopics.dart';

import '../../constants/strings.dart';
import 'package:http/http.dart' as http;


class functions{


  /*============================== Convert to Letx ==============================*/

  convertLetX(String text){
    var count = text.length - text.replaceAll("\$","").length;
    // print(count);
    // String _text = text.replaceAll(r'\+', r'\');
    // replaceData(_text);
    String _response = text;
    for(int i=0; i<=count/2; i++){
      _response = replaceData(_response);
    }

/*  String _response = replaceData(_text);
  if(_response != null){
    if(_response.contains(r'$')){
      return replaceData(_response);
    }else{
      return _response;
    }
  }*/
    return _response;
  }

  replaceData(String replaceableText){
    String? _textData;
    String? _text_sec_Data;
    // if(replaceableText.contains(r'$')){
    _textData = replaceableText.replaceFirst('\$', r'\(');
    _text_sec_Data = _textData.replaceFirst('\$', r'\)');
    // convertLetX(_text_sec_Data);
    // replaceData(_text_sec_Data);
    // }else{}
/*
    // print(_text_sec_Data);
    if(_text_sec_Data != null){
      if(_text_sec_Data.contains('\$')){
        return _text_sec_Data;
      }else{
        // print(_text_sec_Data);
        return _text_sec_Data;
      }
    }*/
    return _text_sec_Data;
  }

  /*============================== TOPIC ==============================*/

  Future<List<Topics>> getObjectsById(String topicId) async{
    List<Topics> listObj = [];
    var datalist = await sharedPref().getSharedPref('topics');
    var list = json.decode(datalist);
    // print(topicId);
    for (var elementlist in list) {
      var usertopics = Topics.fromJson(elementlist);
      if(usertopics.sId!.contains(topicId)){
        listObj.add(usertopics);
      }else{
        // print(usertopics.name);
      }
    }
    // print(listObj.length);
      return listObj;
  }

  Future<List<SubTopicsUsr>> getObjectsBySubId(String topicId, String subtopicId) async{
    List<SubTopicsUsr> listObj = [];
    var datalist = await sharedPref().getSharedPref('topics');
    var topicsObj;
    var list;
    for(var topicEle in json.decode(datalist)){
      topicsObj = Topics.fromJson((topicEle));
      if(topicsObj.sId == topicId){
        list = topicsObj.subTopics;
      }
    }

    if(list != null){
      for (var elementlist in list) {
        // print(elementlist);
        // var usertopics = SubTopicsUsr.fromJson(elementlist);
        if(elementlist.sId!.contains(subtopicId)){
          listObj.add(elementlist);
          // print(usertopics.name);
        }else{
          // print(usertopics.name);
        }
      }
    }

    return listObj;
  }




  postFlowLogs(Map<dynamic, dynamic> postmap) async{
    String apiurl = Strings.syncFlow;

    var bodydata = postmap;
    var token = await sharedPref().getSharedPref('token');

    var response = await http.post(Uri.parse(apiurl),
        headers: {
          'Content-type' : 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode(bodydata));

    if(response.body.isNotEmpty) {
      var jsondatas = (response.body);
      print(jsondatas);
    }
    if(response.statusCode == 200){

    }else{
      print('Something went wrong.....!!!!');
    }
  }

  assessmentApiCall(qId) async {
    var token = await sharedPref().getSharedPref('token');
    var phaseId = qId;
    var url = Strings.listQuestions+'/'+phaseId;
    // print(url);
    try {
      final res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer $token',
      });
      var responseJson = json.decode(res.body);
      if (200 == res.statusCode) {
        return responseJson;
      } else if (422 == res.statusCode)  {
        return responseJson;
      }
    } catch (e) {
      print(e);
      // return [];
    }
  }

  Future<String> getWrapperApiCall(qId) async {

    var resp = await assessmentApiCall(qId);

    if(resp['success'] ==  false){
      return 'View Analysis';
    }else{
      return 'Attempt';
    }

  }

}