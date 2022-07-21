//get whole playlist

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:learning_module/constant/strings/string.dart';
import 'package:learning_module/model/playlist_model/playlists.dart';

class Provider{

  Future<playlist_model>getPlaylist(context) async {

    playlist_model _model;
    var url = Uri.parse(StringValue.playlistUrl);
    var response = await http.get(url, headers:StringValue().header);
    if (response.statusCode == 200) {
    /*  _model = List<playlist_model>.from(
          json.decode(response.body).map((x) => playlist_model.fromJson(x))).toList();
    */
      _model = playlist_model.fromJson(json.decode(response.body));
    }
    else if(response.statusCode == 401){
      throw Exception('UnAuthorize');
    }
    else {
      throw Exception('Failed to get Playlist');
    }
    return _model;
  }

}