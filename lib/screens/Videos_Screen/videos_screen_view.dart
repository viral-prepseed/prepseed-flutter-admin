
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {

  final _formToCreatePlay = GlobalKey<FormState>();
  final txtName = TextEditingController();
  final txtDescription = TextEditingController();
  final txtSubject = TextEditingController();

  XFile? video;
  String? filePath;


  final picker = ImagePicker();
  // VideoPlayerController? controller;

  getVideoFromCamera() async {

  }


  getVideoFromGallery() async  {
    XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if(pickedFile != null) {
      setState(() {
        video = XFile(pickedFile.path);
        filePath = video!.path;
      });
      Navigator.pop(context);
      print("${video!.path} === ${video!.name}");
      // playListDetails(context);

    }
    // if(pickedFile != null) {
    //   // Navigator.pop(context);
    //   setState(getVideoFromGallery);
    // }


    // if(pickedFile != null) {
    //
    //   setState(() {
    //     video = XFile(pickedFile.path);
    //   });
    //   print("${video!.path} === ${video!.name}");
    //   Navigator.pop(context);
    //   // return video!;
    //   // wantToPlayVideo();
    //   // controller = VideoPlayerController.file(File(video!.path))..initialize().then((control) {
    //   //   controller?.play();
    //   // });
    //   // VideoPlayerController _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
    //   //   setState(() { });
    //   //   _cameraVideoPlayerController.play();
    //   // });
    //
    // }
    // else {
    //
    // }
  }

  // @override
  // void setState(VoidCallback fn)  {
  //   // TODO: implement setState
  //   if(pickedFile != null) {
  //     video = pickedFile.path;
  //     print("${video!.path} === ${video!.name}");
  //
  //     // return video!;
  //     // wantToPlayVideo();
  //     // controller = VideoPlayerController.file(File(video!.path))..initialize().then((control) {
  //     //   controller?.play();
  //     // });
  //     // VideoPlayerController _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
  //     //   setState(() { });
  //     //   _cameraVideoPlayerController.play();
  //     // });
  //
  //   }
  //   // print("${video!.path} === ${video!.name}");
  //   super.setState(fn);
  // }

  // Future<XFile?>
  uploadAFile(BuildContext context)  {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15)
        ),
      ),
      context: context,
      builder: (context) => StatefulBuilder(builder: (BuildContext context,setState) {
        return Container(
          padding: const EdgeInsets.all(12),
          // margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              // CAMERA
              TextButton.icon(
                icon: const Icon(Icons.camera_alt,color: Colors.black),
                onPressed: () {
                  getVideoFromCamera();
                },
                label: const Text("Camera",style: TextStyle(color: Colors.black),),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey[200]),
                ),
              ),

              // GALLERY
              TextButton.icon(
                icon: const Icon(Icons.photo_library_outlined,color: Colors.black),
                onPressed: () async {
                  await getVideoFromGallery();

                },
                label: const Text("Gallery",style: TextStyle(color: Colors.black),),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey[200]),
                ),
              )

            ],
          ),
        );
      })
    );
    // .then((_) => setState(() {}));
  }

  playListDetails(BuildContext context) {

    return showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (BuildContext context,setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsAlignment: MainAxisAlignment.center,
          title: const Text("Playlist Details"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(key: _formToCreatePlay,child: Column(
                  children: [

                    // Name
                    TextFormField(
                      controller: txtName,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if(val==null || val == "") {
                          return "Please Enter Name";
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: const Text("Name *"),
                        // hintText: "Enter Name",
                        contentPadding: const EdgeInsets.only(
                            left: 8,right: 8,top: 4,bottom: 4
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),


                    // Description
                    TextFormField(
                      controller: txtDescription,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        label: const Text("Description"),
                        // hintText: "Enter Description",
                        contentPadding: const EdgeInsets.only(
                            left: 8,right: 8,top: 4,bottom: 4
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),

                    // Thumbnail
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // video=null;
                            await uploadAFile(context);

                            // setState(() {});
                            if(filePath!=null && video!=null) {
                              setState(() {
                                filePath = video!.path;
                              });
                            }
                            else {
                              // print("video: $filePath");
                            }

                          },
                          child: const Text("Upload a File"),
                        ),
                        video != null
                            ? Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(video!.name)
                        )
                            : const Text("No File Selected")
                      ],
                    ),
                    const SizedBox(height: 8,),


                    // Subject
                    TextFormField(
                      controller: txtSubject,
                      validator: (val) {
                        if(val==null || val == "") {
                          return "Please Enter Subject";
                        }
                        else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        label: const Text("Subject"),
                        // hintText: "Enter Description",
                        contentPadding: const EdgeInsets.only(
                            left: 8,right: 8,top: 4,bottom: 4
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                txtDescription.text='';
                txtName.text='';
                txtSubject.text='';
                video=null;
                filePath=null;
                Navigator.pop(context);
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red.shade400),
                overlayColor: MaterialStateProperty.all(Colors.red.shade50),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () {
                  if(_formToCreatePlay.currentState!.validate()) {

                    if(video==null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Select a File')));
                    }
                    else {
                      print("${txtName.text} ${video!.name} ${txtDescription.text} ${txtSubject.text}");

                      {
                        txtDescription.text = txtName.text = txtSubject.text = '';
                        video=null;
                        filePath=null;
                      }

                      Navigator.pop(context);

                    }





                  }
                },
                child: const Text("Create")
            ),
          ],
        );
      });

    });
    //.then((_) => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Learning Section",
          style: TextStyle(color: Colors.black),
        ),
        // Row(children: const [
        //     Text("Learning",style: TextStyle(fontSize: 24,color: Colors.black),),
        //     SizedBox(width: 4,),
        //     Text("Sct",style: TextStyle(fontSize: 20,color: Colors.black),),
        // ],),
      ),
      body:
      SingleChildScrollView(
        child:
        Column(

          children:  [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Videos Screen",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    playListDetails(context);
                  },
                  child: const Text("Create New PlayList"),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}

