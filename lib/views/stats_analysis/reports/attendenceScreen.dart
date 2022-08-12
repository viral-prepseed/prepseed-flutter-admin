import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/constants/theme/style.dart';
import 'package:prepseed/helper/bigText.dart';
import 'package:prepseed/helper/provider/reports/videoAttendanceProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/colorPalate.dart';

class attendenceScreen extends StatefulWidget {
  const attendenceScreen({Key? key}) : super(key: key);

  @override
  _attendenceScreenState createState() => _attendenceScreenState();
}

class _attendenceScreenState extends State<attendenceScreen> {

  @override
  void initState() {
    Future.microtask(() async => {
      await Provider.of<VideoAttendanceProviderClass>(context, listen: false)
          .apiCall(),
    });
  }

  final List<Map<String, String>> listOfColumns = [
    {"Name": "Total", "Number": "1", },
    {"Name": "Watched Live", "Number": "2",},
    {"Name": "Watched Later", "Number": "3",},
    {"Name": "Missed", "Number": "3",}
  ];

  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideoAttendanceProviderClass>(context);
    return Scaffold(
      body:  ChangeNotifierProvider.value(
        value: provMdl,
        child: Consumer(builder: (context, dataItems, _) {
              return provMdl.subjectName != null ? ListView.builder(
                itemCount: provMdl.subjectName.length,
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(provMdl.subjectName[index].toString(),style: Style.textStyleBold13,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Total"),
                                Text(provMdl.map.values.elementAt(index).length.toString(),style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Watched Live"),
                                Text("0"),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Watch Later"),
                                Text("0"),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Missed"),
                                Text(provMdl.map.values.elementAt(index).length.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Style.divider(),
                    ],
                  );
                },
              ) : Center(child: CircularProgressIndicator());
        }
        )
      ) );
  }
}
