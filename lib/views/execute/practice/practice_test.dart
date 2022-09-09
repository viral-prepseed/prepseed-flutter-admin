import 'package:flutter/material.dart';
import 'package:prepseed/constants/theme/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:prepseed/model/execute/tests/practice/getanswer.dart';
//import 'package:prepseed/model/execute/tests/list_questions.dart';
import 'package:prepseed/views/execute/practice/practice.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:prepseed/views/execute/practice/practice_subTopics.dart';
import '../../../constants/colorPalate.dart';
import '../../../constants/common/imageurl.dart';
import '../../../helper/api/functions.dart';
import '../../../helper/provider/practice/getquestion_provider.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../../model/execute/tests/practice/getquestion.dart';
import '../../../model/userDetails/topics.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PracticeTest extends StatefulWidget {

  SubTopicsUsr topic;
  PracticeTest({Key? key, required this.topic}) : super(key: key);

  @override
  _PracticeTestState createState() => _PracticeTestState();
}

class _PracticeTestState extends State<PracticeTest> {

  GetQuestionProvider getQuestionProvider = GetQuestionProvider();
  Duration duration1 = const Duration();
  bool check = false;
  String? queId;
  String? ansId;
  bool isEnable = false;
  bool optionColor = false;
  Map<dynamic,dynamic> isTrue = {};
  bool checkColor = false;
  int? setPQID = 0;
  int? currentQid = 0;
  @override
  void initState() {
    setState((){
      setPQID = Provider.of<GetQuestionProvider>(context, listen: false).setPQID;
      currentQid = Provider.of<GetQuestionProvider>(context, listen: false).currentQid;
    });
    isTrue = {};
    Future.microtask(() async => {
      await Provider.of<GetQuestionProvider>(context, listen: false)
          .getQuestionApiWithIndex("last",1),
      Provider.of<GetQuestionProvider>(context, listen: false).setPQID = Provider.of<GetQuestionProvider>(context, listen: false).queLength - 1,
      Provider.of<GetQuestionProvider>(context, listen: false).currentQid = Provider.of<GetQuestionProvider>(context, listen: false).queLength - 1,

      //provider to call API and update data....
    });
    // final provMdl = Provider.of<GetQuestionProvider>(context, listen: false);
    //provMdl.getQuestion(widget.topic.sId.toString()) ;
    //getQuestionProvider.getQuestion(widget.topic.sId.toString());
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
            const SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.topic.name.toString(),style: Style.textStyleBold13,),
            ),
            Expanded(
              child: Consumer<GetQuestionProvider>(
                builder: (context, dataItems, _){
                  List<Options> options = [];
                  if(provMdl.getQuestionModel != null && provMdl.getQuestionModel!.question != null){
                    options.addAll(provMdl.getQuestionModel!.question!.core!.options!);
                  }
                  return provMdl.getQuestionModel != null ?
                  provMdl.getQuestionModel!.question != null
                      ? ListView(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      actionWidgets(),
                      selectIndex(),
                      const SizedBox(height: 20.0),
                      question(provMdl.getQuestionModel!.question!.core!),
                      /*   Text(provMdl.getQuestionModel.question!.core!.content!.rawContent!.blocks![0].text.toString(),
                            style: Style.textStyleBold13,
                            textAlign: TextAlign.justify,
                          ),*/
                      const SizedBox(height: 20.0,),
                      option(options),
                      const SizedBox(height: 20.0,),
                      check
                          ? solutions(provMdl.getAnswers)
                          : Container(),
                    ],
                  )
                      : Container()
                      : Center(child: CircularProgressIndicator(color: Colors.green),);
                  /*: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(provMdl.sessionProgress!.message.toString()),
                            ElevatedButton(
                                onPressed: (){
                                  var newRoute = MaterialPageRoute(builder: (BuildContext context) => practice());
                                      Navigator.of(context).push(newRoute);
                                },
                                child: Text("Back to Practice"))
                          ],
                        ),
                      );*/
                },
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget selectIndex(){
    final provMdl = Provider.of<GetQuestionProvider>(context);
    /*  print(provMdl.queLength);
    currentQid = provMdl.queLength;
    setPQID = provMdl.queLength;*/
    List<Map> data = List.generate(provMdl.queLength > 20 ? provMdl.queLength : 20,
            (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // width: double.maxFinite,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 780,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 50,
                    mainAxisSpacing: 10
                ),
                // physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index)
                {
                  // isMarked = false;
                  return Stack(
                    // key: _stackkey,
                    children: [
                      Card(
                        key: ValueKey(data[index]['name']),
                        color: (provMdl.currentQid == index)
                            ? Colors.green : Colors.white,
                        elevation: 5,
                        child: ListTile(
                          enabled: provMdl.setPQID >= index ? true : false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          onTap: () async {
                            await provMdl.getQuestionApiWithIndex(index,0);

                            setState(() {
                              if(provMdl.getQuestionRepo.questionsAnswer!.sessionSpecific!.attempt!.isAnswered == true){
                                check = true;
                                isTrue = {};
                                optionColor = true;
                                isTrue =  provMdl.isTrueIds(provMdl.getQuestionRepo.questionsAnswer!.core!.options!,provMdl.getQuestionRepo.questionsAnswer!.sessionSpecific!.attempt!.answer!.data.toString());
                                print(isTrue);
                              }
                              else{
                                check = false;
                                optionColor = false;
                              }
                              provMdl.currentQid = index;
                              print("current id : $provMdl.currentQid");
                            });
                          },
                          title: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                (data[index]['id'] + 1).toString(),
                                style: GoogleFonts.poppins(fontSize: 11),
                              )),
                        ),
                      ),
                      /*(index == setQID)? const Positioned(
                        child: Icon(Icons.remove_red_eye_outlined, size: 12,),
                        right: 0,
                        top: -26,
                        bottom: 0,
                      ) : Container()*/
                    ],
                  ); },

              ),
            ),
          ),
          // questionWidget(queId: questions.elementAt(setQID),selectedQID: setQID),
        ],
      ),
    );
  }
