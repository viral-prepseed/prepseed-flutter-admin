//get the comment with id

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../constants/strings/string.dart';
import '../../../../helper/sharedPref.dart';
import '../../../../model/playlist_model/video_model/comment/comment_model.dart';

class CommentRepo{

  Future<CommentModel>getComment(String id) async {


    CommentModel _model;
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse(StringValue.commentUrl + id);
    var response = await http.get(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    },);
    if (response.statusCode == 200) {
      /*  _model = List<playlist_model>.from(
          json.decode(response.body).map((x) => playlist_model.fromJson(x))).toList();
    */
      _model = CommentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load comment');
    }
    //print(_model);
    return _model;
  }
}