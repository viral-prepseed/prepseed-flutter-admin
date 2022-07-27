import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/colorPalate.dart';
import '../../constants/theme/style.dart';

import '../../repository/playlist_provider/videos_provider.dart';
import '../menu/menu_widget.dart';
import 'package:provider/provider.dart';

import 'announcement_screen.dart';

class AnnouncementsHomeScreen extends StatefulWidget {
  const AnnouncementsHomeScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementsHomeScreenState createState() => _AnnouncementsHomeScreenState();
}

class _AnnouncementsHomeScreenState extends State<AnnouncementsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.backgroundColor,
          elevation: 0,
          leading: MenuWidget(),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Announcements",
                  style: Style.textStyleBold15,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Style.divider(),
              Expanded(
                child: Container(
                  height: size.height,
                  child:  ChangeNotifierProvider(
                    create: (context) => provMdl,
                    child: Consumer(builder: (context, dataItems, _) {
                      return provMdl.announcementModel.items!.isNotEmpty
                          ? ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: provMdl.announcementModel.items!.length,
                          itemBuilder:(context,index){
                            return InkWell(
                              child: Column(
                                children: [
                                  SizedBox(height: 20.0,),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueGrey,
                                            width: 2.0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          child: Icon(Icons.announcement),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(provMdl.announcementModel.items![index].title.toString(),
                                          style: TextStyle(
                                              fontSize: 15.0
                                          ),),
                                        SizedBox(width: 10.0,),
                                        provMdl.announcementModel.items![index].files!.length != 0
                                            ? Text("${provMdl.announcementModel.items![index].files!.length} Attachment",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                        )
                                            : Container()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Announcements(list: provMdl.announcementModel.items![index],))
                                );
                              },
                            );
                          }
                      )
                          : Center(child: Text("No Announcements"));
                    })
                  ),
                )
              ),
            ])
    );
  }
}
