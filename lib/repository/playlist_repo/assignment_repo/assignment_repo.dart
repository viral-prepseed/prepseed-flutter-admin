//get the assignments with id

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants/strings.dart';
import '../../../helper/sharedPref.dart';
import '../../../model/playlist_model/assignment_model/assignment_model.dart';

class AssignmentRepo {

  Future<AssignmentModel>getAssignments(String id) async {

    AssignmentModel _model;
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse(Strings.videoUrl + id);
    var response = await http.get(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      _model = AssignmentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Assignments');
    }
    return _model;
  }
}