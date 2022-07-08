import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/helper/provider/analysis/report.dart';
import 'package:provider/provider.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class liveScreen extends StatefulWidget {
  const liveScreen({Key? key}) : super(key: key);

  @override
  _liveScreenState createState() => _liveScreenState();
}

class _liveScreenState extends State<liveScreen> {
  late TooltipBehavior _tooltipBehavior;
  List<Map> listOfColumns = [];

  @override
  void initState(){
    Future.microtask(() async => {

      /*await Provider.of<ReportClass>(context, listen: false)
          .getReportsAPI(),*/
    });

    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listOfColumns = Provider.of<ReportClass>(context).listOfColumns;
    print(listOfColumns);
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  // title: ChartTitle(text: '% Marks'),
                  // Enable legend
                  legend: Legend(isVisible: false),
                  // Enable tooltip
                  tooltipBehavior: _tooltipBehavior,

                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource:  <SalesData>[
                          SalesData('Jan', 35),
                          SalesData('Feb', 28),
                          SalesData('Mar', 34),
                          SalesData('Apr', 32),
                          SalesData('May', 40)
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true)
                    )
                  ]
              ),
              SizedBox(height: 35,),
              Text('Path Finder_MCT-1_12-07-2021_Test paper',style: GoogleFonts.poppins(fontSize: 20),),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(
                        width: 1,
                        color: Constants.grey
                    ),
                    columns:
                    // List.generate(listOfColumns!.elementAt(0).length, (index) => DataColumn(label: Text(listOfColumns!.elementAt(0).keys.elementAt(index))),),


                    [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Overall')),
                      DataColumn(label: Text('physics	')),
                      DataColumn(label: Text('chemistry	')),
                      DataColumn(label: Text('mathematics	')),
                    ],
                    rows:
                    listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                      ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(element["Name"]!)), //Extracting from Map element the value
                          DataCell(Text(element["Date"]!)),
                          DataCell(Text(element["overall"].elementAt(1).toString())),
                          DataCell(Text(element["physics"].elementAt(1).toString())),
                          DataCell(Text(element["chemistry"].elementAt(1).toString())),
                          DataCell(Text(element["mathematics"].elementAt(1).toString())),
                        ],
                      )),
                    )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
