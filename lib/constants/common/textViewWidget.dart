
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../colorPalate.dart';

class TexViewWidget{
  TeXViewWidget teXViewWidgetQuestion( String body) {
    return TeXViewColumn(
        style:  TeXViewStyle(
            backgroundColor: Colors.transparent,
            margin: const TeXViewMargin.all(10),
            padding: const TeXViewPadding.all(10),
            textAlign: TeXViewTextAlign.Center,
            borderRadius: const TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.groove,
                borderColor: Constants.ligh_grey))),
        children: [/*
          TeXViewDocument(title,
              style: const TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  // textAlign: TeXViewTextAlign.center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Colors.green)),*/
          TeXViewDocument(body,
              style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
        ]);
  }
  TeXViewWidget teXViewWidget( String body) {
    return TeXViewColumn(
        style:  TeXViewStyle(
          // margin: TeXViewMargin.all(10),
            padding: const TeXViewPadding.all(10),
            textAlign: TeXViewTextAlign.Center,
            borderRadius: const TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.groove,
                borderColor: Constants.ligh_grey))),
        children: [/*
          TeXViewDocument(title,
              style: const TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  // textAlign: TeXViewTextAlign.center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Colors.green)),*/
          TeXViewDocument(body,
              style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
        ]);
  }
}