import 'package:flutter/cupertino.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../model/playlist_model/playlists.dart';
import '../../../views/learning_module/Assignments/assignment.dart';
import '../../../repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../menu/menu_widget.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height:20.0),
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
            Style.divider(),
            SizedBox(height:10.0),
            Expanded(
              child: provMdl.assignmentModel.playlist != null ?
              ListView.builder(
                padding: EdgeInsets.all(10.0),
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
                          height: 10.0,
                        ),
                        Text(provMdl.assignmentModel.playlist!.items![index].resource!.title.toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: provMdl.assignmentModel.playlist!.items![index].resource!.thumbNailsUrls![0].toString(),
                                placeholder: (context, url) => Image(
                                image: AssetImage("assets/images/logo.png"),
                                width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.height / 9,
                                fit: BoxFit.contain,),
                                imageBuilder: (context, image) => Image(
                                  image: image,
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 9,
                                fit: BoxFit.contain,)
                              ),
                              /*Image.network(
                                provMdl.assignmentModel.playlist!.items![index].resource!.thumbNailsUrls![0].toString(),
                                width: 100.0,
                                height: 50.0,
                              ),*/
                              const SizedBox(
                                width: 20.0,
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
                          height: 10.0,
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
