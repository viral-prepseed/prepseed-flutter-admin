import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prepseed/model/interact_models/doubt_model/doubt_model.dart';

import '../../../constants/theme/style.dart';

class UploadQuestion extends StatefulWidget {

  List<Subjects> sub;
  UploadQuestion({required this.sub});
  @override
  _UploadQuestionState createState() => _UploadQuestionState();
}

class _UploadQuestionState extends State<UploadQuestion> {
  String? dropdownValue;
  //List<DropdownMenuItem>? dropdownItems;

  // List of items in our dropdown menu
  var items = [];
  String? val;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                    "Ask your Question",
                    style: Style.textStyleBold15
                )
              ],
            ),
            Style.divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Text("Title"),
                  SizedBox(height: 10.0),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                  ),
                  SizedBox(height: 20.0),
                  Text("Body"),
                  SizedBox(height: 10.0),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                  ),
                  SizedBox(height: 20.0),
                  Text("Attachements"),
                  SizedBox(height: 10.0),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      //margin: const EdgeInsets.all(10.0),
                      height: 60.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                         border: Border.all(color: Colors.black45),
                          boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black45,offset: Offset(3,3))]
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         Icon(Icons.cloud_upload_outlined,size: 20.0),
                          Text('Upload a file'),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 20.0),
                  Text("Subject"),
                  SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 50.0,
                    //margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colors.black45),
                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black45,offset: Offset(3,3))]
                    ),
                    child: DropdownButton(
                      hint: Text("Select Subject"),
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:widget.sub.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value.name,
                          child: Text('${value.name.toString()}',
                            style: Style.textStyleRegular13Black,),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue.toString();
                          print(dropdownValue);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0,),
                      ElevatedButton(onPressed: (){}, child: Text("Post your question")),
                      SizedBox(width: 10.0,),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context, "");
                      }, child: Text("Cancel"))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
