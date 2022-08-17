import 'dart:convert';

import '../../../model/userDetails/topics.dart';
import '../../sharedPref.dart';

class FuncTopics{

  Future<List<TopicsList>> getObjectsById( String topicId) async{
    List<TopicsList> listObj = [];
    var datalist = await sharedPref().getSharedPref('topics');
    var list = json.decode(datalist);
    // print(topicId);
    for (var elementlist in list) {
      var usertopics = TopicsList.fromJson(elementlist);
      if(usertopics.sId!.contains(topicId)){
        listObj.add(usertopics);
      }else{
        // print(usertopics.name);
      }
    }
    // print(listObj.length);
    return listObj;
  }

  Future<List<TopicsList>> getObjects() async{
    List<TopicsList> listObj = [];
    var datalist = await sharedPref().getSharedPref('topics');
    var list = json.decode(datalist);
    // print(topicId);
    for (var elementlist in list) {
      var usertopics = TopicsList.fromJson(elementlist);
      listObj.add(usertopics);
    }
    // print(listObj.length);
    return listObj;
  }
  
}