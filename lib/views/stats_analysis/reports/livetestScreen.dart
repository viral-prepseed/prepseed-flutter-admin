import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/helper/provider/analysis/report.dart';
import 'package:prepseed/model/assesments/reports.dart';
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
  List<Items> listOfItems = [];

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
    listOfItems = Provider.of<ReportClass>(context).items;
    // print(listOfColumns);
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
              SizedBox(height: 10,),
              /*ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 20,),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listOfItems.length,
                  itemBuilder: (context, idx){
                  var _items = listOfItems.elementAt(idx);
                    return Wrap(
                      children: [
                        Text(_items.details![0].name!,style: GoogleFonts.poppins(fontSize: 20),),
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
                    );
              })*/
              testDetails()
            ],
          ),
        )
      ),
    );
  }
  Widget testDetails(){
    final provMdl = Provider.of<ReportClass>(context);
    listOfColumns = Provider.of<ReportClass>(context).listOfColumns;
    listOfItems = Provider.of<ReportClass>(context).items;

    /*listOfColumns =  [{'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]},
    {'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]}];
    */
    /*listOfColumns = Provider.of<ReportClass>(context, listen: false).listOfColumns;
    print(listOfColumns);*/

    // final List<Map> listOfColumns = Provider.of<ReportClass>(context, listen: false).listOfColumns;
    /* print(provMdl.mapStatsMax);*/
    return Consumer(builder: (context, reportsModel, child){
      // print(listOfColumns);
      // print(reportsModel.allReportsList.first.user!.overall!.marks);

      /* for(int i = 0; i <= listOfItems.length; i++){
        *//*if(listOfItems[i].user != null){*//*
         per = listOfItems[i].user!.overall!.marks! * listOfItems[i].statsBySection!.overall!.highestMarks! / 100 ;
        //}
      }*/
      //print(per);
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              border:  TableBorder.all(width:1, color:Colors.black45),
              columns: [
                DataColumn(label:  Text("Name")),
                DataColumn(label:  Text("Date")),
                DataColumn(label:  Text("Self")),
                DataColumn(label:  Text("High")),
                DataColumn(label:  Text("Avg")),
                DataColumn(label:  Text("Self")),
                DataColumn(label:  Text("High")),
                DataColumn(label:  Text("Avg")),
                DataColumn(label:  Text("Self")),
                DataColumn(label:  Text("High")),
                DataColumn(label:  Text("Avg")),
                DataColumn(label:  Text("Self")),
                DataColumn(label:  Text("High")),
                DataColumn(label:  Text("Avg")),
                DataColumn(label:  Text("Max")),
                DataColumn(label: Text("%age")),
                DataColumn(label:  Text("Physics")),
                DataColumn(label:  Text("Mathematics")),
                DataColumn(label:  Text("Chemistry")),
                DataColumn(label:  Text("overall")),
              ],
              rows: listOfItems.map((element) =>
                  DataRow(
                      cells: [
                        DataCell(Text(element.details![0].name.toString())),
                        DataCell(Text(element.details![0].availableFrom.toString())),
                        element.user != null ? element.user!.physics/*!.marks*/ != null ? DataCell(Text(element.user!.physics!.marks.toString()/*element['physics'].elementAt(0).toString()*/)) : DataCell(Text("0")): DataCell(Text("0")),
                        element.topper!.physics != null ? DataCell(Text(element.topper!.physics!.marks.toString())) : DataCell(Text("0")),
                        element.statsBySection!.physics != null ? DataCell(Text(element.statsBySection!.physics!.averageMarks.toString())) : DataCell(Text("0")),
                        element.user != null ? element.user!.mathematics != null ? DataCell(Text(element.user!.mathematics!.marks.toString()/*element['mathematics'].elementAt(0).toString()*/)) : DataCell(Text("0")) : DataCell(Text("0")),
                        element.topper!.mathematics != null ? DataCell(Text(element.topper!.mathematics!.marks.toString())) : DataCell(Text("0")),
                        element.statsBySection!.mathematics != null ? DataCell(Text(element.statsBySection!.mathematics!.averageMarks.toString())): DataCell(Text("0")),
                        element.user != null ? element.user!.chemistry != null ? DataCell(Text(element.user!.chemistry!.marks.toString()/*(element['chemistry'].elementAt(0).toString()*/)) : DataCell(Text("0")) : DataCell(Text("0")),
                        element.topper!.chemistry != null ? DataCell(Text(element.topper!.chemistry!.marks.toString())) : DataCell(Text("0")),
                        element.statsBySection!.chemistry != null ? DataCell(Text(element.statsBySection!.chemistry!.averageMarks.toString())) : DataCell(Text("0")),
                        element.user != null ? DataCell(Text(element.user!.overall!.marks.toString()/*element['overall'].elementAt(0).toString()*/)) : DataCell(Text("0")),
                        element.topper!.overall!.marks != null ? DataCell(Text(element.topper!.overall!.marks.toString())) : DataCell(Text("0")),
                        DataCell(Text(element.statsBySection!.overall!.averageMarks.toString())),
                        DataCell(Text(element.maxMarks!.overall.toString())),
                        element.user != null ? DataCell(Text(
                            (element.user!.overall!.marks! / element.maxMarks!.overall!*100).toString().substring(0,3)))
                            : DataCell(Text("0")),
                        element.statsBySection!.physics != null ? DataCell(Text(element.statsBySection!.physics!.percentile.toString())) : DataCell(Text("0")),
                        element.statsBySection!.mathematics != null ? DataCell(Text(element.statsBySection!.mathematics!.percentile.toString())) : DataCell(Text("0")),
                        element.statsBySection!.chemistry != null ? DataCell(Text(element.statsBySection!.chemistry!.percentile.toString())) : DataCell(Text("0")),
                        DataCell(Text(element.statsBySection!.overall!.percentile.toString())),
                      ]
                  )).toList()
          ),
        ),
      );
    });
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
