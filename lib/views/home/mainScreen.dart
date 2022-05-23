import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class mainScreen extends StatefulWidget {
  final zoomController;

  const mainScreen({Key? key, this.zoomController}) : super(key: key);

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          leading: InkWell(
            onTap: () => widget.zoomController.toggle(),
            child: Icon(Icons.menu),
          ),
        ),*/
        backgroundColor: Constants.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => widget.zoomController.toggle(),
                        child: Icon(Icons.menu),
                      ),
                      Text(
                        'Your Progress',
                        style: GoogleFonts.poppins(
                            color: Constants.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            color: Constants.blacklight,
                            child: Container(
                              height: 200,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              animation: true,
                                              animationDuration: 2200,
                                              lineWidth: 07.0,
                                              percent: 0.4,
                                              center: Text(
                                                "30/600",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0),
                                              ),
                                              circularStrokeCap:
                                              CircularStrokeCap.butt,
                                              backgroundColor: Colors.white,
                                              progressColor: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Tests Taken',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.blacktext,
                                                    fontSize: 16),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Image.asset('assets/mastercard.png', width: 48.0)
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              animation: true,
                                              animationDuration: 2200,
                                              lineWidth: 07.0,
                                              percent: 0.7,
                                              center: Text(
                                                "40/261",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.0),
                                              ),
                                              circularStrokeCap:
                                              CircularStrokeCap.butt,
                                              backgroundColor: Colors.white,
                                              progressColor: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Videos Watched',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.blacktext,
                                                    fontSize: 16),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Weak Categories
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weak categories',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: Color(0xBCF4664A),
                                  child: Container(
                                    height: 150,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(24.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Isomerism & IUPAC Nomenclature',
                                                style: GoogleFonts.poppins(
                                                    color: Constants.blacktext,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'Organic Chemistry 1',
                                                style: GoogleFonts.poppins(
                                                    color: Constants.blacktext,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: Color(0xFFC0ECCF),
                                  child: Container(
                                    height: 150,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(24.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Math for physics',
                                                style: GoogleFonts.poppins(
                                                    color: Constants.blacktext,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'Mechanics 1',
                                                style: GoogleFonts.poppins(
                                                    color: Constants.blacktext,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            // Behaviour needed
                            Text(
                              'Behaviour needed',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              height: 400,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: Constants.blacklight,
                                  child: Container(
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(24.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(

                                                children: <Widget>[
                                                  Image.asset('assets/images/logo.jpg',width: 100,),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text('Intent',style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.bold,
                                                      color: Constants.textcolor,
                                                      fontSize: 19),),
                                                  Text(
                                                    'You need to attempt questions properly and spend more time in each question to improve your performance.'
                                                        'You have made too many bluffs in the assessment.'
                                                        'You haven\'t attempted many questions in the assessment.'
                                                        'You have finished the assessment too early.',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        color: Constants.blacktext,
                                                        fontSize: 16),
                                                    maxLines: 50,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  // Image.asset('assets/mastercard.png', width: 48.0)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Courses by Us
                            Text(
                              'Courses by {Client Name}',
                              style: GoogleFonts.poppins(
                                  color: Constants.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              // height: 400,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: Constants.blacklight,
                                  child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width - 40,
                                                height: 200,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(25),
                                                  child: Container(
                                                    color: Color(0xDFA5A4A4),
                                                    child: Container(
                                                      height: 200,
                                                      child: Stack(
                                                        children: [
                                                          //image
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // width: 350,
                                                // height: 100,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text('CBSE Class 10th Revision Course',
                                                            textAlign: TextAlign.start,
                                                            style: GoogleFonts.poppins(fontWeight:
                                                            FontWeight.w600,fontSize: 14,color: Constants.blacktext),),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('₹ 4555',style:
                                                              GoogleFonts.poppins(fontWeight:
                                                              FontWeight.w600,fontSize: 17,color: Constants.buttontextcolor),),
                                                              ElevatedButton(
                                                                style: ButtonStyle(
                                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(18.0),
                                                                      side: BorderSide(
                                                                        color: Constants.backgroundColor,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Text('Buy Now'),
                                                                onPressed: () {},
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ),

                          ]),
                    ]),
              ),
            ],
          ),
        ));
  }
}
