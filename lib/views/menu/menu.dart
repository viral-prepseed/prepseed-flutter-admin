import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:prepseed/repository/playlist_repo/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import '../../constants/colorPalate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../helper/sharedPref.dart';
import '../../main.dart';
import '../../model/menuItem.dart';
import '../../repository/playlist_provider/videos_provider.dart';
import '../login/prepseed_loginScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MenuItems{
  static const home = MainMenuItems('Home',Icons.widgets_outlined);
  static const analysis = MainMenuItems('Analysis',Icons.analytics_outlined);
  static const reports = MainMenuItems('Reports',Icons.article_outlined);
  static const videos = MainMenuItems('Videos',Icons.video_call_outlined);
  static const documents = MainMenuItems('Documents',Icons.wysiwyg_outlined);
  static const assignments = MainMenuItems('Assignments',Icons.book_outlined);
  static const practice = MainMenuItems('Practice',Icons.document_scanner_rounded);
  static const quantizedSheet = MainMenuItems('Quantized Sheet',Icons.assignment_outlined);
  static const announcement = MainMenuItems('Announcements',Icons.announcement_outlined);
  static const doubt = MainMenuItems('Doubt', Icons.error);
  static const Tests = MainMenuItems('Tests',Icons.assignment_outlined);
  static const topicTests = MainMenuItems('Topic Tests',Icons.assignment_outlined);
  static const chats = MainMenuItems("Chats", Icons.message);

  // static const quantizedSheet = MainMenuItems('Quantized Sheet',Icons.assignment_outlined);
  //static const Tests = MainMenuItems('Execute',Icons.assignment_outlined);
  // static const logout = MenuItem('Logout',Icons.logout);

   List<MainMenuItems>  all = [
    home,
    analysis,
    reports,
    videos,
    documents,
    assignments,
    practice,
    // quantizedSheet,
    Tests,
     topicTests
   /* announcement,
    doubt,
    chats*/
    // logout
  ];
}


class MenuScreen extends StatefulWidget {
  final MainMenuItems currentItem;
  final ValueChanged<MainMenuItems> onSelectedItem;

  const MenuScreen({Key? key, required this.currentItem, required this.onSelectedItem}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var username,role,email;
  String? logo;


  @override
  void initState() {
    fetchPref();
    // getprefs();
  }


  Widget buildMenuItem(MainMenuItems item) => ListTileTheme(
    selectedColor: Colors.black87,
    child: ListTile(
     // selectedTileColor: Constants.backgroundColorTrans,
      selected: widget.currentItem == item,
      minLeadingWidth: 20,
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => widget.onSelectedItem(item),
    ),
  );

  fetchPref() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    username = await sharedPref().getSharedPref('username');
    role = await sharedPref().getSharedPref('role');
    email = await sharedPref().getSharedPref('email');
    logo = await sharedPref().getSharedPref('InstituteLogo');
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provMdl = Provider.of<VideosProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Container(
          width: size.width / 1.5,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey,
                  Colors.grey,
                ],
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Spacer(),
            //  ...MenuItems.all.map(buildMenuItem).toList(),
              SizedBox(height: 25.0,),
              CachedNetworkImage(
                  imageUrl: logo.toString(),
                  placeholder: (context, url) => Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 9,
                    fit: BoxFit.contain,),
                  imageBuilder: (context, image) => Image(
                    image: image,
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 9,
                    fit: BoxFit.contain,)
              ),
              const SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(username.toString()),
              ),
/*              SizedBox(height: 10.0,),
              Text(email),*/
              Divider(),
              Expanded(
                child: ChangeNotifierProvider.value(
                  value:  provMdl,
                  child: Consumer(builder: (context, dataItems, _)
                    {
                      return ListView.builder(
                        itemCount: provMdl.menuItems.all.length,
                        itemBuilder: (context,index){
                          return buildMenuItem(provMdl.menuItems.all[index]);
                        }
                      );
                    }
                  ),
                ),
              ),
              Divider(),
              ListTile(
                selectedTileColor: Constants.backgroundColorTrans,
                // selected: widget.currentItem == item,
                minLeadingWidth: 20,
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  logout();
                },
              ),
             // Spacer(),
            ],
          )
        ),
      ),
    );
  }
}

logout() {
  Future.delayed(Duration.zero, () async {
    return showDialog(context: navigatorKey.currentContext!, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        elevation: 16,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text('Are you Sure?',style: GoogleFonts.poppins(color: Constants.black,),),
                  Divider(color: Constants.black,thickness: 1,),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(elevation: MaterialStateProperty.all<double>(0.0),
                                foregroundColor: MaterialStateProperty.all<Color>(Constants.black),
                                backgroundColor:  MaterialStateProperty.all<Color>(Colors.transparent)),
                            onPressed: () { Navigator.of(context).pop(); },
                            child: const Text('Cancel')),
                        VerticalDivider(color: Constants.black,thickness: 1,),
                        ElevatedButton(onPressed: () async {
                          /*setState(() {
                          currentItem = MenuItems.home;
                        });*/
                          SharedPreferences prefs = await SharedPreferences
                              .getInstance();
                          await prefs.clear();
                          await APICacheManager().emptyCache();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => prepSeed_login()
                          ));
                        },
                            style: ButtonStyle(elevation: MaterialStateProperty.all<double>(0.0),
                                foregroundColor: MaterialStateProperty.all<Color>(Constants.black),
                                backgroundColor:  MaterialStateProperty.all<Color>(Colors.transparent)),
                            child: const Text('Yes'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  });
}

/*ListView(
            padding: EdgeInsets.symmetric(vertical: 70),
            children: <Widget>[

              // Text('Dashboard'),
              ListTile(
                title: Text("Home", style: GoogleFonts.poppins(color: Constants.black,),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mainScreen()));
                },
              ),
              ListTile(
                title: Text("Analysis", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Analysis()));
                },
              ),
              ListTile(
                title: Text("Reports", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Reports()));
                },
              ),
              ListTile(
                title: Text("videos", style: TextStyle(color: Constants.black,)),
              ),
              ListTile(
                title: Text("Documents", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text("Assignments", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text("Practice", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => quantized_sheet()));
                },
              ),
              ListTile(
                title: Text("Quantized Sheet", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => quantized_sheet()));
                },
              ),
              ListTile(
                title: Text("Tests", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => test()));
                },
              ),
              SizedBox(
                height:
                20.0,
              ),
              Divider(
                color: Colors.blue[100],
                thickness: 1,
              ),
              SizedBox(
                height: 20.0,
              ),
              /*ListTile(
                title: Text(username, style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text(email, style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),*/
              Container(
                margin: EdgeInsets.only(right: 300.0),
                child: ListTile(
                  tileColor: Constants.black,
                  title: Text("Logout", style: TextStyle(color: Colors.red,)),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => prepSeed_login()
                    ));
                  }

                ),
              ),
              SizedBox(
                height:
                20.0,
              ),
            ],
          ),*/