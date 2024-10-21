import 'package:attendance/Colors.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:flutter/material.dart';

class Datewisepage extends StatefulWidget {
  const Datewisepage({super.key});

  @override
  State<Datewisepage> createState() => _DatewisepageState();
}

class _DatewisepageState extends State<Datewisepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {Navigator.pop(context);},
                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: const Color.fromARGB(221, 224, 224, 224))),
                SizedBox(width: 10),
                Text("Date Wise Attendance", style: Textstyles().boldTextStyle(20, const Color.fromARGB(221, 214, 214, 214)),)
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Container(child: Column(
                    children: [
                      Image.asset('lib/images/UnderDevelopment.png', height: 200,),
                      SizedBox(height: 20),
                      Text("Under Development", style: Textstyles().boldTextStyle(30,Colors.white),)
                    ],
                  )),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}