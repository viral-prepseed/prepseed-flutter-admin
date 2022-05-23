import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/constants/colorPalate.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/leadership.png',width: 25,color: Constants.grey,),
                  Text('Leaderboard', style: GoogleFonts.poppins(color: Constants.grey),),
                ],
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, position) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name'+position.toString()),
                      Text('554541'),
                    ],
                  )
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
