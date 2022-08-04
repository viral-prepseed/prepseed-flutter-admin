import 'package:flutter/material.dart';
/*import 'package:prepseed/model/interact_models/doubt_model/doubt_model.dart'*/
import 'package:prepseed/views/interact_module/doubt/upload_question.dart';

import '../../../constants/theme/style.dart';
import 'package:provider/provider.dart';

import '../../../model/interact_models/doubt_model/doubt_model.dart';
import '../../../repository/playlist_provider/videos_provider.dart';

class DoubtScreen extends StatefulWidget {
  Subjects list = Subjects();
  DoubtScreen({required this.list});

  @override
  _DoubtScreenState createState() => _DoubtScreenState();
}

class _DoubtScreenState extends State<DoubtScreen> {

  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                    widget.list.name.toString(),
                    style: Style.textStyleBold15
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UploadQuestion(sub: provMdl.doubtModel.subjects!,))
                            );
                          },
                          child: Text("Ask Question")),
                    ],
                  ),
                ),
                SizedBox(width: 10.0,)
              ],
            ),
            Style.divider(),
            Expanded(child: Center(child: Text("No questions here"),))
          ],
        ),
      ),
    );
  }
}
