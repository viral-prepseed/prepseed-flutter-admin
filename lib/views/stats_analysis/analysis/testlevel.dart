import 'package:flutter/material.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';
import 'package:provider/provider.dart';
import 'package:prepseed/helper/provider/tests/assessmentWrappers.dart';

import '../../../constants/colorPalate.dart';
import '../../../helper/api/functions/formatDateTime.dart';
import '../../../helper/sharedPref.dart';
import '../../execute/test/viewAnalysis.dart';
import 'leaderboard.dart';

class testLevel extends StatefulWidget {
  const testLevel({Key? key}) : super(key: key);

  @override
  _testLevelState createState() => _testLevelState();
}

class _testLevelState extends State<testLevel> {

  @override
  void initState() {
    Future.microtask(() async => {
      await Provider.of<AssessmentWrappersClass>(context, listen: false)
          .getWrappersAPI(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [

        Consumer<AssessmentWrappersClass>(builder: (context, aswModel, child){
          // print(aswModel.listData.length);
          return Column(
            children: List.generate(aswModel.listData.length, (index) {
              AssessmentWrappers asw = aswModel.listData.elementAt(index);
              var from = FormatDateTime().dateMonthFormatter(asw.availableFrom);
              var till = FormatDateTime().dateMonthFormatter(asw.availableTill);
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 32,
                    // height: 350,
                    child: GestureDetector(
                      onTap: (){
                        var assessmentWrapperId = asw.sId;
                        sharedPref().setSharedPref('assessmentWrapperId', assessmentWrapperId);
                        var route = MaterialPageRoute(builder: (BuildContext context) =>  viewAnalysis() );
                        Navigator.of(context).push(route);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          color: Constants.blacklight,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Column(children: [
                                              Text(from),
                                              const SizedBox(height: 5,),
                                              Text(till),
                                            ],),
                                          ],
                                        ),
                                        const SizedBox(width: 15,),
                                        VerticalDivider(color: Constants.black),
                                        const SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(asw.name!),
                                            const SizedBox(height: 5,),
                                            Text('Click to see analysis'),
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
                ],
              );
            }),
          );
        }),

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
