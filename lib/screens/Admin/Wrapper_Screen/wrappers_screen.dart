
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prepsed_principal/provider/wrappers_provider/wrappers_provider.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({Key? key}) : super(key: key);

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class Phas {
  String? id;
  String? name;

  Phas({
    required this.id,required this.name,
  });
}

class _WrapperScreenState extends State<WrapperScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController txtKeyword = TextEditingController();
  late TextEditingController txtPhases1 = TextEditingController();
  late TextEditingController txtPhases2 = TextEditingController();
  late TextEditingController txtPhases3 = TextEditingController();
  late TextEditingController txtFromDate = TextEditingController();
  late TextEditingController txtToDate = TextEditingController();


  final _editFormKey = GlobalKey<FormState>();


  WrappersProvider wrappersProvider = WrappersProvider();
  late TextEditingController txtEditAvalFrom = TextEditingController();

  List<String> tags = [];
  List<String> tag = [
    'JavaScript',
    'Python',
    'Java',
    'PHP',
    'C#',
    'C++',
    'Dart',
    'DataFlex',
    'Flutter'
  ];

  List<Phas> phas = [];
  List<String> p = [];

  // page var (p-1)*l
  int skip = 0;
  final limit = 5;
  int start = 1;
  int end = 5;
  int? isEnd = 0;
  int page = 0;
  int ine = 1;
  bool isPause = false;
  int k = 0;

  ScrollController _controller = ScrollController();

  // _increment() {
  //   setState(() {
  //     isPause = true;
  //     if(skip < limit) {
  //       skip++;
  //     }
  //     else if (skip==limit) {
  //       skip++;
  //       limit = limit + 5;
  //     }
  //     wrappersProvider.getWrapperData(skip, limit, null, [], null, null);
  //     isPause = false;
  //   });
  // }

  _increment() {
    setState(() {
      k++;
    });
  }

  @override
  void initState() {

    phas = [
      Phas(id: "62d28123c3b1c93214b59ae5", name: "SAT Special Phase(Weshine)"),
      Phas(id: "62d2806f1823ab209aa71b96", name: "JEE Special Phase(Weshine)"),
      Phas(id: "628c8a6d7640243d911a6cc6", name: "Prepare Demo"),
    ];
    // if(skip==0) {

    // }
    // init();
    wrappersProvider.getWrapperData(null, [], null, null);

    // if(wrappersProvider.wrappers!.isNotEmpty) {
    //   // for(int i = 0; i<wrappersProvider.wrappers!.length; i++) {
    //   //   if (kDebugMode) {
    //   //     print(wrappersProvider.wrappers![i].name);
    //   //   }
    //   // }
    //
    //
    //   p = [];
    //   page = (isEnd!.toInt() / limit).ceil();
    //   _controller = ScrollController()..addListener(_increment);

    if(wrappersProvider.isHigher==false) {
      _controller.addListener(() {
        // var nextPageTrigger = 0.9 * _controller.position.maxScrollExtent;

        // if (_controller.position.pixels > nextPageTrigger) {
        if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
          if(wrappersProvider.isHigher==false) {
            // print("$nextPageTrigger ${_controller.position.maxScrollExtent} ${_controller.position.minScrollExtent} ${_controller.position.pixels}");
            wrappersProvider.getWrapperData(null, [], null, null);
          }
          _increment();
        }
      });
    }

    // }

    super.initState();
  }

  init() async {
    // await wrappersProvider.getWrapperData(skip, limit, null, [], null, null)
    /*.then(
    (value) {
      isEnd = wrappersProvider.total!.toInt() - limit;
      if (kDebugMode) {
        print("isEnd: $isEnd");
      }
    })*/
    await wrappersProvider.getWrapperData(null, [], null, null);
    isEnd = wrappersProvider.total.toInt() - limit;
    if (kDebugMode) {
      print("isEnd: $isEnd");
    }
    // await print("1");
  }


  editWrapper(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: [
              const Text("Available from: "),
              TextFormField(),
            ],
          )
        );
      }
    );
  }

  listIncrement() {
    // setState(() {
    //   start = end + 1;
    //   end = end + end;
    // });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ChangeNotifierProvider.value(
            value: wrappersProvider,
            child: Consumer<WrappersProvider>(
              builder: (context, provi, _) {
                // if (isPause == true) {
                //   Container(
                //     margin: const EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                //     child: const CircularProgressIndicator(),
                //   );
                // }
                return SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [

                              // Keyword
                              TextFormField(
                                controller: txtKeyword,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  label: const Text('Keywords'),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              /*// Phases1
                              TextFormField(
                                controller: txtPhases1,
                                textInputAction: TextInputAction.next,
                                // onChanged: (val) {
                                //   txtPhases1.text = val;
                                // },
                                decoration: InputDecoration(
                                  label: const Text('Phases1'),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Phases1
                              TextFormField(
                                controller: txtPhases2,
                                textInputAction: TextInputAction.next,
                                // onChanged: (val) {
                                //   txtPhases2.text = val;
                                // },
                                decoration: InputDecoration(
                                  label: const Text('Phases2'),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Phases2
                              TextFormField(
                                controller: txtPhases3,
                                textInputAction: TextInputAction.next,
                                // onChanged: (val) {
                                //   txtPhases3.text = val;
                                // },
                                decoration: InputDecoration(
                                  label: const Text('Phases3'),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),*/




                              DropdownSearch<String>.multiSelection(
                                items: const ["SAT Special Phase(Weshine)", "JEE Special Phase(Weshine)", "Prepare Demo"],
                                // items: phas,
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  menuProps: MenuProps(barrierLabel: "Menu"),
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: const Text("Phases"),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onChanged: (val) {
                                  p.clear();
                                  for(int i=0; i<phas.length; i++) {
                                    for(int j=0; j<val.length; j++) {
                                      if(p.contains(phas[i].id)==false){
                                        if(val[j]==phas[i].name) {
                                          setState(() {
                                            p.add(phas[i].id.toString());
                                            if (kDebugMode) {
                                              print(p);
                                            }
                                          });
                                        }
                                      }
                                    }

                                  }
                                  if (kDebugMode) {
                                    print(val);
                                  }
                                },
                              ),
                              const SizedBox(height: 10),

                              // From Date
                              TextFormField(
                                controller: txtFromDate,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  labelText: "From Date",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(3030),
                                  );

                                  if (dateTime != null) {
                                    if (kDebugMode) {
                                      print(dateTime);
                                    }
                                    // var time = DateTime.parse("2018-08-16T11:00:00.000Z");
                                    var d = DateFormat("yyyy-MM-dd").format(dateTime);
                                    if (kDebugMode) {
                                      print("Date: $d");
                                    }
                                    setState(() {
                                      txtFromDate.text = d.toString();
                                    });
                                  }


                                },
                              ),
                              const SizedBox(height: 10),

                              // To Date
                              TextFormField(
                                controller: txtToDate,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  labelText: "To Date",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(3030),
                                  );

                                  if (dateTime != null) {
                                    if (kDebugMode) {
                                      print(dateTime);
                                    }
                                    // var time = DateTime.parse("2018-08-16T11:00:00.000Z");
                                    var d = DateFormat("yyyy-MM-dd").format(dateTime);
                                    if (kDebugMode) {
                                      print("Date: $d");
                                    }
                                    setState(() {
                                      txtToDate.text = d.toString();
                                    });
                                  }


                                },
                              ),
                              const SizedBox(height: 10),


                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("${wrappersProvider.wrappers!.length.toString()} wrappers found $k"),

                            ElevatedButton(
                              onPressed: () {


                                if (kDebugMode) {
                                  print("${txtKeyword.text} $p ${txtFromDate.text} ${txtToDate.text}");
                                }

                                wrappersProvider.getWrapperData(
                                  // skip,
                                  // limit,
                                  txtKeyword.text=="" ? null : txtKeyword.text,
                                  p,
                                  txtFromDate.text=="" ? null : txtFromDate.text,
                                  txtToDate.text=="" ? null : txtToDate.text,
                                );

                                setState(() { });
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text(wrappersProvider.wrappers[0].name.toString())));

                              },
                              child: const Text("Search"),
                            ),

                            ElevatedButton(
                              onPressed: () {

                                if (kDebugMode) {
                                  print("Add Wrapper");
                                }

                                wrappersProvider.getWrapperData(
                                    // skip,limit,
                                    null,[],null,null);

                                setState(() {

                                });
                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text(wrappersProvider.wrappers[0].name.toString())));

                              },
                              child: const Text("Add Wrapper"),
                            ),

                          ],
                        ),
                      ),

                      // wrappersProvider.wrappers!.isNotEmpty
                      //   ? ListView.builder(
                      //       itemCount: end,
                      //       physics: const ScrollPhysics(),
                      //       shrinkWrap: true,
                      //       itemBuilder: (context,index) {
                      //         return Text(" => ${wrappersProvider.wrappers![index].name}");
                      //       }
                      //     )
                      //   : Text("${wrappersProvider.wrappers!.length}"),
                      const SizedBox(height: 20,),

                      wrappersProvider.wrappers!.isEmpty
                      ? Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        child: const Text("No Data Found"),
                      )
                      : GridView.builder(
                          itemCount: wrappersProvider.wrappers!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 20,
                            childAspectRatio: 2/1.3,
                          ),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,ind) {

                            var time = wrappersProvider.wrappers![ind].core!.duration;

                            var h = int.parse(time.toString()) ~/ 3600;
                            String? hour = '';
                            if(h.toString().length==1) {
                              hour = "0$h";
                            }
                            else {
                              hour = "$h";
                            }

                            var m = ((int.parse(time.toString()) - h * 3600)) ~/ 60;
                            String? minute = '';
                            if(m.toString().length==1) {
                              minute = "0$m";
                            }
                            else {
                              minute = "$m";
                            }

                            var s = int.parse(time.toString()) - (h * 3600) - (m * 60);
                            var second = '';
                            if(s.toString().length==1) {
                              second = "0$s";
                            }
                            else {
                              second = "$s";
                            }

                            var duration = "$hour:$minute:$second";


                            var availableFrom = wrappersProvider.wrappers![ind].availableFrom;
                            var parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(availableFrom.toString());
                            var inputDate = DateTime.parse(parseDate.toString());
                            var outputDate = DateFormat('dd-MMM-yyyy hh:mm a');
                            availableFrom = outputDate.format(inputDate);

                            var availableTill = wrappersProvider.wrappers![ind].availableTill;
                            var parse = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(availableTill.toString());
                            var inDate = DateTime.parse(parse.toString());
                            var outDate = DateFormat('dd-MMM-yyyy hh:mm a');
                            availableTill = outDate.format(inDate);

                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              margin: const EdgeInsets.only(top: 2,bottom: 2,left: 12,right: 12),
                              elevation: 3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 20,bottom: 8,right: 8,left: 8),
                                child: Column(
                                  children: [

                                    Tooltip(
                                      message: "${wrappersProvider.wrappers![ind].name}",
                                      child: Text(
                                        "${wrappersProvider.wrappers![ind].name}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    const SizedBox(height: 12,),

                                    const Divider(height: 1.2,thickness: 1.2,color: Colors.black45,),

                                    const SizedBox(height: 8,),

                                    Column(
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Duration',style: TextStyle(fontWeight: FontWeight.w500),),
                                            Text(duration),
                                          ],
                                        ),

                                        const SizedBox(height: 4,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                          const Text('Available From',style: TextStyle(fontWeight: FontWeight.w500),),
                                          Text(availableFrom,textAlign: TextAlign.end,)
                                        ],),

                                        const SizedBox(height: 4,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                          const Text('Available Till',style: TextStyle(fontWeight: FontWeight.w500),),
                                          Text(availableTill,textAlign: TextAlign.end,)
                                        ],),

                                        const SizedBox(height: 4,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                          const Text('Attempts',style: TextStyle(fontWeight: FontWeight.w500),),
                                          Text('${wrappersProvider.wrappers![ind].wrapperAnalysis!.liveAttempts}'),
                                        ],),

                                        const SizedBox(height: 4,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                          const Text('Graded',style: TextStyle(fontWeight: FontWeight.w500),),
                                          wrappersProvider.wrappers![ind].graded == true
                                          ? const Text('Yes')
                                          : const Text("No"),
                                        ],),

                                        const SizedBox(height: 4,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                          const Text('Visibility',style: TextStyle(fontWeight: FontWeight.w500),),
                                          wrappersProvider.wrappers![ind].onlyCBT == false
                                          ? const Tooltip(
                                              message: "This wrapper can be used in Prepseed CBT and Prepseed Portal",
                                              child: Text('Everywhere'),
                                            )
                                          : Tooltip(
                                              message: "This wrapper can be used in Prepseed CBT and Prepseed Portal",
                                              child: Text("${wrappersProvider.wrappers![ind].onlyCBT}")
                                            ),
                                        ],),


                                      ],
                                    ),

                                    const SizedBox(height: 12,),

                                    Tooltip(
                                      message: "Manage all wrappers associate with this wrapper's published core ${wrappersProvider.wrappers![ind].core!.identifier}",
                                      child: OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(width: 3,),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          // editWrapper(context);

                                          showDialog(
                                            context: context,
                                            builder: (context) {

                                              var availableFrom = wrappersProvider.wrappers![ind].availableFrom;
                                              var parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(availableFrom.toString());
                                              var avilTime = DateFormat("'T'HH:mm:ss.SSS'Z'").parse(availableFrom.toString());
                                              var inputDate = DateTime.parse(parseDate.toString());
                                              var outputDate = DateFormat('dd-MMM-yyyy hh:mm a');
                                              availableFrom = outputDate.format(inputDate);

                                              var availableTill = wrappersProvider.wrappers![ind].availableTill;
                                              var parse = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(availableTill.toString());
                                              var inDate = DateTime.parse(parse.toString());
                                              var outDate = DateFormat('dd-MMM-yyyy hh:mm a');
                                              availableTill = outDate.format(inDate);

                                              return AlertDialog(
                                                title: const Text("Edit Wrapper"),
                                                content: Column(
                                                  children: [



                                                    Form(
                                                      key: _editFormKey,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller: txtEditAvalFrom,
                                                            // initialValue: parseDate.toString(),
                                                            decoration: InputDecoration(
                                                              prefixIcon: const Icon(Icons.calendar_today),
                                                              labelText: "Available From",
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              DateTime? dateTime = await showDatePicker(
                                                                context: context,
                                                                initialDate: DateTime.now(),
                                                                firstDate: DateTime(2015),
                                                                lastDate: DateTime(3030),
                                                              );

                                                              if (dateTime != null) {
                                                                if (kDebugMode) {
                                                                  print(dateTime);
                                                                }
                                                                  // var time = DateTime.parse("2018-08-16T11:00:00.000Z");
                                                                var d = DateFormat("yyyy-MM-dd").format(dateTime);
                                                                if (kDebugMode) {
                                                                  print("Date: $d");
                                                                }
                                                                setState(() {
                                                                  txtEditAvalFrom.text = d.toString();
                                                                });
                                                              }

                                                              Duration? picked = await showTimePicker(
                                                                context: context,
                                                                initialTime: Duration.now(),
                                                              );



                                                            },

                                                          ),
                                                        ],
                                                      )
                                                    ),
                                                  ],
                                                )
                                              );
                                            }
                                          );

                                          // showDialog(
                                          //   context: context,
                                          //   builder: (context) {
                                          //     return AlertDialog(
                                          //         content: Column(
                                          //           children: [
                                          //             Form(
                                          //               key: _editFormKey,
                                          //               child: Row(
                                          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //                 children: [
                                          //                   const Text("Available from: "),
                                          //
                                          //                   TextFormField(),
                                          //                 ],
                                          //               ),
                                          //             )
                                          //           ],
                                          //         )
                                          //     );
                                          //   }
                                          // );
                                        },
                                        icon: const Icon(CupertinoIcons.pencil,size: 30),
                                        label: const Text("Edit Wrappers",),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            );

                          },
                        ),

                      const SizedBox(height: 20,),

                      // if(wrappersProvider.isHigher==false)
                      //   ElevatedButton(
                      //     onPressed: () {
                      //       listIncrement();
                      //       setState(() {
                      //         wrappersProvider.getWrapperData(null, [], null, null);
                      //
                      //         // skip = (ine-1) * page;
                      //         // ine++;
                      //         // isEnd-=skip;
                      //         // if(skip>isEnd) {
                      //         //   skip=wrappersProvider.wrappers!.length;
                      //         //   wrappersProvider.getWrapperData(skip, limit, null, [], null, null);
                      //         //   Fluttertoast.showToast(msg: "The End");
                      //         // }
                      //         // else if(skip==wrappersProvider.wrappers!.length) {
                      //         //   Fluttertoast.showToast(msg: "The End");
                      //         // }
                      //         // else {
                      //         //   wrappersProvider.getWrapperData(skip, limit, null, [], null, null);
                      //         // }
                      //
                      //
                      //         /*if(isEnd!.toInt() <= limit || skip==wrappersProvider.total) {
                      //
                      //           print("$isEnd");
                      //           if(skip==wrappersProvider.total) {
                      //             Fluttertoast.showToast(
                      //               msg: "The End",
                      //               fontSize: 20,
                      //               backgroundColor: Colors.red.shade600,
                      //             );
                      //           } else {
                      //             skip = end;
                      //             end = end + 5;
                      //             isEnd = wrappersProvider.total!.toInt() - isEnd!.toInt();
                      //             print("IsEnd: $isEnd");
                      //             skip = isEnd!.toInt();
                      //             print("$skip $end $isEnd");
                      //             wrappersProvider.getWrapperData(skip, limit, null, [], null, null);
                      //             skip=wrappersProvider.total!.toInt();
                      //           }
                      //
                      //         }
                      //         else {
                      //           skip = end;
                      //           end = end + 5;
                      //           isEnd = isEnd!.toInt() - limit;
                      //           print("$skip $end $isEnd");
                      //           wrappersProvider.getWrapperData(skip, limit, null, [], null, null);
                      //         }*/
                      //       });
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4, vertical: 5),
                      //       textStyle: const TextStyle(
                      //         fontSize: 24,
                      //         fontWeight: FontWeight.bold
                      //       ),
                      //     ),
                      //     child: const Text("Next"),
                      //   ),

                      wrappersProvider.isLoad == true ?
                        Container(
                          height: 120,
                          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ) : Container(),

                      const SizedBox(height: 20,),



                    ],
                  ),
                );
              }
            ),
          ),

    );
  }
}

