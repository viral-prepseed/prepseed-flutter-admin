import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/helper/bigText.dart';

import '../../../constants/colorPalate.dart';

class attendenceScreen extends StatefulWidget {
  const attendenceScreen({Key? key}) : super(key: key);

  @override
  _attendenceScreenState createState() => _attendenceScreenState();
}

class _attendenceScreenState extends State<attendenceScreen> {

  final List<Map<String, String>> listOfColumns = [
    {"Name": "Total", "Number": "1", },
    {"Name": "Watched Live", "Number": "2",},
    {"Name": "Watched Later", "Number": "3",},
    {"Name": "Missed", "Number": "3",}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 32,
          // height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: Constants.grey,
              child: Container(
                // height: 150,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // bigText(text: 'Physics Mechanics', color: Constants.black, size: 25),
                          DataTable(
                            columns: const [
                              DataColumn(label: Text('Physics Mechanics')),
                              DataColumn(label: Text('')),
                            ],
                            rows:
                            listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                                .map(
                              ((element) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(element["Name"]!)), //Extracting from Map element the value
                                  DataCell(Text(element["Number"]!)),
                                ],
                              )),
                            )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
