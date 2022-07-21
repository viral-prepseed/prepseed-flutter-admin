//get the assignments with id

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constant/strings/string.dart';
import '../../../model/playlist_model/assignment_model/assignment_model.dart';

class AssignmentRepo {

  Future<AssignmentModel>getAssignments(String id) async {

    AssignmentModel _model;
    var url = Uri.parse(StringValue.playlistUrl + id);
    var response = await http.get(url, headers:StringValue().header);
    if (response.statusCode == 200) {
      _model = AssignmentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Assignments');
    }
    return _model;
  }
}