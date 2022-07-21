import 'package:learning_module/model/playlist_model/playlists.dart';
import 'package:learning_module/constant/theme/style.dart';
import 'package:learning_module/view/Documents/resource_document.dart';
import 'package:learning_module/view/common/appbar.dart';
import 'package:learning_module/view/common/drawer.dart';
import 'package:learning_module/repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResourceDocumentList extends StatefulWidget {
  Playlists docs = Playlists();

  ResourceDocumentList({Key? key, required this.docs}) : super(key: key);

  @override
  _ResourceDocumentListState createState() => _ResourceDocumentListState();
}

class _ResourceDocumentListState extends State<ResourceDocumentList> {

  VideosProvider prov = VideosProvider();
  @override
  void initState() {
    final provMdl = Provider.of<VideosProvider>(context, listen: false);
    provMdl.doc.playlist == null;
    provMdl.getResourceDocuments(widget.docs.sId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<VideosProvider>(context);
    return  Scaffold(
      appBar: const AppBarItems(),
      drawer: const SideBar(),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context,"");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(widget.docs.title.toString(),
                    style: Style.textStyleBold15),
                )
              ],
            ),
            widget.docs.items!.isEmpty ?
              const Center(child: CircularProgressIndicator()):
            Expanded(
              child: ListView.builder(
                  itemCount: widget.docs.items!.length,
                  itemBuilder: (context,index){
                    String? topic;
                    widget.docs.items![index].resource!.tags!.forEach((element) {
                      if (element.key == "Topic") {
                        topic = element.value;
                      }
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0,),
                        Text(topic.toString()/*,overflow: TextOverflow.ellipsis*/),
                        const SizedBox(height: 20.0,),
                        InkWell(
                          child: Row(
                            children: [
                              Image.network(widget.docs.items![index].resource!.thumbNailsUrls![0].toString(),
                                width: 100.0,
                                height: 50.0,
                              ),
                              Expanded(child: Text(widget.docs.items![index].resource!.title.toString(),textAlign: TextAlign.center,)),
                            ],),
                          onTap: (){
                            widget.docs.hasAccessToContent == true
                            ? Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ResourceDocumentView(item: provMdl.doc.playlist!.items![index])))
                            : Container();
                            //print("Done");
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ) ,
    );
  }
}
