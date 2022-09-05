import 'package:flutter/cupertino.dart';
import 'package:prepseed/model/execute/tests/practice/close_session.dart';
import 'package:prepseed/model/execute/tests/practice/getanswer.dart';
import 'package:prepseed/model/execute/tests/practice/getquestion.dart';
import 'package:prepseed/repository/playlist_repo/practice_repo.dart';

class GetQuestionProvider extends ChangeNotifier{
  GetQuestion? getQuestionModel;
  GetQuestionRepo getQuestionRepo = GetQuestionRepo();
  SessionProgress? sessionProgress;
  dynamic endQuestion;

  getQuestion(String id,String name) async {
     await getQuestionRepo.getQuestions(id, name);
     sessionProgress =  getQuestionRepo.closeSessionModel!;
     getQuestionModel = getQuestionRepo.model;
     endQuestion = getQuestionRepo.endQuestion;
     print(getQuestionModel);
    print(sessionProgress);
    notifyListeners();
  }

  getQuestionApiWithIndex(dynamic index) async {
    await getQuestionRepo.getQuestionApiWithIndex(index);
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
}