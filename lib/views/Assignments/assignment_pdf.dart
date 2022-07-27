import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constants/theme/style.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
              ],
            ),

            Style.divider(),
            const SizedBox(height: 10.0,),
            Expanded(
              child: SfPdfViewer.network(
                  widget.url.toString(),
                  // initialScrollOffset: Offset(0, 500),
                  initialZoomLevel: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
