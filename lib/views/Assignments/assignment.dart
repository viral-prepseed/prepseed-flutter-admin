import 'package:learning_module/model/playlist_model/assignment_model/assignment_model.dart';
import 'package:learning_module/view/Assignments/assignment_pdf.dart';
import 'package:learning_module/view/common/appbar.dart';
import 'package:learning_module/view/common/drawer.dart';
import 'package:learning_module/repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class Assignments extends StatefulWidget {
  AssignmentItems item;

  Assignments({Key? key, required this.item}) : super(key: key);

  @override
  _AssignmentsState createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarItems(),
      drawer: const SideBar(),
      body:
      Column(
        //physics: const NeverScrollableScrollPhysics(),
        //padding: const EdgeInsets.all(10.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.pop(context, "/videos_homescreen");
                    //Navigator.pushReplacementNamed(context, "/videos_homescreen");
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              Text(
                widget.item.resource!.title.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ],
          ),
          // Text(widget.item.resource!.description.toString()),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            height: 2.0,
            color: Colors.blueGrey,
            thickness: 1.5,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text("Assignment File"),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  AssignmentPdf(url: widget.item.resource!.files![0].url.toString()))
                );
            }, child: Text(widget.item.resource!.files![0].name.toString())),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            height: 2.0,
            color: Colors.blueGrey,
            thickness: 1.5,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text("Submit Assignment"),
          ElevatedButton(
              onPressed: (){
                _pickFile(context);
              }, child: const Text("Upload File")),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            height: 2.0,
            color: Colors.blueGrey,
            thickness: 1.5,
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  AssignmentPdf(url: widget.item.resource!.files![0].url.toString()))
                );
              }, child: const Text("Submit")),
         /* pick != null ?
          Image.asset(pick.toString()) : Container(),*/
          /*Expanded(
            //height: size.height,
              child: widget.item.resource!.files![0].url == null
                  ? Center(child: Text("Documents is not Available"))
                  : SfPdfViewer.network(
                  widget.item.resource!.files![0].url.toString(),
                // initialScrollOffset: Offset(0, 500),
                initialZoomLevel: 1.5)),*/
        ],
      ),
    );
  }

  String? pick;
  void _pickFile(context) async {
    VideosProvider provMdl = VideosProvider();
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    var file = result.files.first;
    provMdl.uploadAssignment(file, file.identifier!);
    print(file.path);
  }
  void _openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