/*====================================================================Solutions=================================================================*/

  Widget solutions(GetAnswer getAnswer){

    List<String> _linkList = [];
    String? _linkText;
    /*String _linkImage;*/
    for(var blockString in getAnswer.question!.core!.solution!.rawContent!.blocks!){
      if(blockString.text!.trim().toString() != ""){
        _linkList.add(functions().convertLetX(blockString.text.toString()));}
    }
    if(_linkList.isNotEmpty){
      _linkText = _linkList.join('\n');
    }
    return Column(
      children: [
        getAnswer.message != null ? Text(getAnswer.message.toString()) : Container(),
        const SizedBox(height: 10.0,),
        _linkText != null ?
        TeXView(
          child: TeXViewColumn(children: [
            _teXViewWidgetQuestion((_linkText.toString())),
          ]),
        ) : Container(),
        //  getAnswer.question!.core!.solution!.rawContent!.entityMap != null ?
        getAnswer.question!.core!.solution!.rawContent!.entityMap != null ?
        getAnswer.question!.core!.solution!.rawContent!.entityMap!.solve != null ?
        /* getAnswer.question!.core!.solution!.rawContent!.entityMap != null ?
        getAnswer.question!.core!.solution!.rawContent!.entityMap!.solve != null ?
        TeXView(
          child: TeXViewColumn(children: [
            _teXViewWidgetQuestion((getAnswer.question!.core!.solution!.rawContent!.entityMap!.solve!.data!.url.toString())),
          ]),
        )
        : Container() :*/
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(getAnswer.question!.core!.solution!.rawContent!.entityMap!.solve!.data!.url.toString()),
        )
            :  Container()
            :  requestSolution()
        /*  // Text(getAnswer.question!.core!.solution!.rawContent!.entityMap!.solve!.data!.url.toString())
           */
        /* :  TeXView(
            child: TeXViewColumn(children: [
              _teXViewWidgetQuestion((_linkText)),
            ])
        )    : Container()*/
      ],
    );
  }


  Widget requestSolution(){
    final provMdl = Provider.of<GetQuestionProvider>(context);
    print(provMdl.getQuestionModel!.question!.core!.sId);
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0))
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Solution not available yet.'),
          ElevatedButton(
              onPressed: (){
                provMdl.getQuestionRepo.requestSolution(provMdl.getQuestionModel!.question!.core!.sId.toString());
                print(provMdl.getQuestionModel!.question!.core!.sId);
              },
              child: Text('Request Solution'))
        ],
      ),
    );
  }
