
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepseed/constants/colorPalate.dart';

import '../../../helper/api/functions.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../../model/execute/tests/list_questions.dart';
import '../../../model/questions.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:cached_network_image/cached_network_image.dart';

class questionWidget extends StatefulWidget {
  final dynamic queId;
  final dynamic selectedQID;
  const questionWidget({Key? key, required this.queId,required this.selectedQID}) : super(key: key);

  @override
  _questionWidgetState createState() => _questionWidgetState();
}

class _questionWidgetState extends State<questionWidget> {

  String optionVal = '';
  Map<dynamic,dynamic> selectedRadioValues = {};
  var setQID;
  late String typeText;
  var selectedIndexes = [];//Provider.of<TestProviderClass>(context, listen: false).selectedIndex

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    setState((){
      selectedIndexes = (Provider.of<TestProviderClass>(context, listen: false).selectedIndexes);
      selectedRadioValues = (Provider.of<TestProviderClass>(context, listen: false).selectedRadioValues);

    });

    setQID = widget.selectedQID;
    QuestionClass question = widget.queId;
    String s = (question.text);

    if(question.type == "RANGE" && selectedRadioValues[setQID] != '' && selectedRadioValues[setQID] != null){
      print(selectedRadioValues[setQID]);
      setState((){
        Provider.of<TestProviderClass>(context,listen: false).textController.text = selectedRadioValues[setQID].toString();
      });
    }else{
      Provider.of<TestProviderClass>(context,listen: false).textController.clear();
    }
    // selectedRadioValues[setQID] = Provider.of<TestProviderClass>(context,listen: false).textController.text;
    // print(selectedRadioValues);

    if(question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
        question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT'){
      typeText = "Single Choice";
      Provider.of<TestProviderClass>(context,listen: false).isReset = true;
    }else if(question.type == 'RANGE' ){
      typeText = "Range";
      Provider.of<TestProviderClass>(context,listen: false).isReset = false;
    }else{
      typeText = "Multiple Choice";
      Provider.of<TestProviderClass>(context,listen: false).isReset = false;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(typeText, style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500),),
          const SizedBox(height: 10,),
          // linked_ques(question),
          (s.toString() != '') ?
          TeXView(
            child: TeXViewColumn(children: [
              _teXViewWidget((s.toString())),
              // TeXViewDocument(s ?? '', style: TeXViewStyle.fromCSS('padding: 15px; color: white; background: green'))
            ]),
            style: const TeXViewStyle(
              elevation: 10,
              borderRadius: TeXViewBorderRadius.all(25),
              border: TeXViewBorder.all(TeXViewBorderDecoration(
                // borderColor: Colors.blue,
                // borderStyle: TeXViewBorderStyle.solid,
                  borderWidth: 5)),
              backgroundColor: Colors.white,
            ),
          ) : Container(),

          // Text(question.text, style: GoogleFonts.poppins(fontSize: 13),),
          (question.queImage != '')?
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
                              imageUrl: question.queImage,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
                              imageBuilder: (context, image) => Image(
                                image: image,
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width,
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
                imageUrl: question.queImage,
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
          (question.type == 'MULTIPLE_CHOICE_MULTIPLE_CORRECT' ||
              question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT" ) ?
          Column(
            children: List.generate(question.options.length, (index) {
              return CheckboxListTile(
                title:
                TeXView(
                  child: TeXViewColumn(children: [
                    _teXViewWidget((question.options.elementAt(index).text.toString())),
                  ]),
                ),
                // Text(question.options.elementAt(index).text.toString()),
                // subtitle: Text(this.noteList[position].actn_on),
                // value: selectedIndexes.contains(question.options.elementAt(index).id),
                value: (selectedRadioValues[setQID] != null)?(selectedRadioValues[setQID].contains(question.options.elementAt(index).id)) : false,
                onChanged: (_) {
                  setState((){
                    if (selectedIndexes.contains(question.options.elementAt(index).id)) {
                      selectedIndexes.remove(question.options.elementAt(index).id);   // unselect
                    } else {
                      selectedIndexes.add(question.options.elementAt(index).id);  // select
                    }
                  });
                  selectedRadioValues[setQID] = selectedIndexes;
                  print(selectedRadioValues);

                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            }),
          ):
          (question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
              question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT') ?
          Column(
            children: List.generate(question.options.length, (index) {
/*              return RadioButtonGroup(
                onSelected: (String selected){
                  setState(){
                    selectedRadioValues[index] = selected;
                  }
                },
                picked: selectedRadioValues[index],
                labels: <String>[question.options.elementAt(index).text.toString()],
              );*/
              return RadioListTile(
                  title: TeXView(
                    child: TeXViewColumn(children: [
                      _teXViewWidget((question.options.elementAt(index).text.toString())),
                    ]),
                  ),
                  // Text(question.options.elementAt(index).text.toString()),
                  value: question.options.elementAt(index).id.toString(),
                  // tileColor: (index==3)? Colors.red : (index==1)? Colors.deepOrange : Colors.transparent,
                  groupValue:
                  // Provider.of<TestProviderClass>(context, listen: false).optionVal
                  (selectedRadioValues[setQID] == question.options.elementAt(index).id.toString())?
                  selectedRadioValues[setQID]
                  : Provider.of<TestProviderClass>(context, listen: false).optionVal,
                  onChanged: (value){
                    setState(() {
                      selectedRadioValues[setQID] = value;
                      Provider.of<TestProviderClass>(context, listen: false).optionVal = value.toString();
                      print(selectedRadioValues);
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
            children: List.generate(question.options.length, (index) {
              return ListTile(
                title: Text(question.options.elementAt(index).text),
              );
            }),
          )
        ],
      ),
    );
  }

  static TeXViewWidget _teXViewWidget( String body) {
    return TeXViewColumn(
        style: const TeXViewStyle(
            margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
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


  linked_ques(QuestionClass question){
    LinkQuestions _linkQue;

    if(question.linkedText != null && question.type == "LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT"||
        question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT"){
      _linkQue = question.linkedText;
      var rawCont = _linkQue.content!.rawContent!;
      if(rawCont.runtimeType.toString() == "String"){
        rawCont = json.decode(_linkQue.content!.rawContent!);
      }
      // var _linkText = QuestionContents.fromJson(rawCont).blocks!.first.text ?? '';
      List<String> _linkList = [];
      String _linkText;
      String _linkImage;
      for(var blockString in QuestionContents.fromJson(rawCont).blocks!){
        _linkList.add(functions().convertLetX(blockString.text.toString()));
      }

      _linkText = _linkList.join('\n');
      // _linkImage = QuestionContents.fromJson(rawCont).entityMap;


      return Column(
        children: [
/*          ExpansionTile(title: Flexible(child: Text(_linkText,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.poppins(),)),
            children: [TeXView(
              child: TeXViewColumn(children: [
                _teXViewWidget((_linkText)),
              ]),
            ),],

          ),*/
          TeXView(
            child: TeXViewColumn(children: [
              _teXViewWidget((_linkText)),
            ]),
          ),
          // Text(convertLetX(_linkText), style: GoogleFonts.poppins(fontSize: 13),),
          const SizedBox(height: 10,)
        ],
      );
    }
    return Container();
  }

}