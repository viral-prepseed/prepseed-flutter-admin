import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:prepseed/helper/provider/userDerailsProvider.dart';
import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/views/home/landingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/strings.dart';
import '../../constants/colorPalate.dart';
import '../../helper/api/functions.dart';
import '../../helper/provider/DataClassProvider.dart';
import '../../repository/playlist_repo/repository.dart';
import 'prepseed_loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:prepseed/model/usertopics.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class signIn_signUp extends StatefulWidget{
  final String clientname;
  final String clientlogo;

  signIn_signUp({required this.clientname, required this.clientlogo});

  @override
  State<StatefulWidget> createState() {
    return _signIn_signUp();
  }
}

class _signIn_signUp extends State<signIn_signUp>{

  final _signIn_signUpFormKey = GlobalKey<FormState>();

  String? errormsg;
  bool? error, showprogress;
  bool _passwordVisible = false;
  String? email, password;

  var _username = TextEditingController();
  var _password = TextEditingController();
  ProviderClassRepo provider = ProviderClassRepo();
  final FocusNode _usernameFocusNode = FocusNode();
  startLogin() async {

    String apiurl = Strings.signIn;
    email = _username.text.trim();
    password = _password.text.trim();

/*    Future.microtask(() async => {
      await Provider.of<UserClass>(context, listen: false)
          .apiCall(email,password),
    });*/

   var bodydata = {
      "user":
        {
          "email":email,
          "password": password
        },
      "portal":"preparation"
    };

    Map headers = {
      'Content-type' : 'application/json',
    };

    var response = await http.post(Uri.parse(apiurl),
        headers: {
          'Content-type' : 'application/json',
        },
        body: json.encode(bodydata));

    if(response.body.isNotEmpty) {
      var jsondatas = (response.statusCode);
      // print(jsondatas);
    }
    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      sharedPref().setSharedPref('topics', json.encode(jsondata['topics']));
      sharedPref().setSharedPref('stats', json.encode(jsondata['user']['stats']));
      sharedPref().setSharedPref('subscriptions', json.encode(jsondata['user']['subscriptions']));
     // provider.getUserData();
      // print(jsondata);

      setState(() {
        error = false;
        showprogress = false;
      });


      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username',jsondata["user"]["username"]);
      prefs.setString('userId',jsondata["user"]["_id"]);
      prefs.setString('role',jsondata["user"]["role"]);
      prefs.setString('email',jsondata["user"]["email"]);
      prefs.setString('email',jsondata["user"]["email"]);
      prefs.setString('token',jsondata["token"]);
    /*  prefs.setString('subscriptions', jsondata["user"]["subscriptions"]);*/
      prefs.setString('phaseId',jsondata["user"]["subscriptions"][0]["subgroups"][0]["phases"][0]["phase"]["_id"]);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => landingScreen()
      ));

    }else{
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Please enter correct credentials.";
      });
    }

  }


  dynamic tokenid;


  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    email = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));

    return SafeArea(
      child: GestureDetector(
        onTap: (){
          _usernameFocusNode.unfocus();
          _passwordFocusNode.unfocus();
        },
        child: Scaffold(
          // backgroundColor: Constants.backgroundColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight:MediaQuery.of(context).size.height
                  ),
                  width:MediaQuery.of(context).size.width,
                  //make width of outer wrapper to 100%
                  decoration:BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [ Constants.backgroundColor.withOpacity(1),Constants.backgroundColor.withOpacity(1),
                        Constants.backgroundColor, Constants.backgroundColor,
                      ],
                    ),
                  ),
                  // padding: EdgeInsets.all(20),
                  child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        SizedBox(height: 70,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Wanna change Institute/Collage/Academy?'),
                            TextButton(onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.clear();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => prepSeed_login()
                              ));
                            }, child: Text('here'),)
                          ],
                        ),

                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            // color: Colors.blue
                          ),
                          child: Image(
                            image: NetworkImage(widget.clientlogo),
                            fit: BoxFit.fill,
                          ),
                        ),
                        /**/
                        Padding(
                          padding: const EdgeInsets.only(left: 25,right: 25),
                          child: Container(
                            child: Text("Sign in to "+widget.clientname,style: GoogleFonts.poppins(
                                color: Constants.white.withOpacity(1),fontWeight: FontWeight.w500, fontSize: 20
                            ),),
                          ),
                        ),
                        Form(
                          key: _signIn_signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 15, left: 28.0,right: 28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      //show error message here
                                      margin: EdgeInsets.only(top:30),
                                      padding: EdgeInsets.all(5),
                                      child: (error == true) ? errmsg(errormsg!):Container(),
                                      //if error == true then show error message
                                      //else set empty container as child
                                    ),

                                    Text('Email', style: GoogleFonts.poppins(color: Constants.black,fontWeight: FontWeight.w500,fontSize: 16),),
                                    TextFormField(
                                      controller: _username,
                                      focusNode: _usernameFocusNode,
                                      validator: (value) => value!.isEmpty ? 'Email cannot be blank' : (value.isValidEmail()) ?
                                      null : 'Please enter valid email ID',
                                      keyboardType: TextInputType.text,
                                      cursorColor: Constants.white,
                                      style: GoogleFonts.poppins(fontSize: 17,color: Constants.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onChanged: (String value) {
                                        /*if(value.length == 10){
                                          _usernameFocusNode.unfocus();
                                        }*/
                                      },
                                      decoration: InputDecoration(
                                        // border: InputBorder.none,
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Constants.grey,
                                          ),
                                        ),
                                        counterText: '',
                                        hintText: "julie@example.com",
                                        hintStyle: GoogleFonts.poppins(fontSize: 17,color: Constants.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),



                                    Container(
                                      //show error message here
                                      margin: EdgeInsets.only(top:30),
                                      padding: EdgeInsets.all(5),
                                      // child: (error == true) ? errmsg(errormsg!):Container(),
                                      //if error == true then show error message
                                      //else set empty container as child
                                    ),

                                    Text('Password', style: GoogleFonts.poppins(color: Constants.black,fontWeight: FontWeight.w500,fontSize: 16),),
                                    TextFormField(
                                      controller: _password,
                                      focusNode: _passwordFocusNode,
                                      validator: (value) => value!.isEmpty ? 'password cannot be blank' : (value.length < 6) ?
                                      'Please enter valid password' : null,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Constants.white,
                                      obscureText: !_passwordVisible,
                                      obscuringCharacter: '*',
                                      style: GoogleFonts.poppins(fontSize: 17,color: Constants.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onChanged: (String value) {
                                        /*if(value.length == 10){
                                          _usernameFocusNode.unfocus();
                                        }*/
                                      },
                                      decoration: InputDecoration(
                                        // border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context).primaryColorDark,
                                          ), onPressed: () { setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        }); },
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Constants.grey,
                                          ),
                                        ),
                                        counterText: '',
                                        hintText: "Enter your password",
                                        hintStyle: GoogleFonts.poppins(fontSize: 17,color: Constants.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),


                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          // color: Constants.blacklight.withOpacity(1),
                                          padding: EdgeInsets.only(top: 20, bottom: 50),
                                          margin: EdgeInsets.only(top:20),
                                          child: Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Constants.black,
                                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                                  textStyle: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold)),
                                              onPressed: (){
                                                setState(() {
                                                  if (_signIn_signUpFormKey.currentState!.validate()) {
                                                    showprogress = true;
                                                    startLogin();
                                                  }
                                                });
                                              },
                                              child: (showprogress == true)?
                                              SizedBox(
                                                height:30, width:30,
                                                child: CircularProgressIndicator(
                                                  backgroundColor: Colors.orange[100],
                                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                                                ),
                                              ):Text("Login", style: GoogleFonts.poppins(fontSize: 17,
                                                  color: Constants.backgroundColorlight.withOpacity(1),
                                                  fontWeight: FontWeight.bold,letterSpacing: 2),),
                                              /*    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)
                                //button corner radius
                              ),*/
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
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