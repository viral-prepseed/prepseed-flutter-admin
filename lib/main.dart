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
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/database_helper.dart';
import 'helper/provider/analysisProvider.dart';
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