// ignore_for_file: unused_import

import 'package:attendance/BloC/AttendanceBloc.dart';
import 'package:attendance/BloC/LoginBloC.dart';
import 'package:attendance/BloC/RegisterBloc.dart';
import 'package:attendance/firebase_options.dart';
import 'package:attendance/pages/DateWisePage.dart';
import 'package:attendance/pages/HomePage.dart';
import 'package:attendance/pages/Splash_page.dart';
import 'package:attendance/pages/bottom_navigation_bar.dart';
import 'package:attendance/pages/login_page.dart';
import 'package:attendance/pages/openingPage.dart';
import 'package:attendance/pages/till_now_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isNewUser = prefs.getBool('is_new');

  if (isNewUser == null) {
    await prefs.setBool('is_new', true);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => AttendanceBloc(),),
          BlocProvider(create: (context) => RegisterBloc()),
        ],
        child: BottomNavigationBarPage(reg_no: '23pa1a0577',),
      ),
      theme: ThemeData(
        textTheme: GoogleFonts.figtreeTextTheme(),
      ),
    );
  }
}