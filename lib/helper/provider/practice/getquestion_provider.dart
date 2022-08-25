import 'package:flutter/cupertino.dart';
import 'package:prepseed/model/execute/tests/practice/close_session.dart';
import 'package:prepseed/model/execute/tests/practice/getquestion.dart';
import 'package:prepseed/repository/playlist_repo/practice_repo.dart';

class GetQuestionProvider extends ChangeNotifier{
  GetQuestion getQuestionModel = GetQuestion();
  GetQuestionRepo getQuestionRepo = GetQuestionRepo();
  getQuestion(String id) async {
    getQuestionModel = await getQuestionRepo.getQuestions(id);
    print(getQuestionModel);
    notifyListeners();
  }
  CloseSession closeSession = CloseSession();
  closeQuestions() async {

    closeSession = await getQuestionRepo.closeSession();
    print(closeSession);
    notifyListeners();
  }
}