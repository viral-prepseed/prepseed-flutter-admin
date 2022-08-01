import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../menu/menu_widget.dart';
import 'chat_screen.dart';

class ChatsHomeScreen extends StatefulWidget {
  const ChatsHomeScreen({Key? key}) : super(key: key);

  @override
  _ChatsHomeScreenState createState() => _ChatsHomeScreenState();
}

class _ChatsHomeScreenState extends State<ChatsHomeScreen> {
  String? userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: MenuWidget(),
        ),
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255,253,170,173),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Center(
                      child: Text(
                        "Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),*/
               /* const SizedBox(
                  height: 20.0,
                ),
                Style.divider(),
               */
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5.0,bottom: 10.0,top: 35.0),
                          child: Text("All Chats",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black45
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context,index){
                              return Container(
                                height: 80.0,
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50.0,
                                            width: 50.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.redAccent, width: 2.0),
                                                borderRadius: const BorderRadius.all(Radius.circular(100.0))),
                                            child: Container(),
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Prepseed Teacher",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(height: 5.0,),
                                              Text("Teacher",
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 15.0,
                                                    //fontWeight: FontWeight.bold
                                                ),)
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 20.0,
                                            width: 20.0,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                                color: Colors.red
                                            ),
                                            child: Center(child: Text("1",
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.white,
                                                ),
                                            )),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text("12:45",style: TextStyle(
                                            fontSize: 11.0
                                          ),)
                                        ],
                                      )
                                    ],
                                  ),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ChatScreen()));

                                    print(index);
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ]),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 124, 123, 155),
        onPressed: (){
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Start New Chat"),
                  const Divider(
                    height: 20.0,
                    thickness: 2.0,
                    color: Color.fromARGB(255, 233, 233, 233),
                  ),
                  Container(
                    //margin: const EdgeInsets.all(10.0),
                   // padding: EdgeInsets.all(10.0),
                    height: 110.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 233, 233, 233), width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text("Physics",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),),
                        ),
                        const Divider(
                          //height: 10.0,
                          thickness: 2.0,
                          color: Color.fromARGB(255, 233, 233, 233),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: const Text("Prepseed Teacher",style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 13.0
                              ),),
                            ),
                            Container(
                             /* decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(255, 233, 233, 233), width: 2.0),
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                             */
                              child: IconButton(
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ChatScreen()));

                                    //Navigator.of(context).push(MaterialPageRoute(
                                       // builder: (context) => ChatScreen(id: elementsid,name: elementsName,)));
                                  },
                                  icon: Icon(
                                    Icons.message,color: Colors.black,
                                    size: 15.0,
                                  ),
                               ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20.0,
                    thickness: 2.0,
                    color: Color.fromARGB(255, 233, 233, 233),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      ElevatedButton(onPressed: (){
                        Navigator.of(ctx).pop();
                      }, child: const Text("Ok"))
                    ],
                  )

                ],
              ),
              /*content: SizedBox(
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 20.0,
                      thickness: 2.0,
                      color: Color.fromARGB(255, 233, 233, 233),
                    ),
                    const Text("Physics",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                    ),),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text("Not Enough Data",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0
                    ),),
                    const Divider(
                      height: 20.0,
                      thickness: 2.0,
                      color: Color.fromARGB(255, 233, 233, 233),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        ElevatedButton(onPressed: (){
                          Navigator.of(ctx).pop();
                        }, child: const Text("Ok"))
                      ],
                    )

                  ],
                ),
              ),*/
            ),
          );
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
