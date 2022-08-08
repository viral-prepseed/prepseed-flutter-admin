import 'package:flutter/cupertino.dart';

import '../../../constants/colorPalate.dart';
import '../../../model/playlist_model/playlists.dart';
import '../../../constants/theme/style.dart';
import '../../../views/learning_module/Documents/resource_document.dart';
import '../../../repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../menu/menu_widget.dart';

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
      body:SafeArea(
        child: Column(
          children: [
            SizedBox(height:20.0),
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
            Style.divider(),
            widget.docs.items!.isEmpty ?
              const Center(child: CircularProgressIndicator()):
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
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

                              CachedNetworkImage(
                                  imageUrl: widget.docs.items![index].resource!.thumbNailsUrls![0].toString(),
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
                              /*Image.network(widget.docs.items![index].resource!.thumbNailsUrls![0].toString(),
                                width: 100.0,
                                height: 50.0,
                              ),*/
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
