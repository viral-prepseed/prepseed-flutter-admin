import 'package:prepseed/model/usertopics.dart';


class functions{
  void getObjectsById(dynamic list, String topicId){
    List<Topics> listObj = [];
    for (var elementlist in list['topics']) {
      var usertopics = Topics.fromJson(elementlist);
      if(usertopics.sId == topicId){
        listObj.add(usertopics);
      }
    }
    print(listObj.first.name);
  }
}