import 'package:learning_module/model/playlist_model/playlists.dart';
import 'package:learning_module/constant/theme/style.dart';
import 'package:learning_module/view/common/appbar.dart';
import 'package:learning_module/view/common/drawer.dart';
import 'package:learning_module/repository/playlist_provider/videos_provider.dart';
import 'package:learning_module/view/videos/vimeo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistVideos extends StatefulWidget {
  Playlists? list;

  PlaylistVideos({Key? key, required this.list}) : super(key: key);

  @override
  _PlaylistVideosState createState() => _PlaylistVideosState();
}

class _PlaylistVideosState extends State<PlaylistVideos> {
  @override
  void initState() {
    final provMdl = Provider.of<VideosProvider>(context, listen: false);
    provMdl.getVideoPlaylist(widget.list!.sId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);
    return Scaffold(
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
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                  widget.list!.title.toString() /*model.playlist!.title.toString()*/,
                  style: Style.textStyleBold15
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.list!.items!.length,
                  itemBuilder: (context, index) {
                    String? topic;
                    widget.list!.items![index].resource!.tags!.forEach((element) {
                      if (element.key == "Topic") {
                        // print(widget.list!.items![index].resource!.tags![i].value);
                        topic = element.value;
                      }
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0,),
                        Text(topic.toString(),style: Style.textStyleRegular15Black,),
                        const SizedBox(height: 20.0,),
                        InkWell(
                          child: Row(
                            children: [
                              Image.network(
                                widget.list!.items![index].resource!.thumbNailsUrls![0].toString(),
                                width: 100.0,
                                height: 50.0,
                              ),
                              Expanded(
                                  child: Text(widget.list!.items![index].resource!.title.toString(),style: Style.textStyleRegular13Black,)),
                            ],
                          ),
                          onTap: () {
                            widget.list!.hasAccessToContent == true
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Vimeo(list: provMdl.list.playlist!.items!)))
                            : Container();
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
