import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prepseed/views/interact_module/doubt/doubt_screen.dart';
import 'package:prepseed/views/interact_module/doubt/upload_question.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../repository/playlist_provider/videos_provider.dart';
import '../../menu/menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoubtHomeScreen extends StatefulWidget {
  const DoubtHomeScreen({Key? key}) : super(key: key);

  @override
  _DoubtHomeScreenState createState() => _DoubtHomeScreenState();
}

class _DoubtHomeScreenState extends State<DoubtHomeScreen> {
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
      body: SafeArea(
        child: Container(
          height: size.height,
          child: ChangeNotifierProvider(
            create: (context) => provMdl,
            child:Consumer(builder: (context, dataItems, _) {
              return  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Doubts and Discussions",
                          style: Style.textStyleBold15,
                        ),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UploadQuestion(sub: provMdl.doubtModel.subjects!,))
                              );
                            },
                            child: Text("Ask Question"))
                      ],
                    ),
                  ),
                  Style.divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Recent Questions",
                      style: Style.textStyleBold15,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "No Questions here",
                      style: Style.textStyleRegular13Black,
                    ),
                  ),
                  Style.divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Explore by Subject",
                      style: Style.textStyleBold15,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          mainAxisExtent: 160.0
                      ),
                      itemCount: provMdl.doubtModel.subjects!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String subSvg = provMdl.doubtModel.subjects![index].thumbnail.toString();
                        String img = subSvg.split('.').last;
                        String containerColor = provMdl.doubtModel.subjects![index].color.toString().replaceAll('#', '0xff');
                        String? textColor;
                        textColor  = (provMdl.doubtModel.subjects![index].textColor != null
                            ? provMdl.doubtModel.subjects![index].textColor.toString().replaceAll('#', '0xff') :
                        "0xFFFFFFFF") as String?;
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration:  BoxDecoration(
                              borderRadius: Style.borderRadius(),
                              color:Color(int.parse(containerColor)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                provMdl.doubtModel.subjects![index].thumbnail == null
                                    ? Container()
                                    : img.contains('svg')
                                    ? SvgPicture.network(
                                  provMdl.doubtModel.subjects![index].thumbnail.toString(),
                                  fit: BoxFit.contain,
                                  height: 45.0,
                                )
                                    : Image.network(
                                  provMdl.doubtModel.subjects![index].thumbnail.toString(),
                                  height: 45.0,
                                ),
                                const SizedBox(height: 30.0),
                                Text(
                                    provMdl.doubtModel.subjects![index].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(int.parse(textColor!)),
                                        fontWeight: FontWeight.bold)
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DoubtScreen(list:provMdl.doubtModel.subjects![index],))
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            })


          )
        ),
      ),
    );
  }
}
