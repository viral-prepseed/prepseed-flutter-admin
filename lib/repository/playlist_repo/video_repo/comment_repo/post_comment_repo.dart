//post comment with comment text or id

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../constant/strings/string.dart';
import '../../../../model/playlist_model/video_model/comment/post_comment.dart';

class PostCommentRepo{

  Future<PostComment> uploadComment(String title, String id) async {

    var url = Uri.parse(StringValue.commentPostUrl);
    var response = await http.post(url, headers: StringValue().header,
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