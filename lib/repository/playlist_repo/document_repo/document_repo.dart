//get the Resource Documents

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants/strings/string.dart';
import '../../../helper/sharedPref.dart';
import '../../../model/playlist_model/document_model/resource_document_model.dart';

class DocumentRepo {

  Future<ResourceDocumentsModel>getResourceDocuments(String id) async {

    ResourceDocumentsModel _model;
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse(StringValue.playlistUrl + id);
    var response = await http.get(url,
      headers: {
        'Content-type' : 'application/json',
        'authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      _model = ResourceDocumentsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Documents');
    }
    return _model;
  }

}