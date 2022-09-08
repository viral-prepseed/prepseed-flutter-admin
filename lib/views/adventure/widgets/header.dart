import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/colorPalate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../execute/test/viewAnalysis.dart';

class header extends StatefulWidget {
  const header({Key? key}) : super(key: key);

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> with SingleTickerProviderStateMixin  {

  int secondsLeft = 500;
  late Timer countDown;
  Duration duration1 = Duration();
  static var countdownDuration1 = Duration(minutes: 10);
  var hours1;
  var mints1;
  var secs1;
  Timer? timer1;

  @override
  void initState() {
    reset1();
    startTimer1();
    hours1 = int.parse("03");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              "Time Left",
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Constants.grey),
            ),
            Container(
              // width: MediaQuery.of(cxontext).size.width/2,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: buildTime1()
            ),
          ],
        ),
        VerticalDivider(color: Constants.grey,),


        ElevatedButton(
          onPressed: (){
            print('Finish');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>viewAnalysis())
            );
          },
          child: Text('Finish Test'),
        )
      ],
    );
  }


  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Constants.grey)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.grey),),
        // Spacer(),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        // Spacer(),
        Text(':', style: GoogleFonts.poppins(fontSize: 15,color: Constants.grey),),
        // Spacer(),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ]),
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Constants.grey,
                      fontSize: 15),
                ),

              ],
            ),
          ),
/*          SizedBox(
            height: 24,
          ),
          Text(header, style: GoogleFonts.poppins(color: Colors.black45)),*/
        ],
      );

  void reset1() {
    setState(() => duration1 = countdownDuration1);
  }

  void startTimer1() {
    timer1 = Timer.periodic(Duration(seconds: 1), (_) => addTime1());
  }

  void addTime1() {

    final addSeconds = 1;
    if (mounted) {
      setState(() {
        final seconds = duration1.inSeconds - addSeconds;
        if (seconds < 0) {
          timer1?.cancel();
        } else {
          duration1 = Duration(seconds: seconds);
          // print(duration1);
        }
      });
    }
  }
}



