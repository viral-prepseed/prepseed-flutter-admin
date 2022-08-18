import 'package:flutter/material.dart';
import 'package:prepseed/model/assesments/getwrapper.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../helper/provider/testsProvider.dart';
import '../../menu/menu_widget.dart';
import 'package:provider/provider.dart';

class TopicTest extends StatefulWidget {
  const TopicTest({Key? key}) : super(key: key);

  @override
  State<TopicTest> createState() => _TopicTestState();
}

class _TopicTestState extends State<TopicTest> {
  List<AssessmentWrappers> list = [];
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<TestProviderClass>(context);
     list.addAll(myModel.tagValue) ;
    return Scaffold(
      appBar: AppBar(
        leading: MenuWidget(),
        elevation: 0,
        // title: Text('${context.watch<TestProviderClass>().tabValues}',style: GoogleFonts.poppins(color: Constants.black),),
        backgroundColor: Constants.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('LiveTest'),
          ),
          SizedBox(height: 10.0,),
          Style.divider(),
          SizedBox(height: 10.0,),
          Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context,index){
                  return  Container(
                    //  padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration:conDecoration,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(list[index].name.toString()),
                          ),
                          Style.divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Questions'),
                                Text('20')
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Durations'),
                                Text('${(list[index].core!.duration!/60).toInt().toString()} mins')
                              ],
                            ),
                          ),
                          Style.divider(),
                          Container(
                            // padding: EdgeInsets.all(10.0),
                            height: 40.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock,size: 15.0),
                                TextButton(
                                    onPressed: (){}, child: Text('Unlock Now',style: TextStyle(
                                    fontSize: 13.0
                                ),)),
                              ],
                            ),
                          ),

                        ],
                      )
                  );
                },
              )
          )
        ],
      ),
    );
  }
  BoxDecoration conDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: const BorderRadius.all(
          Radius.circular(10.0))
  );
}
