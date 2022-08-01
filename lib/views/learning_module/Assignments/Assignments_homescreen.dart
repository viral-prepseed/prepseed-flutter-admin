import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../views/learning_module/Assignments/assignments_list.dart';
import '../../../repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../menu/menu_widget.dart';

class AssignmentHomeScreen extends StatefulWidget {

  const AssignmentHomeScreen({Key? key}) : super(key: key);

  @override
  _AssignmentHomeScreenState createState() => _AssignmentHomeScreenState();
}

class _AssignmentHomeScreenState extends State<AssignmentHomeScreen> {
  VideosProvider prov = VideosProvider();

  @override
  void initState() {
    /* final provMdl = Provider.of<VideosProvider>(context, listen: false);
    provMdl.getAssignments(widget.docs.sId.toString());*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provMdl = Provider.of<VideosProvider>(context);

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
            child:  Text(
              "Assignment",
              style: Style.textStyleBold15,
            ),
          ),
          Style.divider(),
          SizedBox(height: 20.0,),
          Expanded(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(10.0),
              child: ChangeNotifierProvider(
                create: (context) => provMdl,
                child:
                    Consumer(builder: (context, dataItems, _) {
                  if (provMdl.data.playlists != null) {
                    return ListView.builder(
                        itemCount: provMdl.strAssi.length,
                        itemBuilder: (context, index) {
                          return  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      provMdl.strAssi[index].toString(),
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    /*    : Text(
                                      provMdl.strAssi[index]
                                                .tags![0]
                                                .value
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),*/
                                    const SizedBox(height: 10.0,),
                                    SizedBox(
                                      height: 150.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: provMdl.mapAssi.values.elementAt(index).length,
                                          itemBuilder: (context, ind) {
                                            String subSvg = provMdl.mapAssi.values.elementAt(index)[ind].thumbNailsUrls.toString();
                                            String img = subSvg.split('.').last;
                                            return  InkWell(
                                              child: Container(
                                                padding: const EdgeInsets.all(10.0),
                                                margin: const EdgeInsets.all(10.0),
                                                width: 150.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: Colors.blueGrey,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    provMdl.mapAssi.values.elementAt(index)[ind].thumbNailsUrls.length == 0
                                                        ? Container()
                                                        : img.contains('svg')
                                                            ? SvgPicture.network(
                                                      provMdl.mapAssi.values.elementAt(index)[ind].thumbNailsUrls[0],
                                                                height: 40.0,
                                                                width: 40.0,
                                                              )
                                                            : Image.network(
                                                      provMdl.mapAssi.values.elementAt(index)[ind].thumbNailsUrls[0],
                                                                height: 45.0,
                                                              ),
                                                    const SizedBox(height: 30.0),
                                                    Expanded(
                                                      child: Text(
                                                          "${provMdl.mapAssi.values.elementAt(index)[ind].title}",
                                                          //overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 13.0,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                //print(data[index][ind]);
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              AssignmentsList(
                                                                  assi: provMdl.mapAssi.values.elementAt(index)[ind])));
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                );
                        });
                  }
                    return const Center(child: CircularProgressIndicator());
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
