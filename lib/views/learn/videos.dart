import 'package:flutter/material.dart';
import 'package:prepseed/views/menu/menu_widget.dart';
import '../../constants/colorPalate.dart';

class videos extends StatefulWidget {
  const videos({Key? key}) : super(key: key);

  @override
  _videosState createState() => _videosState();
}

class _videosState extends State<videos> {
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
