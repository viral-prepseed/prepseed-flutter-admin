import '../../constants/colorPalate.dart';
import '../../constants/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../model/playlist_model/document_model/resource_document_model.dart';
import '../menu/menu_widget.dart';

class ResourceDocumentView extends StatefulWidget {

  Items item;

  ResourceDocumentView({Key? key, required this.item}) : super(key: key);

  @override
  _ResourceDocumentViewState createState() => _ResourceDocumentViewState();
}

class _ResourceDocumentViewState extends State<ResourceDocumentView> {
  PdfViewerController controller = PdfViewerController();
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
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
                      controller.clearSelection();
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                  widget.item.resource!.title.toString(),
                  style: Style.textStyleBold15
                ),
              ],
            ),

            Style.divider(),
            const SizedBox(height: 10.0,),
            Expanded(
                child: widget.item.resource!.endpoints == null
                    ? const Center(child: Text("Documents is not Available"))
                    : SfPdfViewer.network(
                    widget.item.resource!.endpoints![0].toString(),
                    controller: controller,
                 )),
          ],
        ),
      ),
    );
  }
}
