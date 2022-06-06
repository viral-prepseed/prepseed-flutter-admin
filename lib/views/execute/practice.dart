import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prepseed/helper/api/callAPI.dart';
import 'package:prepseed/views/menu/menu_widget.dart';

import '../../constants/colorPalate.dart';
import '../../constants/strings.dart';
import '../../helper/api/functions.dart';
import 'package:http/http.dart' as http;

import '../../helper/sharedPref.dart';

class practice extends StatefulWidget {
  const practice({Key? key}) : super(key: key);

  @override
  _practiceState createState() => _practiceState();
}

class _practiceState extends State<practice> {
  late var signinlist ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();

  }
  getprefs() async {
    signinlist = await sharedPref().getSharedPref('signinlist');
    setState(() {
      signinlist;
    });
    callAPI();
  }

  callAPI() async{

    var topicId = '5d641d2d2e8a7c5406d44465';
    functions().getObjectsById(signinlist,topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: Container(),
    );
  }
}
