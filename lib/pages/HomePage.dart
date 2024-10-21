// ignore_for_file: unused_import, unused_local_variable

import 'dart:convert';

import 'package:attendance/BloC/AttendanceBloc.dart';
import 'package:attendance/Colors.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:attendance/components/page_navigator_arrow.dart';
import 'package:attendance/pages/Bunk-o-Meter.dart';
import 'package:attendance/pages/DateWisePage.dart';
import 'package:attendance/pages/this_month_page.dart';
import 'package:attendance/pages/till_now_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String reg_no;
  const HomePage({required this.reg_no, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = 'Loading...';
  String? password;

  Future<Map<String, String>> reloadData(String reg_no, String password) async {
    print("reloadData function called");
    final url = Uri.parse('http://127.0.0.1:5000/updateData');
    final Map<String, String> data = {
      'username': reg_no,
      'password': password,
    };
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return {
        "till_now": result['message']['till_now'],
        "till_now_attended": result['message']['till_now_attended'],
        "this_month": result['message']['this_month'],
        "this_month_attended": result['message']['this_month_attended'],
        "name": result['message']['name']
      };
    }
    print('reloadData function ended');
    return {"till_now": "Invalid"};
  }

  void getUserName(String reg_no) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(reg_no)
              .collection('Details')
              .doc('UserInfo')
              .get();
      final data = documentSnapshot.data();
      final String name = data!['name'];
      final String pass = data['password'];
      final List<String> actual_name = name.split(' ');
      actual_name.removeAt(0);
      setState(() {
        username = actual_name.join(' ');
        password = pass;
      });
    } catch (err) {
      print(err.toString());
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName(widget.reg_no);
  }

  @override
  Widget build(BuildContext context) {
    final attendancebloc = BlocProvider.of<AttendanceBloc>(context);
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Whats'up",
                            style: Textstyles().subHeading(
                                const Color.fromARGB(255, 157, 157, 157))),
                        Container(
                            width: MediaQuery.of(context).size.width - 45,
                            child: Text(username,
                                style: Textstyles().boldTextStyle(
                                    24, const Color.fromARGB(255, 255, 255, 255))))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TillNowPage(reg_no: widget.reg_no, password: password!,)));},
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(26),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(const Color.fromARGB(26, 0, 0, 0), BlendMode.darken),
                          image: AssetImage('lib/images/TillNowBackground.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(50),),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Till Now",
                              style: Textstyles().subHeading(Colors.black),
                            ),
                            GestureDetector(
                              onTap: () async {
                                print("Tapped");
                                final result =
                                    await reloadData(widget.reg_no, password!);
                                print(result);
                                addAttendanceData(
                                    widget.reg_no,
                                    result['till_now']!,
                                    result['till_now_attended']!,
                                    result['this_month']!,
                                    result['this_month_attended']!);
                                print("Data Added");
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(29, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(Icons.replay_outlined,
                                      color: const Color.fromARGB(219, 0, 0, 0),
                                      size: 20)),
                            )
                          ],
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.reg_no)
                                .collection('Attendance')
                                .doc('AttendanceInfo')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  "Loading...",
                                  style: Textstyles()
                                      .boldTextStyle(55, const Color(0xFF161616)),
                                );
                              }
                              if (snapshot.hasError) {
                                return Text(
                                  "Error 🙁",
                                  style: Textstyles()
                                      .boldTextStyle(55, const Color(0xFF161616)),
                                );
                              }
                              final DocumentSnapshot<Map<String, dynamic>> data =
                                  snapshot.data!;
                              if (data.exists) {
                                return Text(
                                  data['till_now'] + "%",
                                  style: Textstyles()
                                      .boldTextStyle(55, const Color(0xFF161616)),
                                );
                              }
                              return Text(
                                "Data Doesn't exist",
                                style: Textstyles()
                                    .boldTextStyle(55, const Color(0xFF161616)),
                              );
                            }),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(50, 255, 255, 255),
                                borderRadius: BorderRadius.circular(50)),
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.reg_no)
                                  .collection('Attendance')
                                  .doc('AttendanceInfo')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text(
                                    "Loading...",
                                    style: Textstyles().subHeading(
                                        const Color.fromARGB(255, 39, 39, 39)),
                                  );
                                }
                
                                if (snapshot.hasError) {
                                  return Text(
                                    "Some Error",
                                    style: Textstyles().subHeading(
                                        const Color.fromARGB(255, 39, 39, 39)),
                                  );
                                }
                
                                final DocumentSnapshot<Map<String, dynamic>>
                                    data = snapshot.data!;
                                return Text(
                                  "Attended : ${data['till_now_attended']}",
                                  style: Textstyles().subHeading(
                                      const Color.fromARGB(255, 39, 39, 39)),
                                );
                              },
                            )),
                      ],
                    )),
              ),
              SizedBox(height: 16),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ThisMonthPage(reg_no: widget.reg_no, password: password!,)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "This Month",
                          style: Textstyles().subHeading(const Color(0xFF161616)),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.reg_no)
                                .collection('Attendance')
                                .doc('AttendanceInfo')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  "Loading...",
                                  style: Textstyles()
                                      .boldTextStyle(55, const Color(0xFF161616)),
                                );
                              }
                              if (snapshot.hasError) {
                                return Text(
                                  "Error 🙁",
                                  style: Textstyles()
                                      .boldTextStyle(55, const Color(0xFF161616)),
                                );
                              }
                              final DocumentSnapshot<Map<String, dynamic>> data =
                                  snapshot.data!;
                              return Text(
                                data['this_month'] + "%",
                                style: Textstyles()
                                    .boldTextStyle(55, const Color(0xFF161616)),
                              );
                            }),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 230, 230),
                                borderRadius: BorderRadius.circular(50)),
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.reg_no)
                                  .collection('Attendance')
                                  .doc('AttendanceInfo')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text(
                                    "Loading...",
                                    style: Textstyles().subHeading(
                                        const Color.fromARGB(255, 39, 39, 39)),
                                  );
                                }
                  
                                if (snapshot.hasError) {
                                  return Text(
                                    "Some Error",
                                    style: Textstyles().subHeading(
                                        const Color.fromARGB(255, 39, 39, 39)),
                                  );
                                }
                  
                                final DocumentSnapshot<Map<String, dynamic>>
                                    data = snapshot.data!;
                                return Text(
                                  "Attended : ${data['this_month_attended']}",
                                  style: Textstyles().subHeading(
                                      const Color.fromARGB(255, 39, 39, 39)),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date Wise",
                            style: Textstyles()
                                .boldTextStyle(24, const Color(0xFF161616)),
                          ),
                          PageNavigatorArrow(
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bunk-O-meter",
                            style: Textstyles()
                                .boldTextStyle(24, const Color(0xFF161616)),
                          ),
                          PageNavigatorArrow(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BunkOMeterPage(
                                            reg_no: widget.reg_no,
                                          )));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
