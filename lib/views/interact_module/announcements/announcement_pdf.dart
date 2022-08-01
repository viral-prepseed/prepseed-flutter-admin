import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AnnouncementPDF extends StatefulWidget {

  String? url;
  AnnouncementPDF({required this.url});
  @override
  _AnnouncementPDFfState createState() => _AnnouncementPDFfState();
}

class _AnnouncementPDFfState extends State<AnnouncementPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, "");
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              /*Text(
                  widget.,
                  style: Style.textStyleBold15
              )*/
            ],
          ),
          Expanded(
            child: SfPdfViewer.network(
                widget.url.toString(),
                // initialScrollOffset: Offset(0, 500),
                initialZoomLevel: 1.5),
          ),
        ],
      ),
    );
  }
}
