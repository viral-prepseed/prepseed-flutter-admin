
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prepsed_principal/models/SignIn_Model/signin_model.dart';
import 'package:prepsed_principal/models/UsersModel/users_model.dart';
import 'package:prepsed_principal/provider/principal_provider/principal_provider.dart';
import 'package:prepsed_principal/repository/repository_data.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final _formKey = GlobalKey<FormState>();
  var len;
  PrincipalRepo prp = PrincipalRepo();
  PrincipalProvider provider = PrincipalProvider();
  var name;

  bool isHidePwd=true;

  final _addPrincipalFormKey = GlobalKey<FormState>();
  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtUserName = TextEditingController();
  final txtMobileNo = TextEditingController();
  final txtPwd = TextEditingController();

  List<String>? headList;
  List<String>? subList;
  List<String>? prepareList;
  List<String>? JEEList;
  List<String>? SATList;
  List<String>? confirmList;
  String? dropItem;
  String? drop;

  @override
  void initState() {
    // TODO: implement initState
    len = 3;
    getDt();
    headList = ["Prepare Demo","JEE Special Phase (Weshine)","SAT Special Phase(Weshine)"];
    // subList = ["EnerJEE Demo","Navin Bhai son JEE","SAT Special Phase(Weshine)"];
    prepareList = ['EnerJEE Demo A1', 'A2', "A3"];
    JEEList = ["Navin Bhai son JEE B1","B2","B3"];
    SATList = ["SAT Special Phase(Weshine) C1","C2","C3"];
    super.initState();
  }

  void getDt() {
    provider.getData();
  }

  // void _getData() async {
  //   userModel = await prp.getData()!.then((value) => userModel=value);
  //   print(userModel![0].dp);
  //   // signIn = (await ProviderRp().getData()) as List<SignInModel>;
  //   // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
  //   //   print(prp.signInModel.subgroups[0].phases[0].phase.)
  //   // }));
  // }

  List<String>? confirmSub(int ind) {
    switch(ind) {
      case 0:
        return prepareList;
        break;
      case 1:
        return JEEList;
        break;
      case 2:
        return SATList;
        break;
    }
  }

  void addPrincipal(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (BuildContext context,setState) {

              return AlertDialog(
                title: const Text("Principal Details"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _addPrincipalFormKey,
                        child: Column(
                          children: [
                            // Name
                            TextFormField(
                              controller: txtName,
                              validator: (val) {
                                if(val==null || val == "") {
                                  return "Please Enter Name";
                                }
                                else {
                                  return null;
                                }
                              },

                              decoration: InputDecoration(
                                hintText: "Enter Name",
                                contentPadding: const EdgeInsets.only(
                                    left: 8,right: 8,top: 4,bottom: 4
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),

                            // Email
                            TextFormField(
                              controller: txtEmail,
                              validator: (val) {
                                if(val==null || val == "" ) {
                                  return "Please Enter E-mail";
                                }
                                else if(RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(val)==false) {
                                  return "Please Enter Valid E-mail";
                                }
                                else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter E-mail",
                                contentPadding: const EdgeInsets.only(
                                    left: 8,right: 8,top: 4,bottom: 4
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),

                            // Username
                            TextFormField(
                              controller: txtUserName,
                              validator: (val) {
                                if(val==null || val == "") {
                                  return "Please Enter User Name";
                                }
                                else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter User Name",
                                contentPadding: const EdgeInsets.only(
                                    left: 8,right: 8,top: 4,bottom: 4
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),

                            // Mobile
                            TextFormField(
                              controller: txtMobileNo,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              validator: (val) {
                                if(val==null || val == "") {
                                  return "Please Enter Mobile No.";
                                }
                                else if(val.length<10 || val.length>10 ) {
                                  return "Please Write Valid Mobile NO.";
                                }
                                else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Mobile No.",
                                counterText: '',
                                contentPadding: const EdgeInsets.only(
                                    left: 8,right: 8,top: 4,bottom: 4
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),

                            // Password
                            TextFormField(
                              controller: txtPwd,
                              // obscureText: isHidePwd,
                              validator: (val) {
                                if(val==null || val == "") {
                                  return "Please Enter Password";
                                }
                                else if(val.length<4 || val.length>20 ) {
                                  return "Please Enter Valid Password";
                                }
                                else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                contentPadding: const EdgeInsets.only(
                                    left: 8,right: 8,top: 4,bottom: 4
                                ),
                                // suffixIcon: (isHidePwd==true)
                                //   ? IconButton(icon: const Icon(Icons.visibility_outlined), onPressed: () {
                                //       isHidePwd=false;
                                //     },)
                                //   : IconButton(icon: const Icon(Icons.visibility_off_outlined), onPressed: () {
                                //       isHidePwd=true;
                                //     },),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),

                            DropdownButtonHideUnderline(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black,width: 1),
                                  // boxShadow: const <BoxShadow>[
                                  //   BoxShadow(
                                  //       color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                  //       blurRadius: 5) //blur radius of shadow
                                  // ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: DropdownButton(
                                    elevation: 16,
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text(
                                      'Select Phases',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: headList?.map((item) => DropdownMenuItem(value:item, child: Text(item))).toList(),
                                    value: dropItem,
                                    onChanged: (value) {
                                      setState(() {

                                        dropItem = value.toString();

                                        for(int i = 0; i<headList!.length; i++) {
                                          if(dropItem == headList![i]) {
                                            confirmList=[];
                                            // drop="Select Sub List";
                                            confirmList = (confirmSub(i));
                                            drop=confirmList![0];
                                            print(confirmList);
                                          }
                                        }
                                        // print(dropItem);
                                      });

                                      // print("${dropItem}");
                                    },

                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),

                            DropdownButtonHideUnderline(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black,width: 1),
                                  // boxShadow: const <BoxShadow>[
                                  //   BoxShadow(
                                  //       color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                  //       blurRadius: 5) //blur radius of shadow
                                  // ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: DropdownButton(
                                    elevation: 16,
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text(
                                      'Select Phases',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: confirmList?.map((item) => DropdownMenuItem(value:item, child: Text(item))).toList(),
                                    value: drop,
                                    onChanged: (value) {
                                      setState(() {
                                        // drop="";
                                        drop = value.toString();
                                        print(drop);
                                      });
                                      print("$drop");
                                    },

                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),


                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      txtName.text='';
                      txtUserName.text='';
                      txtEmail.text='';
                      txtMobileNo.text='';
                      txtPwd.text='';
                      confirmList=[];
                      Navigator.pop(context);
                    },
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {

                      if(_addPrincipalFormKey.currentState!.validate()) {
                        print("${txtName.text} ${txtEmail.text} ${txtUserName.text}");
                        txtName.text='';
                        txtUserName.text='';
                        txtEmail.text='';
                        txtMobileNo.text='';
                        txtPwd.text='';
                        confirmList=[];
                        Navigator.pop(context);
                      }

                    },
                  ),
                ],
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // final prov = Provider.of<PrincipalProvider>(context);



    return Scaffold(
      body: Consumer<PrincipalProvider>(
        builder: (context, provi, _) {
          return provider.userModel != null
              ? SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Principal",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(

                        onPressed: () {
                          // ProviderRp prp = ProviderRp();
                          // prp.getData();
                          // setState(() {
                            addPrincipal(context);
                          // });


                        },
                        // color: Colors.blue.shade700,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.grey.shade400,
                            ),
                            const Text("Add Principal",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 4,),
                        child: Text("Total ${provider.userModel!.length} Students")
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          left: 4, right: 8, bottom: 8
                        ),
                        // height: MediaQuery.of(context).size.height * 50 / 100,
                        // width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: provider.userModel!.length,
                          addAutomaticKeepAlives: false,
                          padding:
                          const EdgeInsets.only(bottom: 2, top: 4),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, inx) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 6, bottom: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Image.network(
                                      //   "${provider.userModel![inx].dp.toString()}",
                                      //   width: 50,
                                      //   height: 50,
                                      // ),
                                      SvgPicture.network(
                                        provider.userModel![inx].dp.toString(),
                                        width: 50,
                                        height: 50,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                const EdgeInsets.only(
                                                  left: 10,
                                                  right: 4,
                                                  bottom: 3
                                                ),
                                                // alignment: Alignment.centerLeft,
                                                child: Text("${provider.userModel![inx].name}"),
                                              ),
                                              Container(
                                                margin:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    right: 4,
                                                    top: 3),
                                                // alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "(${provider.userModel![inx].sId})"),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 15,
                                                right: 4,
                                                top: 3),
                                            // alignment: Alignment.centerLeft,
                                            child: Text(
                                                "${provider.userModel![inx].name}"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // OutlinedButton(
                                      //   onPressed: () {
                                      //   },
                                      //   style: ButtonStyle(
                                      //     shape: MaterialStateProperty.all(
                                      //       RoundedRectangleBorder(
                                      //         borderRadius: BorderRadius.circular(30.0),
                                      //       )
                                      //     ),
                                      //   ),
                                      //   child: Row(
                                      //     children: const [
                                      //       Icon(Icons.add),
                                      //       Text("Add Students"),
                                      //     ],
                                      //   ),
                                      // ),

                                      Row(
                                        children: [
                                          Container(
                                            padding:
                                            const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                left: 2, right: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              // color: Colors.grey,
                                              border: Border.all(
                                                  color: Colors
                                                      .grey.shade400),
                                            ),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                4 /
                                                100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                20 /
                                                100,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: const [
                                                Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    size: 16),
                                                Text("Profile"),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              padding:
                                              const EdgeInsets.all(4),
                                              margin:
                                              const EdgeInsets.only(
                                                  left: 4, right: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                                // color: Colors.grey,
                                                border: Border.all(
                                                    color: Colors
                                                        .grey.shade400),
                                              ),
                                              height:
                                              MediaQuery.of(context).size.height * 4 / 100,
                                              width: MediaQuery.of(context).size.width * 27 / 100,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: const [
                                                  Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      size: 16),
                                                  Text("Attendance"),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "My title"),
                                                    content: Text(
                                                        "This is mconst $inx message."),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                            "OK"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              // color: Colors.grey,
                                              border: Border.all(
                                                  color: Colors
                                                      .grey.shade400),
                                            ),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                4 /
                                                100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                20 /
                                                100,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: const [
                                                Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    size: 16),
                                                Text("Grades"),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              border: Border.all(
                                                  color: Colors
                                                      .grey.shade400),
                                              // color: Colors.grey,
                                            ),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                4 /
                                                100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                20 /
                                                100,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: const [
                                                Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    size: 16),
                                                Text("Reports"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              // : provider.userModel==null
              //   ?  const Center(
              //     child: CircularProgressIndicator(),
              //   )
                : const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
