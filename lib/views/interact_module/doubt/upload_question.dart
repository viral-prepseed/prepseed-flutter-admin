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
  String dropdownvalue = 'Select a Subject';
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
            SizedBox(height: 20.0),
            Text("Title"),
            Container(
              height: 80.0,
              padding: const EdgeInsets.all(10.0),
              child:  TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
            ),
            Text("Body"),
            Container(
              height: 80.0,
              padding: const EdgeInsets.all(10.0),
              child:  TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
            ),
            Text("Attachements"),

            InkWell(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   border: Border.all(color: Colors.black45),
                    boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black45,offset: Offset(3,3))]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Icon(Icons.cloud_upload_outlined),
                    Text('Upload a file'),
                  ],
                ),
              ),
              onTap: () {},
            ),
            Text("Subject"),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 50.0,
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.black45),
                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black45,offset: Offset(3,3))]
              ),
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items:widget.sub.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem(
                    value: value.name!,
                    child: Text('${value.name.toString()}'),
                  );
                }).toList(),

                /* widget.sub.map((e){
                  return DropdownMenuItem(
                    child: Text(e.name.toString())
                );}
                ).toList(),*/
                onChanged: (newValue) {
                  setState(() {
                    dropdownvalue = newValue.toString();
                  });
                },
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10.0,),
                ElevatedButton(onPressed: (){}, child: Text("Post your question")),
                SizedBox(width: 10.0,),
                ElevatedButton(onPressed: (){}, child: Text("Cancel"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
