import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Users', style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600)),
                  ElevatedButton(onPressed: (){}, child: Row(
                    children: [
                      Icon(Icons.add),
                      Text('Add Student', style: GoogleFonts.poppins(fontSize: 20,)),
                    ],
                  ))
                ],
              ),
              SizedBox(height: 25,),
              //Search Box
              TextField(
                // decoration: InputDecoration(borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