/*============================================ Questions ===================================================*/


  Widget question(Core core){
    networkimagecall(url) {
      var _url;
      _url =  networkImageToBase64(url);
      print(_url);
      return _url;
    }
    RawContent rawContent = core.content!.rawContent!;
    dynamic img;
    String? content;
    if(rawContent.entityMap != null && rawContent.entityMap!.length != 0){
      if(rawContent.entityMap![0].data!.url.runtimeType != String){
        img = networkimagecall(rawContent.entityMap![0].data!.url);}
      else{
        img = rawContent.entityMap![0].data!.url;
      }
      content =  rawContent.entityMap![0].data!.content;
    }
    List<String> _linkList = [];
    String? _linkText;
    /*String _linkImage;*/
    for(var blockString in rawContent.blocks!){
      if(blockString.text!.trim().toString() != ""){
        _linkList.add(functions().convertLetX(blockString.text.toString()));}
    }
    if(_linkList.isNotEmpty){
      _linkText = _linkList.join('\n');
    }
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(core.type.toString()),
        ),
        content != null ?
        TeXView(
          child: TeXViewColumn(children: [
            _teXViewWidgetQuestion((content.toString())),
          ]),
        ) : Container(),
        _linkText != null ?
        TeXView(
          child: TeXViewColumn(children: [
            _teXViewWidgetQuestion(r'\(Let \( A\) be the set of \( 4\) digit number \(  a_{1} a_{2} a_{3} a_{4}\) , where \(  a_{1} < a_{2} < a_{3}<  a_{4}\) , then \( n(A)\)   is equal to\)'),
          ]),
        ) : Container(),
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
                            child:img.runtimeType != String ? Image.memory(img) : CachedNetworkImage(
                                imageUrl:img!,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
                                imageBuilder: (context, image) => Image(
                                  image: image,
                                  height: MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.width,
                                  //  height: MediaQuery.of(context).size.height / 9,
                                  fit: BoxFit.contain,)
                            ),
                          ),
                        ),
                      ]
                  );
                }
            );
          },
          child: img.runtimeType != String
              ? /*FutureBuilder(
            future: img,
             builder: (context,snapshot) {
               return Image.memory(img);
             }
           )*/Image.memory(img)
              : CachedNetworkImage(
              imageUrl:img!,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
              imageBuilder: (context, image) => Image(
                image: image,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                //  height: MediaQuery.of(context).size.height / 9,
                fit: BoxFit.contain,)
          ),
        ):
        Container(),
      ],
    );
  }


