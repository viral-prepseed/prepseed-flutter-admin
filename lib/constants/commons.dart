import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prepseed/constants/colorPalate.dart';

class Commons{
  static Widget loading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(18), child: Text(message)),
        loader(),
      ],
    );
  }

  static Widget loader() {
    return Center(child: SpinKitPouringHourGlassRefined(
      /*itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Color(0xFFFFFFFF) : Color(0xFF311433),
          ),
        );
      },*/
      color: Constants.yellow,
    ));
  }

}