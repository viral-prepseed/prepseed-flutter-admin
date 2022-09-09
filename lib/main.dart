
import 'package:flutter/material.dart';
import 'package:prepsed_principal/provider/principal_provider/principal_provider.dart';
import 'package:prepsed_principal/provider/wrappers_provider/wrappers_provider.dart';
import 'package:prepsed_principal/repository/repository_data.dart';
import 'package:prepsed_principal/screens/Admin/Wrapper_Screen/wrappers_screen.dart';
import 'package:prepsed_principal/screens/Assessment_Screen/assessment_screen_view.dart';
import 'package:prepsed_principal/screens/Principal_Screen/principal_screen_view.dart';
import 'package:prepsed_principal/screens/Teacher/Assessment_Screen/assessment_screen_view.dart';
import 'package:prepsed_principal/screens/Videos_Screen/videos_screen_view.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    // const MyApp()
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrincipalProvider()),
        ChangeNotifierProvider(create: (_) => WrappersProvider()),
      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // '/' : (context) => const Users(),
        // "/" : (context) => const VideosScreen(),
        // "/" : (context) => const AssessmentScreenT(),
        "/" : (context) => const WrapperScreen(),
      },
      // home: const Users(),
      // home: const AssessmentScreen(),
    );
  }
}
