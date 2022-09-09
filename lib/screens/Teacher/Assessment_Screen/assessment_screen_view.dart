
import 'package:flutter/material.dart';
import 'package:prepsed_principal/models/Teacher/Assessment_Model/assessment_model.dart';

class AssessmentScreenT extends StatefulWidget {
  const AssessmentScreenT({Key? key}) : super(key: key);

  @override
  State<AssessmentScreenT> createState() => _AssessmentScreenTState();
}

class _AssessmentScreenTState extends State<AssessmentScreenT> {

  List<String> headingList = [];
  List<String> nameList = [];
  List<int> durationList = [];
  List<int> sectionList = [];
  List<String> marketingSchemesList = [];
  List<String> otherConfigList = [];
  List<String> hasOptionalQueList = [];

  late List<Assessment> rows;

  @override
  void initState() {
    // TODO: implement initState

    headingList = [
      "Name",
      "Duration",
      "Sections",
      "Marking Scheme",
      "Other configs",
      "Has Optional Ques.",
    ];

    nameList = [
      "PHYSICS TT-KTG & Thermodynamics",
      "MATHEMATICS TT-Vector & 3D -1",
      "CHEMISTRY TT-Mole Concept & Redox",
      "PHYSICS TT-Elasticity,Calorimetry,Heat transfer",
      "MATHEMATICS TT-Determinant & Matrices",
      "CHEMISTRY TT-Thermodynamics & Thermochemistry",
      "PHYSICS TT-SHM",
      "MATHEMATICS TT-Diffrential Equation & Area",
      "CHEMISTRY TT-Chemical Eq & Ionic Eq",
      "PHYSICS TT-Fluid Mechanics",
      " ",
      "PHYSICS TT-KTG & Thermodynamics",
      "MATHEMATICS TT-Vector & 3D -1",
      "CHEMISTRY TT-Mole Concept & Redox",
      "PHYSICS TT-Elasticity,Calorimetry,Heat transfer",
      "MATHEMATICS TT-Determinant & Matrices",
      "CHEMISTRY TT-Thermodynamics & Thermochemistry",
      "PHYSICS TT-SHM",
      "MATHEMATICS TT-Diffrential Equation & Area",
      "CHEMISTRY TT-Chemical Eq & Ionic Eq",
      "PHYSICS TT-Fluid Mechanics",
    ];

    durationList = [3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600,];

    sectionList = [1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1,];

    marketingSchemesList = [
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
      'MCMC: JEE_2019 Columns: JEE_2019',
    ];

    otherConfigList = [
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
      "QNum: overall-increasing",
    ];

    hasOptionalQueList = ["No", "No", "No", "No", "No", "No", "No", "No", "No", "No","No", "No", "No", "No", "No", "No", "No", "No", "No", "No","No", "No", "No", "No", "No", "No", "No", "No", "No", "No",];

    super.initState();
  }

  // List<DataColumn> getColumn(List<String> columns)
  //   => headingList.map((String? headingName)
  //     => DataColumn(label: Text(headingName.toString()))).toList();
  //
  // List<DataRow> getRows(List<Assessment> assessment) => rows.map((Assessment row) {
  //   final cells = [row.name,row.duration,row.sections,row.markingScheme,row.otherConfigs,row.hasOptionalQues];
  //
  //   return DataRow(cells: getDataCells(cells));
  // }).toList();

  // List<DataCell> getDataCells(List<dynamic> cells) => cells.map((data) => DataCell(cells)).toList();

  // Widget buildTable() {
  //   return DataTable(columns: getColumn(headingList), rows: getRows(rows));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Section",style: TextStyle(color: Colors.black),),
        // backgroundColor: Colors.white30,
        elevation: 0,
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Assessments",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Text(
              "Assessments",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
              ),
            ),

            // Table(
            //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            //
            //   children: const [
            //     TableRow(
            //       children: [
            //         Text("Name", style: TextStyle(fontWeight: FontWeight.bold,),),
            //         Text("Duration", style: TextStyle(fontWeight: FontWeight.bold,),),
            //         Text("Sections", style: TextStyle(fontWeight: FontWeight.bold,),),
            //         Text("Marking Scheme", style: TextStyle(fontWeight: FontWeight.bold,),),
            //         Text("Other configs", style: TextStyle(fontWeight: FontWeight.bold,),),
            //         Text("Has Optional Ques.", style: TextStyle(fontWeight: FontWeight.bold,),),
            //       ]
            //     ),
            //     TableRow(
            //       children: [
            //         Text("Name"),
            //         Text("Duration"),
            //         Text("Sections"),
            //         Text("Marking Scheme"),
            //         Text("Other configs"),
            //         Text("Has Optional Ques."),
            //       ]
            //     ),
            //   ],
            // ),

            // DataTable(
            //
            //   columns: const [
            //     DataColumn(label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold,),),),
            //     DataColumn(label: Text("Duration", style: TextStyle(fontWeight: FontWeight.bold,),),),
            //     DataColumn(label: Text("Sections", style: TextStyle(fontWeight: FontWeight.bold,),),),
            //     DataColumn(label: Text("Marking Scheme", style: TextStyle(fontWeight: FontWeight.bold,),),),
            //     DataColumn(label: Text("Other configs", style: TextStyle(fontWeight: FontWeight.bold,),),),
            //     DataColumn(label: Text("Has Optional Ques.", style: TextStyle(fontWeight: FontWeight.bold,),),)
            //   ],
            //   rows: const [
            //     DataRow(
            //       cells: [
            //         DataCell(Text("Name"),),
            //         DataCell(Text("Duration"),),
            //         DataCell(Text("Sections"),),
            //         DataCell(Text("Marking Scheme"),),
            //         DataCell(Text("Other configs"),),
            //         DataCell(Text("Has Optional Ques."),),
            //       ]
            //     )
            //   ]
            // )

            // buildTable()

          ],
        ),
      ),
    );
  }
}

