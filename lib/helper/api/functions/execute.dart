

import 'dart:convert';
import '../../../constants/strings.dart';
import '../../sharedPref.dart';
import 'package:http/http.dart' as http;

class executeFunc{
//test
  assignment() async {
    var token = await sharedPref().getSharedPref('token');
    // var token = await sharedPref().getSharedPref('token');
    var assessmentWrapperId = await sharedPref().getSharedPref('assessmentWrapperId');
    var url = Strings.listQuestions+'/'+assessmentWrapperId;
    print(assessmentWrapperId);
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    return res;
  }


}