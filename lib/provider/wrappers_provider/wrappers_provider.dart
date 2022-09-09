
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prepsed_principal/models/Admin/Wrapper_Model/wrapper_model.dart';
import 'package:prepsed_principal/repository/Admin/Wrapper_Repo/wrapper_repo.dart';

class WrappersProvider with ChangeNotifier {

  WrapperRepository wrapperRepository = WrapperRepository();
  WrapperModel? isData = WrapperModel();
  List<Wrappers>? wrappers = [];
  String? noData;
  int total = 0;
  int skip = 0;
  final int limit = 7;
  int end = 0;
  bool isHigher = false;
  bool isLoad = false;

  /*Future getWrapperData(int skip, int limit,String? keyWord,List<String>? phases, String? fromDate, String? toDate) async {
    // if(skip==0) {
      var isData = await wrapperRepository.getWrapperData(skip, limit, keyWord,phases,fromDate,toDate);
      List<Wrappers>? fetchData  = isData!.wrappers;
      wrappers!.addAll(fetchData!);
      if(wrappers!.length>-1 && wrappers!.isNotEmpty) {
        this.total = isData.total!.toInt();
        var time = wrappers![0].core!.duration;
        var h = int.parse(time.toString()) ~/ 3600;
        var m = ((int.parse(time.toString()) - h * 3600)) ~/ 60;
        var s = int.parse(time.toString()) - (h * 3600) - (m * 60);
        if (kDebugMode) {
          print("$h:$m:$s");
          print("wrappers: ${wrappers![0].core!.duration}");
        }
      }
      if (kDebugMode) {
        print(fetchData);
        print(wrappers);
      }
    // }
    // else {
    //   List<Wrappers>? fetchData = await wrapperRepository.getWrapperData(skip, limit, keyWord, phases, fromDate, toDate);
    //
    // }


    notifyListeners();
  }*/

  Future getWrapperData(String? keyWord,List<String>? phases, String? fromDate, String? toDate) async {

    skip = end;
    if (total < skip) {
      isHigher = true;
      notifyListeners();
      isLoad=false;
    } else {
      isLoad = true;
      end = end + limit;
      isData = await wrapperRepository.getWrapperData(skip, limit, keyWord,phases,fromDate,toDate);
      List<Wrappers>? fetchData = isData!.wrappers;
      wrappers!.addAll(fetchData!);
      if(wrappers!.length>-1 && wrappers!.isNotEmpty) {
        this.total = isData!.total!.toInt();
        var time = wrappers![0].core!.duration;
        var h = int.parse(time.toString()) ~/ 3600;
        var m = ((int.parse(time.toString()) - h * 3600)) ~/ 60;
        var s = int.parse(time.toString()) - (h * 3600) - (m * 60);
        if (kDebugMode) {
          print("$h:$m:$s");
          print("wrappers: ${wrappers![0].core!.duration}");
        }
      }
      Future.delayed(const Duration(milliseconds: 200), () {
        isLoad=false;
      });
    }

    notifyListeners();
  }

}
