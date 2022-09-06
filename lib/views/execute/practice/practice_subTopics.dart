import 'package:flutter/material.dart';
import 'package:prepseed/model/execute/tests/practice/close_session.dart';
import 'package:prepseed/views/execute/practice/attempt_practice.dart';
import 'package:prepseed/views/execute/practice/practice_test.dart';
import '../../../constants/theme/style.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../helper/provider/practice/getquestion_provider.dart';
import '../../../model/userDetails/topics.dart';
import 'package:provider/provider.dart';
class PracticeSubTopics extends StatefulWidget {
  TopicsList? list;
  PracticeSubTopics({required this.list});

  @override
  _PracticeSubTopicsState createState() => _PracticeSubTopicsState();
}

class _PracticeSubTopicsState extends State<PracticeSubTopics> {

  @override
  Widget build(BuildContext context) {
    // final provMdl = Provider.of<VideosProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                    widget.list!.name!,
                    style: Style.textStyleBold15
                ),
/*                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UploadQuestion(sub: provMdl.doubtModel.subjects!,))
                            );
                          },
                          child: Text("Ask Question")),
                    ],
                  ),
                ),*/
                SizedBox(width: 10.0,)
              ],
            ),
            Style.divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.list!.subTopics!.length,
                  itemBuilder: (context,index){
                    var subList = widget.list!.subTopics!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(subList.elementAt(index).name!),
                          (subList.elementAt(index).percentComplete != null && subList.elementAt(index).percentComplete != 0) ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              LinearPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                lineHeight: 15.0,
                                percent:double.parse(subList.elementAt(index).percentComplete!.toString())/100,
                                /*center: Text(
                                  double.parse(subList.elementAt(index).percentComplete!.toString()).toString() + "%",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),*/
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.blue[400],
                                backgroundColor: Colors.grey[300],
                              ),
                              SizedBox(height: 10,),
                              Text(subList.elementAt(index).percentComplete!.toInt().toString() +'% completed')
                            ],
                          )
                              : Container(),
                          SizedBox(height: 10,),
                          Container(
                            child: ElevatedButton(onPressed: () async {
                              var newRoute = MaterialPageRoute(builder: (BuildContext context) => PracticeTest(topic: subList.elementAt(index),));
                              final provMdl = Provider.of<GetQuestionProvider>(context, listen: false);
                              await provMdl.getQuestion(subList.elementAt(index).sId.toString(),subList.elementAt(index).name.toString());
                              provMdl.sessionProgress!.sessionId != null ?
                                  showSessionStatus(provMdl,subList.elementAt(index)) :
                              Navigator.of(context).push(newRoute);
                            }, child: const Text('Practice Now')),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
  showSessionStatus(GetQuestionProvider provMdl, SubTopicsUsr element,){
    var newRoute = MaterialPageRoute(builder: (BuildContext context) => PracticeTest(topic:element,));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: Style.borderRadius(),
        ),
        title: Column(
          children: [
            ElevatedButton(
                onPressed: ()async{
                  await provMdl.getQuestionRepo.closeSession();
                  Navigator.of(context).push(newRoute);
                },
                child: Text('Start New Session')),
            ElevatedButton(
                onPressed: ()async{
                 // provMdl.getSessionQuestion(provMdl.getQuestionRepo.closeSessionModel!.sessionId);
                  Navigator.pop(context);
                  await Navigator.of(context).push(newRoute);
                },
                child: Text("Resume Session"))
          ],
        ),
      ),
    );
  }
}
