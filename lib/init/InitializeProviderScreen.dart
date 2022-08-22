import 'package:flutter/material.dart';
import 'package:prepseed/helper/provider/leadershipProvider.dart';
import 'package:prepseed/views/execute/test/viewAnalysis.dart';
import 'package:prepseed/views/home/landingScreen.dart';
import 'package:prepseed/views/stats_analysis/analysis/analysis.dart';

import '../constants/commons.dart';
import 'package:provider/provider.dart';

import '../helper/provider/analysis/report.dart';
import '../helper/provider/analysisProvider.dart';
import '../helper/sharedPref.dart';

class InitializeProviderScreen extends StatefulWidget {
  const InitializeProviderScreen({Key? key}) : super(key: key);

  @override
  _InitializeProviderScreenState createState() => _InitializeProviderScreenState();
}

class _InitializeProviderScreenState extends State<InitializeProviderScreen> {

  getAssesmentId() async {
    var id = await sharedPref().getSharedPref('assessmentWrapperId');
    var userId = await sharedPref().getSharedPref('userId');
    // print(userId);

    Future.microtask(() async => {
      await Provider.of<AnalysisClass>(context, listen: false)
          .apiCall(userId,id),
    });
    // _tabController = TabController(length: 3, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadInitials(),
    );
  }

  Widget _loadInitials() {
    return FutureBuilder(
      future: Provider.of<LeadershipClass>(context, listen: false)
          .apiCall(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text(
              'Fetch data',
              textAlign: TextAlign.center,
            );
          case ConnectionState.active:
            return Text('');
          case ConnectionState.waiting:
            return Commons.loading("Fetching Data For You...");
          case ConnectionState.done:
            if (snapshot.hasError) {
              /*return Error(
                errorMessage: "Error retrieving Data.",
              );*/
            } else {
              return viewAnalysis();
            }
        }
        return Commons.loading("Fetching Data For You...");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
