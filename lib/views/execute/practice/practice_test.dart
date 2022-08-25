import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prepseed/constants/theme/style.dart';
//import 'package:prepseed/model/execute/tests/list_questions.dart';
import 'package:prepseed/views/execute/practice/practice.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import '../../../constants/colorPalate.dart';
import '../../../helper/provider/practice/getquestion_provider.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../../model/execute/tests/practice/getquestion.dart';
import '../../../model/userDetails/topics.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PracticeTest extends StatefulWidget {

  SubTopicsUsr topic;
  PracticeTest({required this.topic});

  @override
  _PracticeTestState createState() => _PracticeTestState();
}

class _PracticeTestState extends State<PracticeTest> {

  GetQuestionProvider getQuestionProvider = GetQuestionProvider();
  Duration duration1 = Duration();

  @override
  void initState() {

    final provMdl = Provider.of<GetQuestionProvider>(context, listen: false);
    provMdl.getQuestion(widget.topic.sId.toString());
   // getQuestionProvider.getQuestion(widget.topic.sId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<GetQuestionProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Consumer<GetQuestionProvider>(
                  builder: (context, dataItems, _){
                    List options = [];
                    if(provMdl.getQuestionModel.question != null){
                    options.addAll(provMdl.getQuestionModel.question!.core!.options!);
                    }
                    print(options);
                    return provMdl.getQuestionModel.question != null
                        ? Column(
                          children: [
                            actionWidgets(),
                            SizedBox(height: 20.0),
                            Text(provMdl.getQuestionModel.question!.core!.content!.rawContent!.blocks![0].text.toString(),
                              style: Style.textStyleBold13,
                              textAlign: TextAlign.justify,
                            ),
                            option(options),
                            ElevatedButton(onPressed: (){
                              provMdl.getQuestion(widget.topic.sId.toString());
                            }, child: Text('next')),
                            ElevatedButton(onPressed: () async {
                              await provMdl.closeQuestions();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => practice(),));
                            }, child: Text('End Session'))
                          ],
                        )
                        : Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget actionWidgets(){
    return /*Row(
     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [*/
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Time Left",
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Constants.grey),
            ),
            Container(
              // width: MediaQuery.of(cxontext).size.width/2,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: buildTime1()
            ),
          ],
        );
        // VerticalDivider(color: Constants.grey,),
        /*Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Constants.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('+ ${quedata?.correctMark!.toString()}.00',style: GoogleFonts.poppins(color: Colors.green),),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Constants.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${quedata?.incorrectMark!.toString()}.00', style: GoogleFonts.poppins(color: Colors.redAccent),),
                              ),
                            ),
                          ],
                        ),*/

        /*ElevatedButton(
          onPressed: (){
            print('Finish');
          },
          child: Text('Finish Test'),
        )*/
      // ],
    // );
  }
  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Constants.grey)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center, children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.grey),),
        // Spacer(),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.grey),),
        // Spacer(),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ]),
    );
  }
  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Constants.grey,
                      fontSize: 15),
                ),
              ],
            ),
          ),
/*          SizedBox(
            height: 24,
          ),
          Text(header, style: GoogleFonts.poppins(color: Colors.black45)),*/
        ],
      );

  Widget option(List options){
    final provMdl = Provider.of<GetQuestionProvider>(context);
    Core question = Core();
    question = provMdl.getQuestionModel.question!.core!;
    var selectedIndexes = Provider.of<TestProviderClass>(context, listen: false).selectedIndex;
    return Column(
          children: [
            question.type == 'MULTIPLE_CHOICE_MULTIPLE_CORRECT' ||
            question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT"  ?
          Column(
          children: List.generate(options.length, (index) {
            return CheckboxListTile(
              title:
              /*TeXView(
                child: TeXViewColumn(children: [
                  _teXViewWidget((question.options.elementAt(index).text.toString()) ?? ''),
                ]),
              ),*/
               Text(options[index].content.rawContent.blocks[0].text.toString()),
              // subtitle: Text(this.noteList[position].actn_on),
              value: selectedIndexes.contains(options[index].id),
              onChanged: (_) {
                if (selectedIndexes.contains(options[index].id)) {
                  selectedIndexes.remove(options[index].id);   // unselect
                } else {
                  selectedIndexes.add(options[index].id);  // select
                }
                // print(selectedIndexes);
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        ):
        (question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
            question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT') ?
        Column(
          children: List.generate(options.length, (index) {
            return RadioListTile(
                title: /*TeXView(
                  child: TeXViewColumn(children: [
                    _teXViewWidget((question.options.elementAt(index).text.toString()) ?? ''),
                  ]),
                ),*/
                Text(options[index].content.rawContent.blocks[0].text.toString()),
                value: options[index].content.rawContent.blocks[0].text.toString(),
                groupValue: Provider.of<TestProviderClass>(context, listen: false).optionVal,
                onChanged: (value){
                  setState(() {
                    Provider.of<TestProviderClass>(context, listen: false).optionVal = value.toString();
                  });
                });
          }),
        ) : (question.type == 'RANGE') ?
        TextField(
          controller: Provider.of<TestProviderClass>(context,listen: false).textController,
          inputFormatters: [
            FilteringTextInputFormatter(RegExp(r"(\-)?\d+\.?\d{0,30}"), allow: true),
          ],
          decoration: const InputDecoration(labelText: "Your Answer"),
          keyboardType: TextInputType.number,
        ) : Column(
          children: List.generate(options.length, (index) {
            return ListTile(
              title: Text(options[index].content.rawContent.blocks[0].text.text),
            );
          }))
           // Text(options[ind].content.rawContent.blocks[0].text.toString()),

          ],
        );
  }
}
