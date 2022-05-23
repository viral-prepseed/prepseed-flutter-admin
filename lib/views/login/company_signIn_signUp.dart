import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:prepseed/views/home/landingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/strings.dart';
import '../../constants/colorPalate.dart';


class signIn_signUp extends StatefulWidget{
  final String clientname;

  signIn_signUp({required this.clientname});

  @override
  State<StatefulWidget> createState() {
    return _signIn_signUp();
  }
}

class _signIn_signUp extends State<signIn_signUp>{

  final _signIn_signUpFormKey = GlobalKey<FormState>();

  String? errormsg;
  bool? error, showprogress;
  String? username, password;

  var _username = TextEditingController();
  var _password = TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


  startLogin() async {
    String apiurl = Strings.otp_url;
    // print(password);
    username = _username.text.trim();

    var response = await http.post(Uri.parse(apiurl), body: {
      'mobile_no': username, //get the username text
      'activated': 'false'
    });

    if(response.body.isNotEmpty) {
      print(json.decode(response.body).toString());
    }
    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      // print(jsondata);
      if(jsondata["error"]){
        setState(() {
          showprogress = false;
          error = true;
          errormsg = jsondata["message"];
        });
      }else{
        if(jsondata["success"]){
          setState(() {
            error = false;
            showprogress = false;
          });



          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('${username!}_otpsent', '${jsondata["value"]}');


/*          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => otpPage(mobile_no: username!,)
          ));*/

        }else{
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    }else{
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }

  }


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
          backgroundColor: Constants.backgroundColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
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
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue
                          ),
                          child: Text('Client Logo'),
                        ),
                        /*Image(
                          image: NetworkImage("https:///API/app_icons/task-dark.png"),
                          fit: BoxFit.fill,
                        ),*/
                        Padding(
                          padding: const EdgeInsets.only(left: 25,right: 25),
                          child: Container(
                            child: Text("Sign in to "+widget.clientname,style: GoogleFonts.poppins(
                                color: Constants.white.withOpacity(1),fontWeight: FontWeight.w500, fontSize: 25
                            ),),
                          ),
                        ),
                        /*Container(
                    child: Image(
                      image: NetworkImage("https:///API/app_icons/task-dark.png"),
                      fit: BoxFit.fill,
                    )
                  ),*/

                        /* Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15, left: 28.0,right: 28.0),
                    child: Container(
                      margin: EdgeInsets.only(top:10),
                      child: Text("Login", style: GoogleFonts.poppins(
                          color:Constants.white.withOpacity(1),fontSize: 25,fontWeight: FontWeight.bold
                      ),), //subtitle text
                    ),
                  ),*/
                        // SizedBox(height: 70,),
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

                                    Text('Email', style: GoogleFonts.poppins(color: Constants.black,fontWeight: FontWeight.w500,fontSize: 18),),
                                    TextFormField(
                                      controller: _username,
                                      focusNode: _usernameFocusNode,
                                      validator: (value) => value!.isEmpty ? 'mobile number cannot be blank' : (value.length < 10) ?
                                      'Please enter valid mobile number' : null,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Constants.white,
                                      style: GoogleFonts.poppins(fontSize: 19,color: Constants.white,
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
                                            color: Colors.white,
                                          ),
                                        ),
                                        counterText: '',
                                        hintText: "julie@example.com",
                                        hintStyle: GoogleFonts.poppins(fontSize: 19,color: Constants.white,
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
                                      child: (error == true) ? errmsg(errormsg!):Container(),
                                      //if error == true then show error message
                                      //else set empty container as child
                                    ),

                                    Text('Password', style: GoogleFonts.poppins(color: Constants.black,fontWeight: FontWeight.w500,fontSize: 18),),
                                    TextFormField(
                                      controller: _password,
                                      focusNode: _passwordFocusNode,
                                      validator: (value) => value!.isEmpty ? 'password cannot be blank' : (value.length < 6) ?
                                      'Please enter valid password' : null,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Constants.white,
                                      style: GoogleFonts.poppins(fontSize: 19,color: Constants.white,
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
                                            color: Colors.white,
                                          ),
                                        ),
                                        counterText: '',
                                        hintText: "Enter your password",
                                        hintStyle: GoogleFonts.poppins(fontSize: 19,color: Constants.white,
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

                                    /*CustomFormField(
                                isLabelEnabled: false,
                                controller: _username,
                                focusNode: _usernameFocusNode,
                                keyboardType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                label: 'Mobile No.',
                                hint: 'Enter Mobile No.',
                                validator: (value) => Validator.validateField(
                                  value: value,
                                ),
                              ),*/


                                    // SizedBox(height:  MediaQuery.of(context).size.height - 500,),


                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),


                        /*Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top:20),
                    child: InkResponse(
                        onTap:(){
                          print('tapped...');
                        },
                        child:Text("Forgot Password? Troubleshoot",
                          style: TextStyle(color:Colors.white, fontSize:18),
                        )
                    ),
                  )*/
                      ]),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Constants.blacklight.withOpacity(1),
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    margin: EdgeInsets.only(top:20),
                    child: SizedBox(
                      height: 60, width: double.infinity,
                      child:RaisedButton(
                        elevation: 0,
                        onPressed: (){
                          setState(() {
                            //show progress indicator on click
                            // if (_signIn_signUpFormKey.currentState!.validate()) {
                              // startLogin();
                              showprogress = true;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => landingScreen()
                              ));
                            // }

                          });



                        },
                        child: (showprogress == true)?
                        SizedBox(
                          height:30, width:30,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.orange[100],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                          ),
                        ):Text("Sign In", style: GoogleFonts.poppins(fontSize: 17,
                            color: Constants.backgroundColor.withOpacity(1),
                            fontWeight: FontWeight.bold,letterSpacing: 2),),
                        colorBrightness: Brightness.dark,
                        color: Constants.blacklight.withOpacity(1),
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