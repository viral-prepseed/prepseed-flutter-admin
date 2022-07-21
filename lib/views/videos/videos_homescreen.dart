import '../../constants/colorPalate.dart';
import '../../constants/theme/style.dart';
import '../../repository/playlist_provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../menu/menu_widget.dart';
import 'videos_list.dart';

class VideosHomeScreen extends StatefulWidget {
  const VideosHomeScreen({Key? key}) : super(key: key);

  @override
  _VideosHomeScreenState createState() => _VideosHomeScreenState();
}

class _VideosHomeScreenState extends State<VideosHomeScreen> {

  @override
  void initState() {
    final  provMdl = Provider.of<VideosProvider>(context,listen: false);
    provMdl.getVideos(context);
    super.initState();
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final provMdl = Provider.of<VideosProvider>(context,listen: true);
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
              "Video",
              style: Style.textStyleBold15,
            ),
          ),
          Style.divider(),
          Expanded(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(10.0),
              child:  ChangeNotifierProvider(
                create: (context) => provMdl,
                child: Consumer<VideosProvider>(builder: (context, dataItems, _) {
                  return provMdl.data.playlists != null ?
                  Column(
                    children: [
                      Container(
                        height: 50.0,
                        decoration: Style.decoration,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child:  TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: controller,
                          onChanged:(value) => {
                            controller.addListener(() {
                              provMdl.searchTextVideo(controller);
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
                      // SearchBar(filteredList: provMdl.tagValue),
                      const SizedBox(height: 10.0,),
                      Expanded(
                          child:
                          ListView.builder(
                              itemCount:  provMdl.str.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provMdl.str[index].toString(),
                                        style: Style.textStyleBold15
                                    ),
                                    SizedBox(
                                      height: 150.0,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: provMdl.map.values.elementAt(index).length,
                                          itemBuilder: (context, ind) {
                                            String subSvg = provMdl.map.values.elementAt(index)[ind].thumbNailsUrls.toString();
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
                                                        provMdl.map.values.elementAt(index)[ind].thumbNailsUrls.length == 0
                                                        ? Container()
                                                        : img.contains('svg')
                                                        ? SvgPicture.network(
                                                          provMdl.map.values.elementAt(index)[ind].thumbNailsUrls[0],
                                                          fit: BoxFit.contain,
                                                          height: 45.0,
                                                         // placeholderBuilder: (context) => const CircularProgressIndicator(),
                                                        )
                                                        : Image.network(
                                                          provMdl.map.values.elementAt(index)[ind].thumbNailsUrls[0],
                                                          height: 45.0,
                                                        ),
                                                        const SizedBox(height: 30.0),
                                                        Text(
                                                            "${provMdl.map.values.elementAt(index)[ind].title}",
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.center,
                                                            style: Style.textStyleBold13White
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => PlaylistVideos(list: provMdl.map.values.elementAt(index)[ind],))
                                                    );
                                                  },
                                                ),
                                                provMdl.map.values.elementAt(index)[ind].hasAccessToContent == false
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
                              })
                      ),
                    ],
                  ) : const Center(child: CircularProgressIndicator());
                }),
              )
            ),
          )
        ],
      ),
    );
  }
}
