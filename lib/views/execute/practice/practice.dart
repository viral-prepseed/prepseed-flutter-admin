
import 'package:flutter/material.dart';
import 'package:prepseed/views/execute/practice/practice_subTopics.dart';
import 'package:prepseed/views/menu/menu_widget.dart';

import '../../../constants/colorPalate.dart';
import '../../../constants/theme/style.dart';
import '../../../helper/api/functions.dart';
import 'package:http/http.dart' as http;

import '../../../helper/provider/userDerailsProvider.dart';
import '../../../helper/sharedPref.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class practice extends StatefulWidget {
  const practice({Key? key}) : super(key: key);

  @override
  _practiceState createState() => _practiceState();
}

class _practiceState extends State<practice> {
  late var signinlist ;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async => {
      await Provider.of<UserClass>(context, listen: false)
          .apiCall(),
    });
    getprefs();

  }
  getprefs() async {
    signinlist = await sharedPref().getSharedPref('signinlist');
    setState(() {
      signinlist;
    });
    // callAPI();
  }

/*  callAPI() async{

    var topicId = '5d641d2d2e8a7c5406d44465';
    functions().getObjectsById(topicId);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: Consumer<UserClass>(builder: (context, userModel, child){
        print(userModel.topicListFullData.length);
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    mainAxisExtent: 160.0
                ),
                itemCount: userModel.topicListFullData[0].length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration:  BoxDecoration(
                        borderRadius: Style.borderRadius(),
                        color:Colors.green,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // provMdl.doubtModel.subjects![index].thumbnail == null ?
                          Container(),
                          const SizedBox(height: 30.0),
                          Text(userModel.topicListFullData[0].elementAt(index).name!,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PracticeSubTopics(list:userModel.topicListFullData[0].elementAt(index),))
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
    })
    );
  }
}
