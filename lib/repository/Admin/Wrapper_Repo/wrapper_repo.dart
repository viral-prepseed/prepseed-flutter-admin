
import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:prepsed_principal/models/Admin/Wrapper_Model/wrapper_model.dart';
import 'package:prepsed_principal/constant/api_constant.dart';
import 'package:http/http.dart' as http;

class WrapperRepository {

  // WrapperModel wrapperModel = WrapperModel();
  List<Wrappers>? wrappersList = [];

   Future<WrapperModel?> getWrapperData(int skip, int limit,String? keyword, List<String>? phases, String? fromDate,String? toDate) async {
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyOGM4YWNlZjk5MzE3M2Q3ZmNmYjBlMiIsInJvbGUiOiJtb2RlcmF0b3IiLCJleHAiOjE2NjcyNzg3MzIsInBocyI6e30sImlhdCI6MTY2MjA5NDczMX0.5yCHQ2gVo-lxYBf2Ab3zvg-SwEw6I8UkQtiR3NcqKV4";
    var url = Uri.parse(ApiConstants.admin_assessment_wrapper);
    var header = {
      "Content-Type" : "application/json",
      "authorization" : "Bearer $token",
    };
    if (kDebugMode) {
      print("$skip, $limit, $keyword, $phases, $fromDate, $toDate ");
    }
    var response = await http.post(
      url,
      headers: header,
      body: jsonEncode(
        {
          "skip": skip,
          "limit": limit,
          "keywords": keyword,
          "phases": phases,
          "startDate": fromDate,
          "endDate": toDate,
        }
      ),
    );

    if (kDebugMode) {
      print(response.body);
    }


    try {
      if(response.statusCode==200) {


        // var data = response.body;
        // var decoding = json.decode(data);

        var isDataSuccess = WrapperModel.fromJson(json.decode(response.body));

        if(isDataSuccess.success == true) {
          // List<Wrappers>? wrappersList = isDataSuccess.wrappers;

          wrappersList=isDataSuccess.wrappers;
          return isDataSuccess;
        }
        else {
          if (kDebugMode) {
            print("isDataSuccess: ${isDataSuccess.success}");
          }
        }

      }
    }
    catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

  }

}
