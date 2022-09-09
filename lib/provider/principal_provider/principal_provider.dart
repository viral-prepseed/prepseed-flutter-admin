
import 'package:flutter/foundation.dart';
import 'package:prepsed_principal/models/UsersModel/users_model.dart';
import 'package:prepsed_principal/repository/repository_data.dart';

class PrincipalProvider with ChangeNotifier {

  List<UsersModel>? userModel;
  PrincipalRepo principalRepo = PrincipalRepo();

  void getData() async {
    userModel = await principalRepo.getData();
    if (kDebugMode) {
      print(userModel);
    }
    notifyListeners();
  }

}

