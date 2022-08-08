import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../helper/provider/leadershipProvider.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {

  @override
  void initState() {
/*    Future.microtask(() async => {
      await Provider.of<LeadershipClass>(context, listen: false).leaderBoard(),
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/leadership.png',width: 25,color: Constants.backgroundColor,),
                  Text('Leaderboard', style: GoogleFonts.poppins(color: Constants.backgroundColor),),
                ],
              ),
            ),
          ),

          Consumer<LeadershipClass>(builder: (context, leaderModel, child){
            // print(leaderModel.leaderBoardData!.elementAt(0).rating);
            return leaderModel.leaderBoardData != null
              ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: leaderModel.leaderBoardData!.length,
              itemBuilder: (context, index) {
                String subSvg = leaderModel.leaderBoardData![index].user!.dp.toString();
                String img = subSvg.split('.').last;
                return Card(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              img.contains('svg') ?
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: SvgPicture.network(leaderModel.leaderBoardData![index].user!.dp.toString()),
                              ) :
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: CachedNetworkImage(imageUrl: leaderModel.leaderBoardData![index].user!.dp.toString(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  placeholder: (context,url) => CircularProgressIndicator(),
                                ),
                              ),
                              SizedBox(width: 10,),
                              // CircleAvatar(child: Image(image: NetworkImage('${leaderModel.leaderBoardData!.elementAt(position).user!.dp}'))),
                              Text('${leaderModel.leaderBoardData![index].user!.username}',style:
                                GoogleFonts.poppins(color: Constants.black,fontWeight: FontWeight.w600,fontSize: 13),),
                            ],
                          ),
                          Text('${leaderModel.leaderBoardData![index].rating!.round()}',
                          style: GoogleFonts.poppins(color: Constants.darkGreen,fontWeight: FontWeight.w600,fontSize: 13),
                          ),
                        ],
                      )
                  ),
                );
              },
            ) : Center(child: CircularProgressIndicator(),);
          })

        ],
      ),
    );
  }
}
  getPicture(String url) {
  var mimeType = getFileExtension(url);
  // print(mimeType);
  if (mimeType == ".svg") {
    return SvgPicture.network(
        url,
        // color: Colors.red,
        semanticsLabel: 'A red up arrow'
    );
  }
  else {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Constants.grey,
      child: CircleAvatar(
        radius: 25 - 3,
        backgroundImage: Image.network(url,
          fit: BoxFit.cover,
        ).image,
      ),
    );
  }
}

String getFileExtension(String fileName) {
  return "." + fileName.split('.').last;
}