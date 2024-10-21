import 'package:attendance/BloC/AttendanceBloc.dart';
import 'package:attendance/BloC/RegisterBloc.dart';
import 'package:attendance/Colors.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:attendance/auth/auth_service.dart';
import 'package:attendance/components/InputField.dart';
import 'package:attendance/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _regNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  AuthService _authService = AuthService();

  Future<void> addUserData(String reg_no, String password, String name) async {
    print("Add UserData Function called");
    try {
      print("Try block Called");
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(reg_no)
          .collection('Details')
          .doc('UserInfo')
          .set({
        'reg_no': reg_no,
        'password': password,
        'name': name,
      });
      print("Try block executed");
    } catch (err) {
      print(err);
    }
    print("Add UserData Function Ended");
  }

  Future<void> addAttendanceData(
      String reg_no,
      String till_now,
      String till_now_attended,
      String this_month,
      String this_month_attended) async {
    print("Add Attendance Function called");
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(reg_no)
        .collection("Attendance")
        .doc('AttendanceInfo')
        .set({
      'till_now': till_now,
      'till_now_attended': till_now_attended,
      'this_month': this_month,
      'this_month_attended': this_month_attended,
    });
    print("Add Attendance Function Ended");
  }

  Future<String> register(String email, String password) async {
    try {
      await _authService.register(email: email, password: password);
      return "Valid";
    } on FirebaseException catch (err) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: err.code,
          confirmBtnColor: const Color.fromARGB(255, 78, 78, 78),
          confirmBtnTextStyle: GoogleFonts.figtree(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 225, 225, 225)),
          headerBackgroundColor: CustomColors().yellowColor);
    }
    return "Invalid";
  }

  _saveLoginStatus(String reg_no) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('reg_no', reg_no);
    await prefs.setBool('is_new', false);
  }

  @override
  Widget build(BuildContext context) {
    final registerbloc = BlocProvider.of<RegisterBloc>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 5),
              Center(
                child: Text(
                  "Signup here...",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 30, 30, 30),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Create an account to enjoy the feautures",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 90, 90, 90),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                'lib/images/Security.png',
                height: 150,
              ),
              SizedBox(height: 20),
              InputField(
                hintText: "College Mail",
                obsecureText: false,
                controller: _regNoController,
              ),
              SizedBox(height: 15),
              InputField(
                  controller: _passwordController,
                  hintText: "Password",
                  obsecureText: false),
              SizedBox(height: 15),
              InputField(
                  controller: _repasswordController,
                  hintText: "Re-Enter Password",
                  obsecureText: false),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_regNoController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _repasswordController.text.isEmpty) {
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
                  } else if (_passwordController.text ==
                      _repasswordController.text) {
                    registerbloc.add(FetchRegisterEvent(
                        reg_no: _regNoController.text.substring(0, 10),
                        password: _passwordController.text));
                  } else {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text: "Passwords do not match. Please try again.",
                        confirmBtnColor: const Color.fromARGB(255, 78, 78, 78),
                        confirmBtnTextStyle: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 225, 225, 225)),
                        headerBackgroundColor: CustomColors().yellowColor);
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
                    child: Text(
                      "Sign up",
                      style: Textstyles().buttonTextStyle(),
                    )),
              ),
              SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Already have an account",
                      style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 18, 18, 18))),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
                if (state is InitialRegisterState) {
                  return Container();
                }
                if (state is LoadingRegisterState) {
                  return CircularProgressIndicator(
                    color: Colors.black,
                  );
                }
                if (state is LoadedRegisterState) {
                  if (state.result['till_now'] != 'Invalid' &&
                      state.result['till_now'] != 'Error') {
                    Future.microtask(() async {
                      final result = await register(
                          _regNoController.text, _passwordController.text);
                      if (result == "Valid") {
                        await _saveLoginStatus(_regNoController.text.substring(0,10));
                        await addUserData(_regNoController.text.substring(0, 10),
                            _passwordController.text, state.result['name']!);
                        await addAttendanceData(
                            _regNoController.text.substring(0, 10),
                            state.result['till_now']!,
                            state.result['till_now_attended']!,
                            state.result['this_month']!,
                            state.result['this_month_attended']!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) => AttendanceBloc(),
                                    child: HomePage(
                                        reg_no: _regNoController.text
                                            .substring(0, 10)))));
                      }
                    });
                  } else if (state.result['till_now'] == 'Invalid') {
                    return Text("Invalid Login Credentials",
                        style: GoogleFonts.figtree(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 28, 28, 28),
                        ));
                  } else {
                    return Text("Some error on our side. Please try again later",
                        style: GoogleFonts.figtree(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 28, 28, 28),
                        ));
                  }
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
