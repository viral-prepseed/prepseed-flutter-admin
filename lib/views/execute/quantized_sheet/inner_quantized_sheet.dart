import 'package:flutter/material.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:prepseed/helper/sharedPref.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';

class inner_quantized_sheet extends StatefulWidget {
  final List<AssessmentWrappers> tabvaluedata;
  const inner_quantized_sheet(this.tabvaluedata, {Key? key}) : super(key: key);

  @override
  _inner_quantized_sheetState createState() => _inner_quantized_sheetState();
}

class _inner_quantized_sheetState extends State<inner_quantized_sheet> {
  late var topicTitle = '';
   late List<AssessmentWrappers> tabvaluedata;
   var questionList = [];

  @override
  void initState() {
    getprefs();
    tabvaluedata = widget.tabvaluedata;
  }

  getprefs() async{
    topicTitle = await sharedPref().getSharedPref('topicTitle');
    setState(() {
      topicTitle;
    });

    for(var i = 0; i<tabvaluedata.length; i++){
      (tabvaluedata[i].tags?.last.value!.trim() == topicTitle)? questionList.add(tabvaluedata[i].name): '';
    }
    setState(() {
      questionList;
    });
    print(questionList);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.058),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.all(5.0),
                  children: List.generate(questionList.length, (index) => Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Constants.backgroundColor
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Constants.black,
                        border: Border.all(color: Constants.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Tooltip(
                                message: '${questionList[index]}',
                                child: Text('${questionList[index]}',
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,),
                              ),
                            ),
                            Divider(color: Constants.grey,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Questions'),
                                Text('54'),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Duration'),
                                Text('3 hrs'),
                              ],
                            ),
                            Divider(color: Constants.grey,),
                            ElevatedButton(onPressed: (){},
                                child: Text('Unlock Now'))
                          ],
                        ),
                      ),
                    ),
                  )
                  ),
                )
            ),
          )),
    );
  }
}
