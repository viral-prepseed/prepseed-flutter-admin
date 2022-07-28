import 'package:flutter/material.dart';
import 'package:prepseed/model/interact_models/doubt_model/doubt_model.dart';

import '../../constants/theme/style.dart';

class DoubtScreen extends StatefulWidget {
  Subjects list = Subjects();
  DoubtScreen({required this.list});

  @override
  _DoubtScreenState createState() => _DoubtScreenState();
}

class _DoubtScreenState extends State<DoubtScreen> {
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
                    widget.list.name.toString(),
                    style: Style.textStyleBold15
                )
              ],
            ),
            Style.divider(),
            Expanded(child: Center(child: Text("No questions here"),))
          ],
        ),
      ),
    );
  }
}
