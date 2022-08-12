import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/constants/theme/style.dart';
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
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
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
    );
  }
  Widget testDetails(){
   //final provMdl = Provider.of<ReportClass>(context);
    listOfColumns = Provider.of<ReportClass>(context).listOfColumns;
    listOfItems = Provider.of<ReportClass>(context).items;
    print(listOfColumns);
    print(listOfItems);
    /*listOfColumns =  [{'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]},
    {'Name': 'APT01 Paper 1', 'Date': '2022-05-15T03:30:48.289Z', 'overall': [71, 112, 66], 'physics': [48, 56, 31], 'chemistry': [6, 37, 16], 'mathematics': [17, 38, 18]}];
    */

    return Consumer(builder: (context, reportsModel, child){
      // print(listOfColumns);
      // print(reportsModel.allReportsList.first.user!.overall!.marks);

      /* for(int i = 0; i <= listOfItems.length; i++){
        *//*if(listOfItems[i].user != null){*//*
         per = listOfItems[i].user!.overall!.marks! * listOfItems[i].statsBySection!.overall!.highestMarks! / 100 ;
        //}
      }*/
      //print(per);
      return Container(
            height: 290.0,
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: listOfColumns.length,
              itemBuilder: (context,index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0,),
                    Text(listOfColumns[index].values.elementAt(0).toString()),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 110.0,
                     // padding: EdgeInsets.all(10.0),
                      decoration:conDecoration,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Subject',style: Style.textStyleBold13,),
                                Text(listOfColumns[index].keys.elementAt(2).toString()),
                                Text(listOfColumns[index].keys.elementAt(3).toString()),
                                Text(listOfColumns[index].keys.elementAt(4).toString()),
                                Text(listOfColumns[index].keys.elementAt(5).toString()),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Your Marks',style: Style.textStyleBold13,),
                                Text("${listOfColumns[index].values.elementAt(2)[0].toString()}/${listOfColumns[index].values.elementAt(2)[2].toString()}"),
                                Text("${listOfColumns[index].values.elementAt(3)[0].toString()}/${listOfColumns[index].values.elementAt(3)[2].toString()}"),
                                Text("${listOfColumns[index].values.elementAt(4)[0].toString()}/${listOfColumns[index].values.elementAt(4)[2].toString()}"),
                                Text("${listOfColumns[index].values.elementAt(5)[0].toString()}/${listOfColumns[index].values.elementAt(5)[2].toString()}"),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Percentage',style: Style.textStyleBold13,),
                                Text((listOfColumns[index].values.elementAt(2)[0]/listOfColumns[index].values.elementAt(2)[2]*100).toString().substring(0,3)),
                                Text((listOfColumns[index].values.elementAt(3)[0]/listOfColumns[index].values.elementAt(3)[2]*100).toString().substring(0,3)),
                                Text((listOfColumns[index].values.elementAt(4)[0]/listOfColumns[index].values.elementAt(4)[2]*100).toString().substring(0,3)),
                                Text((listOfColumns[index].values.elementAt(5)[0]/listOfColumns[index].values.elementAt(5)[2]*100).toString().substring(0,3)),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Avarage Marks',style: Style.textStyleBold13,),
                                Text(listOfColumns[index].values.elementAt(2)[3].toString()),
                                Text(listOfColumns[index].values.elementAt(3)[3].toString()),
                                Text(listOfColumns[index].values.elementAt(4)[3].toString()),
                                Text(listOfColumns[index].values.elementAt(5)[3].toString()),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Highest Marks',style: Style.textStyleBold13,),
                                Text(listOfColumns[index].values.elementAt(2)[4].toString()),
                                Text(listOfColumns[index].values.elementAt(3)[4].toString()),
                                Text(listOfColumns[index].values.elementAt(4)[4].toString()),
                                Text(listOfColumns[index].values.elementAt(5)[4].toString()),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Toper Marks',style: Style.textStyleBold13,),
                                Text(listOfColumns[index].values.elementAt(2)[5].toString()),
                                Text(listOfColumns[index].values.elementAt(3)[5].toString()),
                                Text(listOfColumns[index].values.elementAt(4)[5].toString()),
                                Text(listOfColumns[index].values.elementAt(5)[5].toString()),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Percentile',style: Style.textStyleBold13,),
                                Text('16.66'),
                                Text('16.66'),
                                Text('16.66'),
                                Text('16.66'),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Cumulative Percentile',style: Style.textStyleBold13,),
                                Text(listOfColumns[index].values.elementAt(2)[1].toString()),
                                Text(listOfColumns[index].values.elementAt(3)[1].toString()),
                                Text(listOfColumns[index].values.elementAt(4)[1].toString()),
                                Text(listOfColumns[index].values.elementAt(5)[1].toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          );
    });
  }
  BoxDecoration conDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: const BorderRadius.all(
          Radius.circular(10.0))
  );
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
