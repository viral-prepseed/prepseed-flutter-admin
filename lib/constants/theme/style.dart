//style for the text container and border

import 'package:flutter/material.dart';

mixin Style {

  //container box decoration for border
  static BoxDecoration decoration =  BoxDecoration(
    borderRadius: Style.borderRadius(),
    color: Colors.blueGrey,
  );

  //font style with size of 15 and black bold
  static TextStyle textStyleBold15 = const TextStyle(
      fontSize: 15.0,
      color: Colors.black,
      fontWeight: FontWeight.bold
  );
  static TextStyle textStyleBold13 = const TextStyle(
      fontSize: 15.0,
      color: Colors.black,
      fontWeight: FontWeight.bold
  );

  //font style with size of 13 and white bold
  static TextStyle textStyleBold13White = const TextStyle(
      fontSize: 13.0,
      color: Colors.white,
      fontWeight: FontWeight.bold
  );

  //font style with size of 13 and regular black
  static TextStyle textStyleRegular13Black = const TextStyle(
      fontSize: 13.0,
      color: Colors.black,
  );

  //font style with size of 13 and regular white
  static TextStyle textStyleRegular13White = const TextStyle(
    fontSize: 13.0,
    color: Colors.black,
  );

  //font style with size of 15 and regular black
  static TextStyle textStyleRegular15Black = const TextStyle(
    fontSize: 13.0,
    color: Colors.black,
  );

  //for the divider - horizontal line
  static divider(){
    return const Divider(
      height: 2.0,
      color: Colors.blueGrey,
      thickness: 1.5,
    );
  }

  //for circular border
  static borderRadius(){
    return const BorderRadius.all(Radius.circular(10.0));
  }
}

