import 'package:flutter/material.dart';
import 'package:prepseed/views/menu/menu_widget.dart';
import '../../constants/colorPalate.dart';

class documents extends StatefulWidget {
  const documents({Key? key}) : super(key: key);

  @override
  _documentsState createState() => _documentsState();
}

class _documentsState extends State<documents> {
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
