//get the videos with id

import 'dart:convert';

import '../../../constant/strings/string.dart';
import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import 'package:http/http.dart' as http;

class VideoRepo {

  Future<VideoPlaylistModel>getVideoPlaylist(String id) async {

    VideoPlaylistModel _model;
    var url = Uri.parse(StringValue.playlistUrl + id);
    var response = await http.get(url, headers:StringValue().header);
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