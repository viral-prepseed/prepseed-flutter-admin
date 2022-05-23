import 'package:flutter/material.dart';

import '../../../constants/colorPalate.dart';
import 'leaderboard.dart';

class testLevel extends StatefulWidget {
  const testLevel({Key? key}) : super(key: key);

  @override
  _testLevelState createState() => _testLevelState();
}

class _testLevelState extends State<testLevel> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 32,
              // height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  color: Constants.blacklight,
                  child: Container(
                    // height: 200,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Column(children: [
                                        Text('12 Jul'),
                                        Text('11 Jun'),
                                      ],),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(color: Constants.black),
                                  Column(
                                    children: [
                                      Column(children: [
                                        Text('Path Finder_MCT-1_12-07-2021_Test paper'),
                                        Text('Click to see analysis'),
                                      ],),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),





                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width - 32,
              // height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  color: Constants.blacklight,
                  child: Container(
                    // height: 200,
                    child: Stack(
                      children: [
                        LeaderBoard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
