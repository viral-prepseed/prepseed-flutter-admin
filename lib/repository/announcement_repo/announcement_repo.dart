//get whole playlist

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prepseed/model/announcement_model/announcement_model.dart';

import '../../constants/strings/string.dart';
import '../../helper/sharedPref.dart';

class AnnouncementRepo{

  Future<AnnouncementModel>getAnnouncements() async {

    AnnouncementModel _model;

    var token = await sharedPref().getSharedPref('token');
    var phaseId = await sharedPref().getSharedPref('phaseId');
    var url = Uri.parse(StringValue.announcementUrl + phaseId + "/0/20");
    var response = await http.get(url, headers: {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      /*  _model = List<playlist_model>.from(
          json.decode(response.body).map((x) => playlist_model.fromJson(x))).toList();
    */
      _model = AnnouncementModel.fromJson(json.decode(response.body));
    }
    else if(response.statusCode == 401){
      throw Exception('UnAuthorize');
    }
    else {
      throw Exception('Failed to get Playlist');
    }
    print(_model);
    return _model;
  }

}