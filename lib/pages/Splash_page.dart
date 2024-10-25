import 'package:attendance/BloC/AttendanceBloc.dart';
import 'package:attendance/BloC/LoginBloC.dart';
import 'package:attendance/pages/HomePage.dart';
import 'package:attendance/pages/login_page.dart';
import 'package:attendance/pages/openingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Check if the user is logged in
  _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    String? reg_no = prefs.getString('reg_no');
    bool? is_new = prefs.getBool('is_new');


    if(is_new != null && is_new) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OpeningPage()));
    } else if (isLoggedIn != null && isLoggedIn && reg_no != null) {
      // If the user is logged in, navigate to the homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BlocProvider(
          create: (context) => AttendanceBloc(),
          child: HomePage(reg_no: reg_no),
        )),
      );
    } else {
      // If not logged in, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginPage()
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
