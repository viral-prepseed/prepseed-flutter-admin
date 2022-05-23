import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/strings.dart';
import '../../constants/colorPalate.dart';
import 'company_signIn_signUp.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{

  final _LoginPageFormKey = GlobalKey<FormState>();

  String? errormsg;
  bool? error, showprogress;
  String? username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();



  dynamic tokenid;

  @override
  void initState() {


    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;


    super.initState();

  }

  Future<void> saveTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('uid');
    final response = await http.post(Uri.parse("#"), body: { //API/insertdata_API.php
      "type_of_action": 'addTokens',
      "tokenid": tokenid!,
      "uid": uid,
    });
    var datauser = json.decode(response.body);
    // print(datauser);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      //color set to transperent or set your own color
    ));

    return GestureDetector(
      onTap: (){
        _usernameFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        // backgroundColor: Constants.bgclr.withOpacity(1),
        body: Stack(
          children: [
            /*Image(image: NetworkImage('https:///API/app_icons/task-background.png'),
              fit: BoxFit.fill,),*/
            Container(
              constraints: BoxConstraints(
                  minHeight:MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
              ),
              width:MediaQuery.of(context).size.width,
              //make width of outer wrapper to 100%
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ Constants.blue.withOpacity(1),Constants.blue.withOpacity(1),
                    Constants.blue, Constants.blue,
                  ],
                ),
              ), //show linear gradient background of page
              // padding: EdgeInsets.all(20),

            ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: NetworkImage(Strings.logo_sm_icon),
                    width: 100,
                    fit: BoxFit.fill,),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text("Lorem Ipsum is \nsimply dummy ",style: GoogleFonts.poppins(color: Constants.white.withOpacity(1),
                      fontWeight: FontWeight.bold, fontSize: 45,
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    child: Text("text of the printing and typesetting industry.",style: GoogleFonts.poppins(color: Constants.white.withOpacity(1),
                        fontWeight: FontWeight.w500, fontSize: 25
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  // color: Constants.black.withOpacity(1),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top:20),
                  child: SizedBox(
                    height: 60, width: double.infinity,
                    child:RaisedButton(
                      // elevation: 0,
                      onPressed: (){
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => signIn_signUp()));
                      },
                      child: (showprogress == true)?
                      SizedBox(
                        height:40, width:30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.orange[100],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                        ),
                      ):Text("Get Started", style: GoogleFonts.poppins(fontSize: 17,
                          color: Constants.backgroundColor.withOpacity(1),
                          fontWeight: FontWeight.bold,letterSpacing: 2),),
                      colorBrightness: Brightness.dark,
                      color: Constants.white.withOpacity(1),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)
                        //button corner radius
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration myInputDecoration({required String label, required IconData icon}){
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color:Constants.white, fontSize:20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left:20, right:10),
          child:Icon(icon, color: Constants.white,)
        //padding and icon for prefix
      ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Constants.white, width: 1)
      ), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Constants.white, width: 1)
      ), //focus border

      fillColor: Colors.transparent,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text){
    //error message widget.
    return Container(
      padding: EdgeInsets.all(5.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color:Colors.red.shade400, width:2)
      ),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
        //show error message text
      ]),
    );
  }
}


class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}