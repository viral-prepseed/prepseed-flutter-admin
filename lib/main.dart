import 'package:flutter/material.dart';
import 'package:prepseed/helper/provider/DataClassProvider.dart';
import 'package:prepseed/helper/provider/analysis/report.dart';
import 'package:prepseed/helper/provider/leadershipProvider.dart';
import 'package:prepseed/helper/provider/reports/videoAttendanceProvider.dart';
import 'package:prepseed/helper/provider/sectionProvider.dart';
import 'package:prepseed/helper/provider/userDerailsProvider.dart';
import 'package:prepseed/repository/playlist_provider/videos_provider.dart';
import 'package:prepseed/views/SplashScreen.dart';
import 'package:prepseed/views/execute/test/test_.dart';
import 'package:provider/provider.dart';

import 'helper/provider/analysisProvider.dart';
import 'helper/provider/practice/getquestion_provider.dart';
import 'helper/provider/tests/assessmentWrappers.dart';
import 'helper/provider/testsProvider.dart';
import 'model/dataclass.dart';
import 'views/login/prepseed_loginScreen.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(
   const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserClass>(create: (_) => UserClass(),),
        ChangeNotifierProvider<ProviderClass>(create: (_) => ProviderClass(),),
        ChangeNotifierProvider<TestProviderClass>(create: (_) => TestProviderClass(),),
        // ChangeNotifierProvider<sectionProviderClass>(create: (_) => sectionProviderClass(),),
        ChangeNotifierProvider<VideosProvider>(create: (_) => VideosProvider(),),
        ChangeNotifierProvider<AnalysisClass>(create: (_) => AnalysisClass(),),
        ChangeNotifierProvider<LeadershipClass>(create: (_) => LeadershipClass(),),
        ChangeNotifierProvider<AssessmentWrappersClass>(create: (_) => AssessmentWrappersClass(),),
        ChangeNotifierProvider<ReportClass>(create: (_) => ReportClass(),),
        ChangeNotifierProvider<VideoAttendanceProviderClass>(create: (_) => VideoAttendanceProviderClass(),),
        ChangeNotifierProvider<GetQuestionProvider>(create: (_) => GetQuestionProvider(),),
      ],
      child: MaterialApp(
        // title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen() //quantized_sheet_new()//,
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generating a long list to fill the ListView
  final List<Map> data = List.generate(100,
          (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kindacode.com'),
        ),
        body: SafeArea(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 5,
                mainAxisExtent: 45,
                crossAxisSpacing: 10,
                childAspectRatio: (2),
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext ctx, index) {
               return Container(
                  // color: data[index]['isSelected'] = true ? Colors.amber : Colors.white,
                  child: Card(
                    key: ValueKey(data[index]['name']),
                    color: data[index]['isSelected'] == true
                        ? Colors.amber
                        : Colors.white,
                    elevation: 5,
                    child: ListTile(
                      tileColor: data[index]['isSelected'] == true
                          ? Colors.amber
                          : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0.0),
                      onTap: () {
                        setState(() {
                          print(data[index]['isSelected']);
                          (data[index]['isSelected'] == true )? data[index]['isSelected'] = false : data[index]['isSelected'] =  true;
                          print(data[index]['isSelected']);
                        });
                      },
                      title: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            data[index]['id'].toString(),
                            // style: GoogleFonts.poppins(fontSize: 11),
                          )),
                    ),
                  ),
                );
              },
            )));
  }
}