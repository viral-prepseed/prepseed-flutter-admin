import '../../constants/colorPalate.dart';
import '../../constants/theme/style.dart';
import '../../views/Documents/resource_document_list.dart';
import '../../repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../menu/menu_widget.dart';

class DocumentHomeScreen extends StatefulWidget {

  const DocumentHomeScreen({Key? key}) : super(key: key);

  @override
  _DocumentHomeScreenState createState() => _DocumentHomeScreenState();
}

class _DocumentHomeScreenState extends State<DocumentHomeScreen> {

  TextEditingController controller = TextEditingController();


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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Documents",
              style: Style.textStyleBold15,
            ),
          ),
          Style.divider(),
          Expanded(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(10.0),
              child: Consumer<VideosProvider>(builder: (context, dataItems, _) {
               return provMdl.data.playlists != null ?
                Column(
                    children: [
                       //SearchBar(controller:_controller,isSearching: isSearching,searchResult: searchResult,filteredList: provMdl.tagValueDoc),
                       const SizedBox(height: 10.0,),
                      Container(
                        height: 50.0,
                        decoration: Style.decoration,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child:  TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: controller,
                          onChanged:(value) => {
                            controller.addListener(() {
                              provMdl.searchTextDoc(controller);
                            })},
                          //provMdl.searchText(widget.controller, widget.isSearching, widget.controller.text, widget.searchResult, widget.filteredList),
                          decoration: const InputDecoration(
                              fillColor: Colors.blueGrey,
                              filled: true,
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Colors.white),
                              prefixIcon: Icon(Icons.search,
                                  color: Colors.white),
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      const SizedBox(height: 10.0,),
                       Expanded(
                         child:
                         ListView.builder(
                             itemCount: provMdl.strDoc.length,
                             itemBuilder: (context, index) {
                               return Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(provMdl.strDoc[index].toString(),
                                       style: Style.textStyleBold15
                                   ),
                                   SizedBox(
                                     height: 150.0,
                                     child: ListView.builder(
                                         scrollDirection: Axis.horizontal,
                                         itemCount: provMdl.mapDoc.values.elementAt(index).length,
                                         itemBuilder: (context, ind) {
                                           String subSvg = provMdl.mapDoc.values.elementAt(index)[ind].thumbNailsUrls.toString();
                                           String img = subSvg.split('.').last;
                                           return Stack(
                                             alignment: Alignment.topRight,
                                             children: [
                                               InkWell(
                                                 child: Container(
                                                   padding: const EdgeInsets.all(10.0),
                                                   margin: const EdgeInsets.all(10.0),
                                                   width: 150.0,
                                                   decoration: Style.decoration,
                                                   child: Column(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       provMdl.mapDoc.values.elementAt(index)[ind].thumbNailsUrls.length == 0
                                                           ? Container()
                                                           : img.contains('svg')
                                                           ? SizedBox(
                                                              height: 40.0,
                                                              width: 40.0,
                                                              child: SvgPicture.network(
                                                              provMdl.mapDoc.values.elementAt(index)[ind].thumbNailsUrls[0],
                                                            ),
                                                           )
                                                           : Image.network(
                                                         provMdl.mapDoc.values.elementAt(index)[ind].thumbNailsUrls[0],
                                                         height: 45.0,
                                                       ),
                                                       const SizedBox(height: 30.0),
                                                       Text(
                                                           "${provMdl.mapDoc.values.elementAt(index)[ind].title}",
                                                           overflow: TextOverflow.ellipsis,
                                                           textAlign: TextAlign.center,
                                                           style: Style.textStyleBold13White
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                                 onTap: () {
                                                     Navigator.of(context).push(MaterialPageRoute(
                                                         builder: (context) => ResourceDocumentList(docs: provMdl.mapDoc.values.elementAt(index)[ind])));
                                                 },
                                               ),
                                               provMdl.mapDoc.values.elementAt(index)[ind].hasAccessToContent == false
                                               ? Container(
                                                 decoration: BoxDecoration(
                                                     color: Colors.transparent.withOpacity(0.2),
                                                     borderRadius: Style.borderRadius()
                                                 ),
                                                 child: IconButton(
                                                   onPressed: () {},
                                                   icon: const Icon(Icons.add_shopping_cart, size: 15.0,color: Colors.white),
                                                 ),
                                                 height: 30.0,
                                                 margin: const EdgeInsets.fromLTRB(1.0, 15.0, 15.0, 1.0),
                                                 width: 40.0,
                                               )
                                                   : Container()
                                             ],
                                           );
                                         }),
                                   ),
                                 ],
                               );
                             }),
                       ),
                     ],
                 ) :
               const Center(child: CircularProgressIndicator());
              }),
            ),
          )
        ],
      ),
    );
  }
}
