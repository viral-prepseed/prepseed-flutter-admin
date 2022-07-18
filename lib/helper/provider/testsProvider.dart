import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:prepseed/model/assesments/getwrapper.dart';
import 'package:prepseed/model/questions.dart';
import 'package:prepseed/views/learn/assignments.dart';

import '../../constants/strings.dart';
import '../../model/execute/tests/list_questions.dart';
import '../sharedPref.dart';
class TestProviderClass extends ChangeNotifier {

  bool isLoading = false;
  List<AssessmentWrappers> post = [];
  list_questions? _assessment;
  List TabValues = [];
  List<QuestionClass> questions = [];
  List<AssessmentWrappers> TabContainList = [];
  Map<dynamic, dynamic> TabContainMap = {};
  Map mapTopic = {};
  List<AssessmentWrappers> get listData => post;
  list_questions get assessment => _assessment!;
  List<QuestionClass> get questionsList => questions;
  Map get listTopics => mapTopic;

  get listLength => listData.length;

  get tabLength => TabValues.toSet().toList().length;
  get tabValues => TabValues.toSet().toList();



/*  get tabLength => TabValues.toSet().toList().length;
  get tabValues => TabValues.toSet().toList();*/

  Map<dynamic, dynamic> get tabContains => TabContainMap;


  set listData(List<AssessmentWrappers> value) {
    post = value;
    for (var element in value) {
      TabValues.add(element.type);
    }

    for(var tabval in TabValues){
      value.forEach((element) {
        if(element.type! == (tabval)){
          TabContainList.add(element);
        }
      });
      TabContainMap[tabval] = TabContainList;
      TabContainList = [];
    }

    // print(TabContainMap);

    isLoading = false;
    notifyListeners();
  }

  set assessment(list_questions value) {
    _assessment = value;

    isLoading = false;
    notifyListeners();
  }

  // set mapTopic(Map value) {
  //   mapTopic = value;
  //
  //   isLoading = false;
  //   notifyListeners();
  // }

  ProviderClass() {
    post = [];
  }

  Future<List<AssessmentWrappers>> apiCall() async {
    //function to call API using Http package
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.getWrappers+'/'+phaseId;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer $token',
      });
      if (200 == response.statusCode) {
        // print(response.body);
        List<AssessmentWrappers>? filesList = [];
        var responseJson = json.decode(response.body);
        getwrappers resbodyWrapper = getwrappers.fromJson(responseJson);
        // print(resbodyWrapper.assessmentWrappers!.length);


        for (var element in resbodyWrapper.assessmentWrappers!) {
          filesList.add(element);
        }

        listData = filesList;
        // print(listData);
        return listData;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<list_questions?> assessments(assessmentWrapperId) async {
    //function to call API using Http package
    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Strings.ASSESSMENT_BASE+'/'+assessmentWrapperId;
    // try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer $token',
      });
      if (200 == response.statusCode) {
        // print(response.body);
        List<list_questions>? _assessmentList = [];
        var responseJson = json.decode(response.body);
        list_questions _listQue = list_questions.fromJson(responseJson);
        // print(_listQue.core!.sections!.elementAt(0).questions!.elementAt(0).question!.type);

        Map _mapTopic = {};
        List listType = [];



        for (var element in _listQue.core!.sections!) {
          List<QuestionClass> _questions = [];
          for (var elementQue in element.questions!) {
            print(element.questions!.length);
            List<Option> _options = [];
            // print(elementQue.question!.type);
            listType.add(elementQue.question!.type);
            var rawCont = elementQue.question!.content!.rawContent!;
            if(rawCont.runtimeType.toString() == "String"){
              rawCont = json.decode(elementQue.question!.content!.rawContent!);
            }
            if(elementQue.question!.type != "RANGE"){

              if(elementQue.question!.type == "MULTIPLE_CHOICE_MULTIPLE_CORRECT"){

                elementQue.question!.multiOptions!.forEach((multiOp) {
                  var opCont = multiOp.content['rawContent'];
                  if(opCont.runtimeType.toString() == 'String'){
                    opCont = json.decode(multiOp.content['rawContent']);
                  }
                  _options.add(Option(text: opCont['blocks'][0]['text']
                  ));
                });


              }

              if(elementQue.question!.type == "LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT"){

                for (var multiOp in elementQue.question!.options!) {
                  var opCont = multiOp.content!.rawContent;
                  if(opCont.runtimeType.toString() == 'String'){
                    opCont = json.decode(opCont);
                  }
                  _options.add(Option(text: opCont['blocks'][0]['text']
                  ));
                }
              }

              // print(questions.toList().first.text);
            }
            _questions.add(QuestionClass(
                type: elementQue.question!.type!, text: QuestionContents.fromJson(rawCont).blocks!.first.text!,
                options: _options
            ));
          }
          _mapTopic[element.name] = _questions;
        }
        // print(listType.toSet().toList());
        mapTopic = _mapTopic;
        // questions = _questions;

        assessment = _listQue;
        // print(listData);
        return _assessment;
      } else {
        // return [];
      }
/*    } catch (e) {
      print(e);
      // return [];
    }*/
  }


  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '${twoDigits(duration.inHours)} hrs';
    /*if (duration.inHours > 0)
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    else
      return "$twoDigitMinutes:$twoDigitSeconds";*/
  }
}