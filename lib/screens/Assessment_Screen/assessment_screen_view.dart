
import 'package:flutter/material.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({Key? key}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20,),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Assessments",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {

                    },
                    color: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text("Create Assessments",style: TextStyle(color: Colors.white)),
                    // Row(
                    //   children: [
                    //     Icon(Icons.add,color: Colors.grey.shade400,),
                    //     const Text("Add Students",style: TextStyle(color: Colors.white)),
                    //   ],
                    // ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              child: const Text(
                "Drafts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        )
      ),
    );
  }
}

