//upload assignment

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants/strings/string.dart';
import '../../../helper/sharedPref.dart';
import '../../../model/playlist_model/assignment_model/upload_assi_model.dart';

class UploadAssignmentRepo {

  Future<UploadAssignmentModel> assignmentUpload(String filename, String mime) async {

    UploadAssignmentModel _model;
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse(StringValue.assignmentUploadUrl);
    var response = await http.post(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    },
      body: jsonEncode(<String, String>{
        'filename': filename,
        'mime' : mime,
      }),
    );
    if (response.statusCode == 200) {
      _model = UploadAssignmentModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to upload Assignment.');
    }
    return _model;
  }
}