/*============================================ Time Duration ===============================================*/


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
              margin: const EdgeInsets.only(top: 5, bottom: 5),
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
      decoration: const BoxDecoration(
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
            padding: const EdgeInsets.all(8),
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


  Widget option(List<Options>? options){
    final provMdl = Provider.of<GetQuestionProvider>(context);
    Core question = Core();
    question = provMdl.getQuestionModel!.question!.core!;
    var selectedIndexes = Provider.of<TestProviderClass>(context, listen: false).selectedIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 5.0),
        question.type == 'MULTIPLE_CHOICE_MULTIPLE_CORRECT' ||
            question.type == "LINKED_MULTIPLE_CHOICE_MULTIPLE_CORRECT"  ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(options!.length, (index) {
            String optionsValue = functions().convertLetX(options[index].content!.rawContent!.blocks![0].text.toString());
            List<String> _linkList = [];
            String? _linkText;
            String? _linkImage;
            String? contentText;
            if(options[index].content!.rawContent!.entityMap != null && options[index].content!.rawContent!.entityMap!.length != 0){
              if(options[index].content!.rawContent!.entityMap![0].data!.url != null){
                _linkImage = options[index].content!.rawContent!.entityMap![0].data!.url.toString();}
              else{
                contentText = functions().convertLetX(options[index].content!.rawContent!.entityMap![0].data!.content.toString());
              }
            }
            for(var blockString in options[index].content!.rawContent!.blocks!){
              if(blockString.text!.trim().toString() != ""){
                _linkList.add(functions().convertLetX(blockString.text.toString()));}
            }
            if(_linkList.isNotEmpty){
              _linkText = _linkList.join('\n');
              print(_linkText);
            }
            return
              CheckboxListTile(
                title: Column(
                  children: [
                    _linkText != null ?
                    TeXView(
                      child: TeXViewColumn(children: [
                        _teXViewWidget(optionsValue.toString()),
                      ]),
                    )
                        : Container(),
                    contentText != null ?
                    TeXView(
                      child: TeXViewColumn(children: [
                        _teXViewWidget(contentText.toString()),
                      ]),
                    )
                        : Container(),
                    _linkImage != null ?
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:CachedNetworkImage(
                            imageUrl: _linkImage.toString(),
                            placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
                            imageBuilder: (context, image) => Image(
                              image: image,
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width,
                              /*height: MediaQuery.of(context).size.height / 9,*/
                              fit: BoxFit.contain,)
                        )
                      //Image.network( options[index].content!.rawContent!.entityMap![0].data!.url.toString()),
                    )
                        : Container()
                  ],
                ),
                value: selectedIndexes.contains(options[index].sId),
                onChanged: (_) async {
                  print(question.sId);
                  print(options[index].sId);
                  setState(() {
                    ansId = options[index].sId;
                    queId =  question.sId.toString();
                    isEnable = true;
                  });
                  //  await provMdl.getQuestion(widget.topic.sId.toString());
                  // provMdl.getAnswer(options[index].sId, question.sId.toString());
                  print(options[index].content!.rawContent!.blocks![0]);
                  if (selectedIndexes.contains(options[index].sId)) {
                    selectedIndexes.remove(options[index].sId);   // unselect
                  } else {
                    selectedIndexes.add(options[index].sId);  // select
                  }
                  // print(selectedIndexes);
                },
                controlAffinity: ListTileControlAffinity.leading,
              )
            ;
          }),
        ):
        (question.type == 'LINKED_MULTIPLE_CHOICE_SINGLE_CORRECT' ||
            question.type == 'MULTIPLE_CHOICE_SINGLE_CORRECT') ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(options!.length, (index) {
            String optionsValue = functions().convertLetX(options[index].content!.rawContent!.blocks![0].text.toString());
            List<String> _linkList = [];
            String? _linkText;
            String? _linkImage;
            String? contentText;
            if(options[index].content!.rawContent!.entityMap != null && options[index].content!.rawContent!.entityMap!.length != 0){
              if(options[index].content!.rawContent!.entityMap![0].data!.url != null){
                _linkImage = options[index].content!.rawContent!.entityMap![0].data!.url.toString();}
              else{
                contentText = functions().convertLetX(options[index].content!.rawContent!.entityMap![0].data!.content.toString(),1);
              }
            }
            for(var blockString in options[index].content!.rawContent!.blocks!){
              if(blockString.text!.trim().toString() != ""){
                _linkList.add(functions().convertLetX(blockString.text.toString()));}
            }
            if(_linkList.isNotEmpty){
              _linkText = _linkList.join('\n');
              print(_linkText);
            }
            return RadioListTile(
                tileColor: optionColor ? isTrue[options[index].sId] == "true" ? Colors.green :isTrue[options[index].sId] == "false" ? Colors.red : Colors.white : Colors.white,
                title: Column(
                  children: [
                    _linkText != null ?
                    TeXView(
                      child: TeXViewColumn(children: [
                        _teXViewWidget(optionsValue.toString()),
                      ]),
                    )
                        : Container(),
                    contentText != null ?
                    TeXView(
                      child: TeXViewColumn(children: [
                        _teXViewWidget(contentText.toString()),//\frac{d.v_2^2}{v_1^2+v_2^2}
                      ]),
                    )
                        : Container(),
                    _linkImage != null ?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                          imageUrl: _linkImage.toString(),
                          placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Constants.green,)),
                          imageBuilder: (context, image) => Image(
                            image: image,
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width,
                            /*height: MediaQuery.of(context).size.height / 9,*/
                            fit: BoxFit.contain,)
                      ),
                      //Image.network( options[index].content!.rawContent!.entityMap![0].data!.url.toString()),
                    )
                        : Container()
                  ],
                ),
                //Text(options[index].content.rawContent.blocks[0].text.toString()),
                value: options[index].sId.toString(),
                groupValue: Provider.of<TestProviderClass>(context, listen: false).optionVal,
                onChanged: (value) async {
                  //await provMdl.getQuestion(widget.topic.sId.toString());
                  // provMdl.getAnswer(options[index].sId, question.sId.toString());
                  print(question.sId);
                  print(options[index].sId);
                  setState(() {
                    ansId = options[index].sId;
                    queId =  question.sId.toString();
                    isEnable = true;
                    Provider.of<TestProviderClass>(context, listen: false).optionVal = value.toString();
                  });
                }

            );
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
            children: List.generate(options!.length, (index) {
              return ListTile(
                title: Text(options[index].content!.rawContent!.blocks![0].text.toString()),
              );
            })),
        const SizedBox(height: 20.0,),
        // Text(options[ind].content.rawContent.blocks[0].text.toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            check ?
            ElevatedButton(onPressed: () async {
              //await provMdl.getQuestion(widget.topic.sId.toString(),widget.topic.name.toString());
              await Provider.of<GetQuestionProvider>(context, listen: false)
                  .getQuestionApiWithIndex(provMdl.currentQid! + 1,0);
              setState(() {
                provMdl.getAnswers.message == null;
                check = false;
                ansId = null;
                queId = null;
                isEnable = false;
                optionColor = false;
                /*setPQID ++;
                    currentQid = setPQID;*/
                print('currentId Next : $provMdl.currentQid');
              });
              //Navigator.pop(context);
            }, child: const Text('Next')):
            ElevatedButton(onPressed: () async {
              isEnable ? await provMdl.getAnswer(ansId.toString(), queId.toString()) : null;
              isEnable ? setState(()  {
                check = true ;
                optionColor = true;
                print(provMdl.getAnswers.question!.core!.options);
                isTrue = provMdl.isTrueIds(provMdl.getAnswers.question!.core!.options!, Provider.of<TestProviderClass>(context,listen: false).optionVal);
              }) : null;
            }, child: const Text('Check')),
            const SizedBox(width: 20.0,),
            ElevatedButton(onPressed: () async {
              await provMdl.closeQuestions();
              /*setState(() {
                    provMdl.getAnswers.message == null;
                  });*/
              Navigator.of(context).pop(practice());
            }, child: const Text('End Session'))
          ],
        ),
      ],
    );
  }

/*========================================================TextViewColumn==================================================*/

  static TeXViewWidget _teXViewWidgetQuestion( String body) {
    return TeXViewColumn(
        style:  TeXViewStyle(
            backgroundColor: Colors.transparent,
            margin: const TeXViewMargin.all(10),
            padding: const TeXViewPadding.all(10),
            textAlign: TeXViewTextAlign.Center,
            borderRadius: const TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.groove,
                borderColor: Constants.ligh_grey))),
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
  static TeXViewWidget _teXViewWidget( String body) {
    return TeXViewColumn(
        style:  TeXViewStyle(
          // margin: TeXViewMargin.all(10),
            padding: const TeXViewPadding.all(10),
            textAlign: TeXViewTextAlign.Center,
            borderRadius: const TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.groove,
                borderColor: Constants.ligh_grey))),
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
