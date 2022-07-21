import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AssignmentPdf extends StatefulWidget {

  String? url;
  AssignmentPdf({required this.url});
  @override
  _AssignmentPdfState createState() => _AssignmentPdfState();
}

class _AssignmentPdfState extends State<AssignmentPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network(
          widget.url.toString(),
          // initialScrollOffset: Offset(0, 500),
          initialZoomLevel: 1.5),
    );
  }
}
