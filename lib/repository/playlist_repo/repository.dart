//get whole playlist

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import '../../constants/strings.dart';
import '../../helper/sharedPref.dart';
import '../../model/playlist_model/playlists.dart';
import '../../model/userDetails/user_data_model.dart';

class ProviderClassRepo{
  UserSubscription model = UserSubscription();
  Future<playlist_model>getPlaylist() async {

    playlist_model _model;
    var isCachedExist = await APICacheManager().isAPICacheKeyExist("API_videoPlay");
    if(!isCachedExist){
      var token = await sharedPref().getSharedPref('token');
      var url = Uri.parse(Strings.playlistUrl);
      var response = await http.get(url, headers: {
        'Content-type' : 'application/json',
        'authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        /*  _model = List<playlist_model>.from(
          json.decode(response.body).map((x) => playlist_model.fromJson(x))).toList();
    */
        print("URLv: HIT");
        APICacheDBModel cacheDBModel = APICacheDBModel(key: "API_videoPlay", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        _model = playlist_model.fromJson(json.decode(response.body));
      }
      else if(response.statusCode == 401){
        throw Exception('UnAuthorize');
      }
      else {
        throw Exception('Failed to get Playlist');
      }
      return _model;
    }else{
      var cacheData = await APICacheManager().getCacheData("API_videoPlay");
      _model = playlist_model.fromJson(json.decode(cacheData.syncData));
      print("CACHEv: HIT");

      return _model;
    }
  }


  var datalist;
  List<Subscriptions> listData = [];
  Future<List<Subscriptions>>getUserData() async {
     datalist = await sharedPref().getSharedPref('subscriptions');
     listData = List<Subscriptions>.from(json.decode(datalist).map((x) => Subscriptions.fromJson(x))) ;
   return listData;
  }
}