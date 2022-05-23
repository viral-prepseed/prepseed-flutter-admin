import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class liveScreen extends StatefulWidget {
  const liveScreen({Key? key}) : super(key: key);

  @override
  _liveScreenState createState() => _liveScreenState();
}

class _liveScreenState extends State<liveScreen> {
  late TooltipBehavior _tooltipBehavior;

  final List<Map<String, String>> listOfColumns = [
    {"Name": "Total", "Number": "1","a": "Total", "b": "1","c": "Total", "d": "1","e": "Total", "f": "1", },
    {"Name": "Watched Live", "Number": "2","a": "Total", "b": "1","c": "Total", "d": "1","e": "Total", "f": "1",},
    {"Name": "Watched Later", "Number": "3","a": "Total", "b": "1","c": "Total", "d": "1","e": "Total", "f": "1",},
    {"Name": "Missed", "Number": "3","a": "Total", "b": "1","c": "Total", "d": "1","e": "Total", "f": "1",},
  ];

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    columns: const [
                      DataColumn(label: Text('Subject	')),
                      DataColumn(label: Text('Your Marks')),
                      DataColumn(label: Text('Percentage')),
                      DataColumn(label: Text('Average Marks	')),
                      DataColumn(label: Text('Highest Marks')),
                      DataColumn(label: Text('Topper Marks')),
                      DataColumn(label: Text('Percentile')),
                      DataColumn(label: Text('Cumulative Percentile')),
                    ],
                    rows:
                    listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                      ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(element["Name"]!)), //Extracting from Map element the value
                          DataCell(Text(element["Number"]!)),
                          DataCell(Text(element["a"]!)),
                          DataCell(Text(element["b"]!)),
                          DataCell(Text(element["c"]!)),
                          DataCell(Text(element["d"]!)),
                          DataCell(Text(element["e"]!)),
                          DataCell(Text(element["f"]!)),
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
