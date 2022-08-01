import '../../../constants/colorPalate.dart';
import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import '../../../constants/theme/style.dart';
import '../../../views/learning_module/videos/comment/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../../menu/menu_widget.dart';

class Vimeo extends StatefulWidget {
  List<Items> list;

  Vimeo({Key? key, required this.list}) : super(key: key);

  @override
  _VimeoState createState() => _VimeoState();
}

class _VimeoState extends State<Vimeo> {
  TextEditingController controller = TextEditingController();



  int index = 0;
  @override
  Widget build(BuildContext context) {
   // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            const SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(widget.list[index].resource!.title.toString(),
                    style: Style.textStyleBold15
                  ),
                ),
              ],
            ),
            Style.divider(),
            const SizedBox(height: 20.0,),
            widget.list[index].resource!.embedUrlId != null
                ? SizedBox(
                    height: 200.0,
                    child: VimeoPlayer(
                          videoId: widget.list[index].resource!.embedUrlId!, //widget.list!.sId!,
                    ),
                  )
                : Container(
                    height: 200.0,
                    padding: const EdgeInsets.all(70.0),
                    child: const Text(
                      "Video not Available",
                      textAlign: TextAlign.center,
                    )),
            const SizedBox(height: 20.0,),
            Text(
              widget.list[index].resource!.title.toString(),
              style: Style.textStyleBold15,
            ),
            const SizedBox(height: 10.0,),
            Text(widget.list[index].resource!.description.toString(),
              style: Style.textStyleRegular13Black,
            ),
            const SizedBox(height: 10.0,),
            Style.divider(),
            const SizedBox(height: 10.0,),
            Text("Comments 10",style: Style.textStyleBold15,),
            /*Row(
              children: const [
                Text(
                  "Comments",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "10",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                )
              ],
            ),*/
            Container(
              margin: const EdgeInsets.all(10.0),
              height: 45.0,
              width: 500.0,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 196, 197),
                  borderRadius: Style.borderRadius()),
              child: TextButton.icon(
                  onPressed: () {
                    bottomSheet(widget.list[index].resource!);
                  },
                  icon: const Icon(
                    Icons.comment,
                    color: Color.fromARGB(255, 121, 115, 109),
                  ),
                  label: const Text("Add/View Comment(s)",
                    style: TextStyle(
                        color: Color.fromARGB(255, 121, 115, 109),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  )),
            ),
            const SizedBox(height: 10.0,),
            Style.divider(),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet(Resource cmt) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          //final size = MediaQuery.of(context).size;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context, "");
                        },
                        iconSize: 25.0,
                        padding: const EdgeInsets.fromLTRB(1.0, 1.0, 15.0, 1.0),
                        icon: const Icon(Icons.arrow_back_rounded)
                    ),
                    Text(
                      cmt.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                TextField(
                  scrollPadding: const EdgeInsets.all(10.0),
                  controller: controller,
                  decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 196, 196, 197),
                      filled: true,
                      hintText: 'Comment',
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 15.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send,
                            color: Color.fromARGB(255, 121, 115, 109)),
                        onPressed: () {
                          //prov.postComment(controller.text.toString(),widget.list.resource!.sId.toString());
                          FocusScope.of(context).unfocus();
                          // Navigator.pushNamed(context, '/comment');
                          controller.clear();
                        },
                      ),
                      contentPadding: const EdgeInsets.all(12.0),
                      border:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: Style.borderRadius()
                          )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(child: Comment(comment: cmt)),
              ],
            ),
          );
        },
        context: context);
  }
}
/*WebView(
                    initialUrl: "https://prepare.vyasedification.com" + "?token=$TOKEN",
                    javascriptMode: JavascriptMode.unrestricted,
                  )*/
/*YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                   // videoProgressIndicatorColor: Colors.amber,
                    */ /*progressColors: ProgressColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),*/
/*
*/
/*
                    onReady: (){
                      _controller.addListener(() => _controller,);
                    }
*/
/*
                    */
/*onReady () {
                  _controller.addListener(listener);
                  },*/
/*
                  ),*/