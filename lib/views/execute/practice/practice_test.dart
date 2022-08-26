import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prepseed/constants/theme/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.topic.name.toString(),style: Style.textStyleBold13,),
            ),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            actionWidgets(),
                            SizedBox(height: 20.0),
                            question(provMdl.getQuestionModel.question!.core!.content!.rawContent!),

                         /*   Text(provMdl.getQuestionModel.question!.core!.content!.rawContent!.blocks![0].text.toString(),
                              style: Style.textStyleBold13,
                              textAlign: TextAlign.justify,
                            ),*/
                            SizedBox(height: 20.0,),
                            option(options),
                            SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(onPressed: (){
                                  provMdl.getQuestion(widget.topic.sId.toString());
                                }, child: Text('Next')),
                                SizedBox(width: 20.0,),
                                ElevatedButton(onPressed: () async {
                                  await provMdl.closeQuestions();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => practice(),));
                                }, child: Text('End Session'))
                              ],
                            ),

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


/*============================================ Questions ===================================================*/


  Widget question(RawContent rawContent){
    String? img;
    if(rawContent.entityMap != null){
      img = rawContent.entityMap!.first.data!.first.url;
    }
    return  Column(
      children: [
        TeXView(
          child: TeXViewColumn(children: [
            _teXViewWidget((rawContent.blocks![0].text.toString()))
          ]),
        ),
        img != null ?
        /*Image.network((question.queImage),
            // height: 190,
            fit: BoxFit.contain,)*/
        GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      backgroundColor: Colors.transparent,
                      actions: [
                        InteractiveViewer(
                          clipBehavior: Clip.none,
                          minScale: 1,
                          maxScale: 4,
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: CachedNetworkImage(
                                imageUrl:img!,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
                                imageBuilder: (context, image) => Image(
                                  image: image,
                                  height: MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.width,
                                  /*height: MediaQuery.of(context).size.height / 9,*/
                                  fit: BoxFit.contain,)
                            ),
                          ),
                        ),
                      ]
                  );
                }
            );
          },
          child: CachedNetworkImage(
              imageUrl: img,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
              imageBuilder: (context, image) => Image(
                image: image,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                /*height: MediaQuery.of(context).size.height / 9,*/
                fit: BoxFit.contain,)
          ),
        ):
        Container(),
      ],
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


/*======================================================== Options ================================================*/


  Widget option(List options){
    final provMdl = Provider.of<GetQuestionProvider>(context);
    Core question = Core();
    question = provMdl.getQuestionModel.question!.core!;
    var selectedIndexes = Provider.of<TestProviderClass>(context, listen: false).selectedIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(question.type.toString()),
            SizedBox(height: 5.0),
            question.type == 'MULTIPLE_CHOICE_MULTIPLE_CORRECT' ||
            question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT"  ?
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(options.length, (index) {
            return CheckboxListTile(
              title:
              TeXView(
                child: TeXViewColumn(children: [
                  _teXViewWidget((options[index].content.rawContent.blocks[0].text.toString())),
                ]),
              ),
              // Text(options[index].content.rawContent.blocks[0].text.toString()),
              // subtitle: Text(this.noteList[position].actn_on),
              value: selectedIndexes.contains(options[index].id),
              onChanged: (_) {
                print(question.sId);
                print(options[index].sId);
                print(options[index].content.rawContent.blocks[0]);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(options.length, (index) {
            return RadioListTile(
                title: /*TeXView(
                  child: TeXViewColumn(children: [
                    _teXViewWidget((question.options.elementAt(index).text.toString()) ?? ''),
                  ]),
                ),*/
                TeXView(
                  child: TeXViewColumn(children: [
                    _teXViewWidget((options[index].content.rawContent.blocks[0].text.toString())),
                  ]),
                ),
                //Text(options[index].content.rawContent.blocks[0].text.toString()),
                value: options[index].content.rawContent.blocks[0].text.toString(),
                groupValue: Provider.of<TestProviderClass>(context, listen: false).optionVal,
                onChanged: (value){
                  print(question.sId);
                  print(options[index].sId);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(options.length, (index) {
            return ListTile(
              title: Text(options[index].content.rawContent.blocks[0].text.text),
            );
          }))
           // Text(options[ind].content.rawContent.blocks[0].text.toString()),

          ],
        );
  }
  static TeXViewWidget _teXViewWidget( String body) {
    return TeXViewColumn(
        style: const TeXViewStyle(
           // margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
            textAlign: TeXViewTextAlign.Center,
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.groove,
                borderColor: Colors.green))),
        children: [/*
          TeXViewDocument(title,
              style: const TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  // textAlign: TeXViewTextAlign.center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Colors.green)),*/
          TeXViewDocument(body,
              style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
        ]);
  }
}
