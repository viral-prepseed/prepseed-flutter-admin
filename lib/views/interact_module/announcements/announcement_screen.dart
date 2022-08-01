import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prepseed/model/interact_models/announcement_model/announcement_model.dart';
import 'package:prepseed/views/interact_module/announcements/announcement_pdf.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../menu/menu_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Announcements extends StatefulWidget {

  Items list = Items();
  Announcements({required this.list});

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  DateTime currentTime = DateTime.now();
  var createAt;
  @override
  Widget build(BuildContext context) {
    createAt = DateTime.parse(widget.list.createdAt.toString());
    //print(currentTime);
    //print(createAt);
    Duration time = currentTime.difference(createAt);
   // print("${time.inHours} hours ago");
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                    widget.list.title.toString(),
                    style: Style.textStyleBold15
                )
              ],
            ),
            Style.divider(),
            SizedBox(height: 20.0,),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Text(widget.list.body.toString(), style: Style.textStyleRegular15Black),
           ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.announcement,size: 20.0),
                  SizedBox(width: 10.0,),
                  time.inHours <= 24 ? time.inMinutes <= 60 ? Text("${time.inMinutes}m ago") :
                    Text("${time.inHours}h ago")
                  : Text("${time.inDays}d ago")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(" Attachments (${widget.list.files!.length})",
                style: TextStyle(fontSize: 13.0,),
              ),
            ),
            widget.list.files!.length != 0
            ? Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: widget.list.files!.length,
                itemBuilder: (context,index){
                  String path = widget.list.files![index].url.toString();
                  String file = path.split('.').last;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0,),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 2.0),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child:file.contains('pdf')
                            ? TextButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>  AnnouncementPDF(url: widget.list.files![index].url.toString()))
                                  );
                                }, child: Text(widget.list.files![index].name.toString(),style: TextStyle(
                              color: Colors.black
                            ),))
                        : Image.network(widget.list.files![index].url.toString(),fit: BoxFit.contain),
                       // / margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                      ),
                   ],
                  );
                },
              ),
            )
            : Container(),

          ],
        ),
      ),
    );
  }
}
