import 'package:attendance/BloC/LoginBloC.dart';
import 'package:attendance/Colors.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:attendance/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment(0, 1),
      children: [
      Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/images/openingPage.jpeg'),
            fit: BoxFit.cover,
          )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(174, 65, 65, 65), const Color.fromARGB(123, 48, 48, 48), const Color.fromARGB(73, 68, 68, 68), const Color.fromARGB(48, 21, 21, 21),const Color.fromARGB(75, 0, 0, 0), const Color.fromARGB(125, 0, 0, 0), const Color.fromARGB(173, 68, 68, 68)] ,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Visualise your Attendance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Stay on top of your attendance with insightful" + 
                "visualizations. Track, analyze, and improve your" + 
                "attendance trends all in one place. Ready to get started?" +
                "Let’s dive in!",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 13
                ),
              ),
              SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => BlocProvider(
                      create: (context) => LoginBloc(),
                      child: LoginPage(),
                    )));
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CustomColors().yellowColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Get Started", style : Textstyles().buttonTextStyle()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20),
    ]));
  }
}
