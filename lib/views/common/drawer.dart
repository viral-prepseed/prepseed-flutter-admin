import 'package:learning_module/view/Assignments/Assignments_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/playlist_provider/videos_provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    final provMdl = Provider.of<VideosProvider>(context, listen: false);
    provMdl.getVideos(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);
    return Drawer(
      child: provMdl.data.playlistTypeLabels != null
      ? ListView(
        //padding: EdgeInsets.all(10.0),
        shrinkWrap: true,
        children: [
          const Image(
            image: AssetImage("assets/icon.jpg"),
            width: 50.0,
            height: 60.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Learn",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Expanded(
                child: Divider(
                  height: 20.0,
                  thickness: 2.0,
                  color: Color.fromARGB(255, 233, 233, 233),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                 Navigator.pushNamed(context, '/videos_homescreen');
              },
              label: Text(
                provMdl.data.playlistTypeLabels!.video.toString(),
                style: const TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.app_registration,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                 Navigator.pushNamed(context, '/document_homescreen');
              },
              label: Text(
                provMdl.data.playlistTypeLabels!.resourceDocument.toString(),
                style: const TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.app_registration,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AssignmentHomeScreen(
                          docs: provMdl.data.playlists!,
                        )));*/
                 Navigator.pushNamed(context, '/assignment_homescreen');
              },
              label: Text(
                provMdl.data.playlistTypeLabels!.assignment.toString(),
                style: const TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.app_registration,
                color: Colors.black,
              ),
            ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator(),)
    );
  }
}
