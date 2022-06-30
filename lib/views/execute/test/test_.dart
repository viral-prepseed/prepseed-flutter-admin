import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/provider/DataClassProvider.dart';
import 'HomeScreen2.dart';

class testprovider extends StatefulWidget {
  testprovider({Key? key}) : super(key: key);

  @override
  _testproviderState createState() => _testproviderState();
}

class _testproviderState extends State<testprovider> {
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
              return Text(myModel.count.toString());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigation),
          backgroundColor: Colors.green,
          onPressed: () {
            // Provider.of<ProviderClass>(context, listen: false).count += 1;

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen2()));
            //navigate to page to increase count...
          },
        ),
        body: Consumer<ProviderClass>(builder: (context, myModel, child) {
          //The Consumer widget rebuilds any widgets below it whenever notifyListeners() gets called.
          return ListView.builder(
            itemCount: myModel.post == null
                ? 0
                : myModel.post.length, //length according to data present
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text(Provider.of<ProviderClass>(context, listen: false).post[index]
                      .title!),
                  trailing: Icon(Icons.more_vert),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}