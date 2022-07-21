import '../../../model/playlist_model/video_model/videoPlaylistModel.dart';
import '../../../constants/theme/style.dart';
import '../../../repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../model/playlist_model/video_model/comment/comment_model.dart';

class Comment extends StatefulWidget {
  Resource comment;

  Comment({Key? key, required this.comment}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  VideosProvider prov = VideosProvider();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    final provMdl = Provider.of<VideosProvider>(context, listen: false);
    provMdl.getComment(widget.comment.sId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);

    if (provMdl.comment.item == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: provMdl.comment.item!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SvgPicture.network(
                  provMdl.comment.item![index].user!.dp.toString(),
                  height: 50.0),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(provMdl.comment.item![index].text.toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                )
              ),
              IconButton(
                onPressed: () {
                  onTap(provMdl.comment.item![index]);
                },
                icon: Image.asset("assets/info (1).png", height: 20.0),
              ),
            ],
          );
        }
    );
  }

  void onTap(Item item) {
    //final size = MediaQuery.of(context).size;
    var createTime = DateTime.parse(item.createdAt!);
    var updateTime = DateTime.parse(item.updatedAt!);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: Style.borderRadius(),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.network(item.user!.dp.toString(), height: 30.0),
                Text(item.user!.username.toString()),
              ],
            ),
            const SizedBox(height: 10.0,),
            Style.divider(),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                Text("Comment: ", style: textStyle()),
                Expanded(
                    child: Text(item.text.toString(),
                        overflow: TextOverflow.ellipsis, style: textStyle())),
              ],
            ),
            const SizedBox(height: 10.0,),

            const SizedBox(height: 10.0,),
            Row(
              children: [
                Text("Created At : ", style: textStyle()),
                Text(createTime.toLocal().toString(), style: textStyle()),
              ],
            ),
            const SizedBox(height: 10.0,),

            const SizedBox(height: 10.0,),
            Row(
              children: [
                Text("Update At : ", style: textStyle()),
                Text(updateTime.toLocal().toString(), style: textStyle()),
              ],
            ),
            const SizedBox(height: 10.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [Icon(Icons.delete)],
            )
          ],
        ),
      ),
    );
  }

  textStyle() {
    return const TextStyle(fontSize: 15.0);
  }
}
