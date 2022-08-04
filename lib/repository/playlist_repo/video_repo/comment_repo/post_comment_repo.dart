//post comment with comment text or id

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../constants/strings.dart';
import '../../../../helper/sharedPref.dart';
import '../../../../model/playlist_model/video_model/comment/post_comment.dart';

class PostCommentRepo{

  Future<PostComment> uploadComment(String title, String id) async {

    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse(Strings.commentPostUrl);
    var response = await http.post(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    },
      body: jsonEncode(<String, String>{
        'text': title,
        'videoId' : id,
      }),
    );

    if (response.statusCode == 201) {
      return PostComment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Post Comment.');
    }
  }
}