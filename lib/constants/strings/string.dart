
import 'dart:core';
import 'dart:core';

import '../../helper/sharedPref.dart';

class StringValue {

  //playlist url
  static String playlistUrl = 'https://napi.prepseed.com/video/playlists/';

  static String videoUrl = "https://napi.prepseed.com/video/playlist/";
  //comment url
  static String commentUrl = "https://napi.prepseed.com/video/comments?videoId=";

  //token value
  // static String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNjI0MTE5Y2RmYjdkMWM5NDhhYzc5OSIsInJvbGUiOiJ1c2VyIiwiZXhwIjoxNjYzNDQzMzAzLCJwaHMiOnt9LCJpYXQiOjE2NTgyNTkzMDJ9.jEKLAsYNkuIpYdfR5wWxLFeuuUMRJfukKcj5tWCJtQA';

  //upload assignment url
  static String assignmentUploadUrl = 'https://napi.prepseed.com/assignment/public/uploadPolicy';

  //post the comment url
  static String commentPostUrl = 'https://napi.prepseed.com/video/comment';

  static String announcementUrl = 'https://napi.prepseed.com/announcement/user/of-phase/';

/*  static String token =
  sharedPref().getSharedPref('token').then((result){
    token = result;
  });*/
/*  Future.delayed(Duration.zero, () async {

  });

  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'authorization': 'Bearer ' + token,
  };*/
}