import 'package:flutter/cupertino.dart';
import 'package:prepseed/model/execute/tests/practice/close_session.dart';
import 'package:prepseed/model/execute/tests/practice/getanswer.dart';
import 'package:prepseed/model/execute/tests/practice/getquestion.dart';
import 'package:prepseed/repository/playlist_repo/practice_repo.dart';
import 'package:provider/provider.dart';

class GetQuestionProvider extends ChangeNotifier{
  GetQuestion? getQuestionModel;
  GetQuestionRepo getQuestionRepo = GetQuestionRepo();
  SessionProgress? sessionProgress;
  dynamic endQuestion;
  var queLength;
  getQuestion(String id,String name) async {
     await getQuestionRepo.getQuestions(id, name);
     if(getQuestionRepo.closeSessionModel != null){
     sessionProgress =  getQuestionRepo.closeSessionModel!;}
     getQuestionModel = getQuestionRepo.model;
     endQuestion = getQuestionRepo.endQuestion;
     print(getQuestionModel);
    print(sessionProgress);
    notifyListeners();
  }

  getQuestionApiWithIndex(dynamic index,int isFirst) async {
    await getQuestionRepo.getQuestionApiWithIndex(index,isFirst);
    print(queLength);
    if(getQuestionRepo.queLength != null){
      queLength = getQuestionRepo.queLength;
    }
    if(getQuestionRepo.getAnswers != null){
      getAnswers = getQuestionRepo.getAnswers;
    }
    getQuestionModel = getQuestionRepo.model;
    print(getQuestionModel);
    notifyListeners();
  }

  SessionProgress closeSession = SessionProgress();
  closeQuestions() async {
    closeSession = await getQuestionRepo.closeSession();
    print(closeSession);
    notifyListeners();
  }
  GetAnswer getAnswers = GetAnswer();
  getAnswer  (String ansId, String queId) async {
    getAnswers = await getQuestionRepo.getAnswer(ansId, queId);
    notifyListeners();
    print(getAnswers);
  }
  Map isTrue = {};
  isTrueIds(List options, String userId){
    options.forEach((element) { //element.sId == Provider.of<TestProviderClass>(context, listen: false).optionVal &&
      if(element.isCorrect == true){
        isTrue[element.sId] = "true";
      }
      else if(element.sId == userId && element.isCorrect == false){
        isTrue[element.sId] = "false";
      }
      else{
        isTrue[element.sId] = "falsefalse";
      }
    });
    return isTrue;
  }
}