//upload assignment

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constant/strings/string.dart';
import '../../../model/playlist_model/assignment_model/upload_assi_model.dart';

class UploadAssignmentRepo {

  Future<UploadAssignmentModel> assignmentUpload(String filename, String mime) async {

    UploadAssignmentModel _model;
    var url = Uri.parse(StringValue.assignmentUploadUrl);
    var response = await http.post(url, headers: StringValue().header,
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