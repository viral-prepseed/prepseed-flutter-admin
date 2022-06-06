import 'package:flutter/material.dart';
import 'package:prepseed/views/menu/menu_widget.dart';
import '../../constants/colorPalate.dart';

class assignments extends StatefulWidget {
  const assignments({Key? key}) : super(key: key);

  @override
  _assignmentsState createState() => _assignmentsState();
}

class _assignmentsState extends State<assignments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: Container(),
    );
  }
}
