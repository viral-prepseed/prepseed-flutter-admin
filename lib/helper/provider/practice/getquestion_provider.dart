import 'package:flutter/cupertino.dart';
import 'package:prepseed/model/execute/tests/practice/close_session.dart';
import 'package:prepseed/model/execute/tests/practice/getanswer.dart';
import 'package:prepseed/model/execute/tests/practice/getquestion.dart';
import 'package:prepseed/repository/playlist_repo/practice_repo.dart';

class GetQuestionProvider extends ChangeNotifier{
  GetQuestion getQuestionModel = GetQuestion();
  GetQuestionRepo getQuestionRepo = GetQuestionRepo();
  dynamic sessionProgress;

  getQuestion(String id) async {
     getQuestionModel =  await getQuestionRepo.getQuestions(id);
     sessionProgress =  getQuestionRepo.closeSessionModel;
    print(sessionProgress);
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
}