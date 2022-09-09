
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prepsed_principal/constant/api_constant.dart';
import 'package:prepsed_principal/models/SignIn_Model/signin_model.dart';
import 'package:prepsed_principal/models/UsersModel/users_model.dart';

class PrincipalRepo {

  UsersModel usersModel = UsersModel();
  List<UsersModel>? listedData;

  Future<List<UsersModel>?>? getData() async {

    // ApiConstants apiConstants = ApiConstants();
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyOGM4YWNlZjk5MzE3M2Q3ZmNmYjBlMiIsInJvbGUiOiJtb2RlcmF0b3IiLCJleHAiOjE2NjYzNDI3MTIsInBocyI6e30sImlhdCI6MTY2MTE1ODcxMX0.Ln_C92-8TTk5I_bqPipHgEhkfpygsZLHwrbosV8LVPg";

    var response = await http.get(
      Uri.parse("${ApiConstants.assessmentUrl}628c8a6d7640243d911a6cc6"),
      headers: {
        "Content-Type" : "application/json",
        "authorization" : "Bearer $token",
      },
    );

    try {
      if(response.statusCode==200) {


        var data = response.body;
        var decoding = json.decode(data);
        listedData = List<UsersModel>.from(decoding.map((x)=> UsersModel.fromJson(x)));
        print("${listedData![0].dp} ${listedData![1].dp} ${listedData![2].dp} ${listedData![3].dp}");
        // var lst = [];
        // Map a = listedData.map((e) => lst.add(UsersModel(dp: e, sId: e, name: e))) as Map;

        // Map a;
        // a.forEach((key, value) => usersModel.add(UsersModel(dp: value, )))

        return listedData;
        // print(response.body);
      }
    }
    catch(e) {
      print(e.toString());
    }
  }

}
