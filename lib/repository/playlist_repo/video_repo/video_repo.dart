//get the videos with id

import 'dart:convert';

import '../../../constants/strings.dart';

import '../../../helper/sharedPref.dart';
import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import 'package:http/http.dart' as http;
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class VideoRepo {

  Future<VideoPlaylistModel>getVideoPlaylist(String id) async {

    var isCachedExist = await APICacheManager().isAPICacheKeyExist("API_videos");
    VideoPlaylistModel _model;

    if(!isCachedExist){
      var token = await sharedPref().getSharedPref('token');
      var url = Uri.parse(Strings.videoUrl + id);
      var response = await http.get(url,headers: {
        'Content-type' : 'application/json',
        'authorization': 'Bearer $token',
      },);
      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel = APICacheDBModel(key: "API_videos", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        _model = VideoPlaylistModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load videos');
      }

      return _model;
    }else{
      var cacheData = await APICacheManager().getCacheData("API_videos");
      _model = VideoPlaylistModel.fromJson(json.decode(cacheData.syncData));

      return _model;
    }


  }

}