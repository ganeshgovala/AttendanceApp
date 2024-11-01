// ignore_for_file: unused_element
import 'package:attendance/BloC/LoginBloC.dart';
import 'package:attendance/BloC/RegisterBloc.dart';
import 'package:attendance/Colors.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:attendance/components/InputField.dart';
import 'package:attendance/pages/new_homepage.dart';
import 'package:attendance/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _regNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _saveLoginStatus(String reg_no) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('reg_no', reg_no);
    await prefs.setBool('is_new', false);
  }

  @override
  Widget build(BuildContext context) {
    final loginbloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Sign in here...",
                  style: TextStyle(
                    color: CustomColors().backgroundColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Welcome back you’ve been missed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 60, 60, 60),
                  ),
                ),
              ),
              Image.asset(
                'lib/assets/images/Security.png',
                height: 220,
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                  controller: _regNoController,
                  hintText: "Email",
                  obsecureText: false),
              SizedBox(height: 15),
              InputField(
                  controller: _passwordController,
                  hintText: "Password",
                  obsecureText: true),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_regNoController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text: "Please enter your email and password",
                        confirmBtnColor: const Color.fromARGB(255, 78, 78, 78),
                        confirmBtnTextStyle: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 225, 225, 225)),
                        headerBackgroundColor: CustomColors().yellowColor);
                  } else {
                    loginbloc.add(CheckLoginEvent(
                      email: _regNoController.text,
                      password: _passwordController.text));
                  }
                },
                child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: CustomColors().yellowColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child:
                        Text("Sign in", style: Textstyles().buttonTextStyle())),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => RegisterBloc(),
                                  child: RegisterPage(),
                                )));
                  },
                  child: Text("Create an account",
                      style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 18, 18, 18))),
                ),
              ),
              SizedBox(height: 20),
              // Use BlocListener for navigation
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoadedLoginState) {
                    if (state.result == 'Valid') {
                      _saveLoginStatus(_regNoController.text.substring(0, 10));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewHomepage(reg_no: _regNoController.text.substring(0, 10)),
                        ),
                      );
                    } else {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: state.result,
                          confirmBtnColor:
                              const Color.fromARGB(255, 78, 78, 78),
                          confirmBtnTextStyle: GoogleFonts.figtree(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 225, 225, 225)),
                          headerBackgroundColor: CustomColors().yellowColor);
                    }
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is InitialLoginState) {
                      return Container();
                    }
                    if (state is LoadingLoginState) {
                      return CircularProgressIndicator(
                        color: Colors.black,
                      );
                    }
                    return Container(); // Return empty container as a placeholder
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
