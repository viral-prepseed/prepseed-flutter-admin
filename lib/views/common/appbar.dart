import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppBarItems extends StatefulWidget implements PreferredSizeWidget {
  const AppBarItems({Key? key}) : super(key: key);

  @override
  State<AppBarItems> createState() => _AppBarItemsState();

  @override
  Size get preferredSize => const Size.fromHeight(70);

}

class _AppBarItemsState extends State<AppBarItems> {
  List<String> catData = <String>[
    "AIS JEE 12",
    "AIS NEET 12",
    "AIS JEE 11",
    "AIS NEET 11"
  ];

  String? categories;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 30.0,
              width: 140.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 1.0),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.2, color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                ),
              ),
              child: DropdownButton2(
                hint: const Text(
                  "AIS JEE 12",
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
                value: categories,
                underline: Container(),
                // /  offset: const Offset(-5, -10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                isExpanded: true,
                onChanged: (String? val) {
                  setState(() {
                    categories = val;
                  });
                },
                items: catData.map((String value) {
                  //print(catData);
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Icon(
              Icons.save,
              color: Colors.black,
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 233, 233, 233),

    );
  }
}
