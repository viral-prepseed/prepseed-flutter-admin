import 'dart:ui';

import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 25.0),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context, "");
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  SizedBox(width: 20.0,),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.redAccent, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(100.0))),
                    child: Container(),
                  ),
                  SizedBox(width: 40.0,),
                  Column(
                    children: [
                      Text("Prepseed Teacher",style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.white
                      ),),
                      Text("Teacher",style: TextStyle(
                          fontSize: 15.0,
                          //fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.white
                      ),),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Container()
                ),
              )
            ],
          ),
        )
    );
  }
}
