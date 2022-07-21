//get the videos with id

import 'dart:convert';

import '../../../constants/strings/string.dart';
import '../../../helper/sharedPref.dart';
import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import 'package:http/http.dart' as http;

class VideoRepo {

  Future<VideoPlaylistModel>getVideoPlaylist(String id) async {

    VideoPlaylistModel _model;
    var token = await sharedPref().getSharedPref('token');
    var url = Uri.parse(StringValue.playlistUrl + id);
    var response = await http.get(url,headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    },);
    if (response.statusCode == 200) {
      /*  _model = List<playlist_model>.from(
          json.decode(response.body).map((x) => playlist_model.fromJson(x))).toList();
    */
      _model = VideoPlaylistModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load videos');
    }
    //print(_model);
    return _model;
  }

}