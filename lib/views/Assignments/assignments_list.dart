import 'package:learning_module/model/playlist_model/playlists.dart';
import 'package:learning_module/view/Assignments/assignment.dart';
import 'package:learning_module/view/common/appbar.dart';
import 'package:learning_module/view/common/drawer.dart';
import 'package:learning_module/repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignmentsList extends StatefulWidget {
  Playlists assi = Playlists();

  AssignmentsList({Key? key, required this.assi}) : super(key: key);

  @override
  _AssignmentsListState createState() => _AssignmentsListState();
}

class _AssignmentsListState extends State<AssignmentsList> {
  @override
  void initState() {
    final provMdl = Provider.of<VideosProvider>(context, listen: false);
    provMdl.getAssignments(widget.assi.sId!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);
    //final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: const AppBarItems(),
      drawer: const SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, "/videos_homescreen");
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                  widget.assi.title.toString() /*model.playlist!.title.toString()*/,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                )
              ],
            ),
            Expanded(
              child: provMdl.assignmentModel.playlist != null ?
              ListView.builder(
                  itemCount: provMdl.assignmentModel.playlist!.items!.length,
                  itemBuilder: (context, index) {
                    /*String? topic;
                    for (int i = 0; i < provMdl.assignmentModel.playlist!.items![index].resource!.tags!.length; i++) {
                      if (provMdl.assignmentModel.playlist!.items![index].resource!.tags![i].key == "Topic") {
                        // print(widget.list!.items![index].resource!.tags![i].value);
                        topic = provMdl.assignmentModel.playlist!.items![index].resource!.tags![i].value;
                      }
                    }*/
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(provMdl.assignmentModel.playlist!.items![index].resource!.title.toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Image.network(
                                provMdl.assignmentModel.playlist!.items![index].resource!.thumbNailsUrls![0].toString(),
                                width: 100.0,
                                height: 50.0,
                              ),
                              Expanded(
                                  child: Text(provMdl.assignmentModel.playlist!.items![index].resource!.title.toString())),
                            ],
                          ),
                          onTap: () {
                            widget.assi.hasAccessToContent == true ?
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Assignments(
                                    item: provMdl.assignmentModel.playlist!.items![index]))) : Container();
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    );
                  })
                  :const Center(child: CircularProgressIndicator(),),
            ),
          ],
        ),
      ),
    );
  }
}
