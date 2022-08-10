import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:prepseed/helper/api/callAPI.dart';
import 'package:prepseed/model/clientNames.dart';
import 'package:prepseed/views/login/company_signIn_signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants/strings.dart';

class prepSeed_login extends StatefulWidget {
  const prepSeed_login({Key? key}) : super(key: key);

  @override
  State<prepSeed_login> createState() => _prepSeed_loginState();
}

class _prepSeed_loginState extends State<prepSeed_login> {
  final _prepSeed_login = GlobalKey<FormState>();
  String? institutename;
  String? institutelogo;
  Map<dynamic,dynamic>? selected;
  late Future<listClientNames> clientNames;
  late List<String>? clientname = [];
  late List<String>? clientlogo = [];
  List<Clients> _categoryList = [];
  String? selectedid;
  List<Map> _myJson = [] ;
  dynamic dropdownValue;

  @override
  void initState() {
    // getclientName();
    getdatas();
  }

  getdatas() async {
    var res = await http.get(Uri.parse(Strings.listNames,),headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': 'Content-Type',
    });
    var response = json.decode(res.body);
    // print((response['clients']));
    if (res.statusCode == 200) {
      // success
      setState(() {
        _myJson = (jsonDecode(res.body)["clients"] as List).map((e) => e as Map<String, dynamic>).toList();
      });
    } else if(res.statusCode == 404){
      // not found
      print('404');
    } else if(res.statusCode == 500){
      // server not responding.
      print('server not responding');
    } else {
      // some other error or might be CORS policy error. you can add your url in CORS policy.

      print('Something went wrong');
    }




  }

  getclientName(){
    clientNames = callAPI().fetchClientNames();
    clientNames.then((value) => value.clients!.forEach((element) {
      // var dataval = '_id:'+element.sId! + ',name:'+element.name! +',logo:'+element.logo!;
      Map<String, dynamic> dataval = {};
      dataval['sId'] = element.sId!;
      dataval['name'] = element.name!;
      dataval['logo'] = element.logo!;

      /*Clients complexTutorial = Clients.fromJson(json.decode(dataval));
      print(complexTutorial);*/
      // print(Clients.fromJson(dataval));
      // print(element.runtimeType);
      clientname!.add(element.name!);
      clientlogo!.add(element.logo!);
    }));
  }

  @override
  Widget build(BuildContext context) {

    print(_myJson.runtimeType);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor,
        body: Column(
          children: [
            Image.asset('assets/images/logo.jpg'),
            SizedBox(height: 45,),
            Form(
              key: _prepSeed_login,
              child: Container(
                margin: EdgeInsets.all(10.0),
                //padding: EdgeInsets.all(10.0),
                width: double.maxFinite,
                child: DropdownButton<String>(
                  isExpanded: true,//Map<dynamic,dynamic>
                  isDense: true,
                  hint: new Text("Select"),
                  value: selectedid,
                  onChanged: ( newValue) async {
                    setState(() {
                      selectedid = newValue!;
                      /*institutename = newValue!['name']!;
                      institutelogo = newValue['logo']!;*/
                    });
                    /*final pref = await SharedPreferences.getInstance();
                    pref.setString('InstituteName', institutename!);
                    pref.setString('InstituteLogo', institutelogo!);*/
                    // print (selectedid);
                  },
                  //itemHeight: 70.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  items: _myJson.map((Map map) {
                    return DropdownMenuItem<String>(
                        value: map['_id'].toString(), //map
                        child: Container(
                          //padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image(image: NetworkImage(map['logo']),width: 45,),
                              SizedBox(width: 10,),
                              Text(
                                map["name"],
                              ),

                            ],
                          ),
                        )
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 70,),
            ElevatedButton(onPressed: (){
                if (_prepSeed_login.currentState!.validate()) {

                  _myJson.forEach((element) async {
                    if(element['_id'] == selectedid){
                      print('matched id:'+ element['_id'].toString());

                      institutename = element['name']!;
                      institutelogo = element['logo']!;

                      final pref = await SharedPreferences.getInstance();
                        pref.setString('InstituteName', institutename!);
                        pref.setString('InstituteLogo', institutelogo!);
                    }else{
                      // print('nm');
                    }
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signIn_signUp(clientname: institutename!,clientlogo: institutelogo!,)));
                }else{
                  print('oops..');
                  return null;
                }
            },
                child: Text('Next'))
          ],
        ),
      ),
    );
  }
}
