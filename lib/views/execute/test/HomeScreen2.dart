import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/provider/DataClassProvider.dart';

class HomeScreen2 extends StatefulWidget {
  HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  void initState() {
    //initState to perform all task before page loads...
    super.initState();
    Future.microtask(() async => {
      Provider.of<ProviderClass>(context, listen: false)
          .apiCall(), //provider to call API and update data....
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Consumer<ProviderClass>(
            //Consumer widget rebuilds any widgets below it whenever notifyListeners() gets called.
            builder: (context, myModel, child) {
              return Text("Increase Count");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            Provider.of<ProviderClass>(context, listen: false).count += 1;
          },
        ),
        body: Consumer<ProviderClass>(builder: (context, myModel, child) {
          //The Consumer widget rebuilds any widgets below it whenever notifyListeners() gets called.
          return Center(
            child: Text(
              Provider.of<ProviderClass>(context, listen: false)
                  .count
                  .toString(),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          );
        }),
      ),
    );
  }
}