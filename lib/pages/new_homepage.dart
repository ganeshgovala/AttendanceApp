// ignore_for_file: unused_import, unnecessary_import

import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:attendance/components/home_page_container.dart';
import 'package:attendance/components/home_page_functions.dart';
import 'package:attendance/components/small_homepage_container.dart';
import 'package:attendance/pages/aboutDeveloper.dart';
import 'package:attendance/pages/terms_and_conditionsPage.dart';
import 'package:attendance/pages/this_month_page.dart';
import 'package:attendance/pages/till_now_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewHomepage extends StatefulWidget {
  final String reg_no;
  HomePageFunctions _homePageFunctions = HomePageFunctions();
  NewHomepage({required this.reg_no, super.key});

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {
  String username = 'Loading...';
  String? password;
  String lastUpdated = "";
  bool isLoading = false;
  int total_working_hours = 0;
  int attended = 0;
  int total = 0;
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June','July', 'August', 'September', 'October', 'November', 'December'];
  int date = DateTime.now().month;

  Future<void> setLastUpdatedValue(int date, int month, int year, int hour, int min) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('LastUpdatedDate', date);
    await prefs.setInt('LastUpdatedMonth', month);
    await prefs.setInt('LastUpdatedYear', year);
    await prefs.setInt('LastUpdatedHour', hour);
    await prefs.setInt('LastUpdatedMin', min);
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

  Future<void> getTotalWorkingDays() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection('WorkingDays').doc(months[date - 1]).get();
    final data = documentSnapshot.data();
    setState(() {
      total_working_hours = data!['total'];
    });
  }

  Future<void> fetchData(String reg_no) async {
    DocumentSnapshot<Map<String,dynamic>>documentSnapshots = await FirebaseFirestore.instance.collection("Users").doc(reg_no).collection("Attendance").doc("AttendanceInfo").get();
    final data = documentSnapshots.data()!;
    final String this_month_attended = data['this_month_attended'];
    setState(() {
        List<String> parts = this_month_attended.split('/').map((e) => e.trim()).toList();
        List<int> numbers = parts.map(int.parse).toList();
        attended = numbers[0];
        total = numbers[1];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName(widget.reg_no);
    lastUpdatedValidator();
    fetchData(widget.reg_no);
    getTotalWorkingDays();
  }

  Future<void> lastUpdatedValidator() async {
    SharedPreferences _sharedpreferences =
        await SharedPreferences.getInstance();
    int? lastUpdatedDay = _sharedpreferences.getInt('LastUpdatedDate');
    int? lastUpdatedMonth = _sharedpreferences.getInt('LastUpdatedMonth');
    int? lastUpdatedYear = _sharedpreferences.getInt('LastUpdatedYear');
    int? lastUpdatedHour = _sharedpreferences.getInt('LastUpdatedHour');
    int? lastUpdatedMin = _sharedpreferences.getInt('LastUpdatedMin');
    String response;
    
    DateTime startDate;
    DateTime endDate;
    Duration difference;
    int durationMinutes;
    int durationHours;
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    int currentHour = DateTime.now().hour;
    int currentMin = DateTime.now().minute;

    if (lastUpdatedYear == null ||
        lastUpdatedMonth == null ||
        lastUpdatedDay == null ||
        lastUpdatedHour == null ||
        lastUpdatedMin == null) {
      response = "";
    } else {
      startDate = DateTime(lastUpdatedYear, lastUpdatedMonth, lastUpdatedDay, lastUpdatedHour, lastUpdatedMin);
      endDate = DateTime(currentYear, currentMonth, currentDay, currentHour, currentMin);
      difference = endDate.difference(startDate);
      durationMinutes = difference.inMinutes;
      durationHours = difference.inHours;
      if (durationMinutes == 0) {
        response = "Just Now";
      } else if (durationMinutes < 60) {
        response = "$durationMinutes min ago";
      } else if(durationHours < 24) {
        response = "${durationHours}h ago";
      } else {
        response = "${durationHours % 24}d ago";
      }
    }

    setState(() {
      lastUpdated = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 85,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 39, 39, 39),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Image.asset('lib/assets/images/handWave.png',
                            height: 24),
                        SizedBox(width: 10),
                        Text(username,
                            style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 172, 172, 172),
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      print("Tapped");
                      setState(() {
                        isLoading = true;
                      });
                      final result = await widget._homePageFunctions
                          .reloadData(widget.reg_no, password!);
                      print(result);
                      await widget._homePageFunctions.addAttendanceData(
                          widget.reg_no,
                          result['till_now']!,
                          result['till_now_attended']!,
                          result['this_month']!,
                          result['this_month_attended']!);
                      print("Data Added");
                      await setLastUpdatedValue(DateTime.now().day,
                          DateTime.now().month, DateTime.now().year, DateTime.now().hour, DateTime.now().minute);
                      setState(() {
                        lastUpdatedValidator();
                        isLoading = false;
                      });
                      print("Completed");
                    },
                    child: Container(
                        width: 50,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 30, 30, 30),
                            borderRadius: BorderRadius.circular(20)),
                        child: isLoading == false
                            ? Icon(Icons.refresh,
                                color: const Color.fromARGB(255, 82, 82, 82),
                                size: 24)
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 4),
                                child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: const Color.fromARGB(
                                            255, 82, 82, 82))),
                              )),
                  ),
                ],
              ),
            ),
            // Color.fromARGB(255, 238, 255, 107)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TillNowPage(
                              reg_no: widget.reg_no,
                              password: password!,
                            )));
              },
              child: HomePageContainer(
                  icon: Icons.school_outlined,
                  color: Color.fromARGB(255, 255, 107, 107),
                  heading: "Till Now",
                  percentage: "94.58%",
                  container1: "Attended : 39 / 43",
                  container2: lastUpdated,
                  collectionName1: 'Users',
                  doc1: widget.reg_no,
                  collectionName2: "Attendance",
                  doc2: "AttendanceInfo",
                  mainDataAttribute: "till_now",
                  attendedDataAttribute: "till_now_attended"),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThisMonthPage(
                              reg_no: widget.reg_no,
                              password: password!,
                            )));
              },
              child: HomePageContainer(
                icon: Icons.calendar_month_outlined,
                color: Color.fromARGB(255, 137, 255, 107),
                heading: "This month",
                percentage: "82.61%",
                container1: "Attended : 21 / 43",
                container2: months[date - 1],
                collectionName1: 'Users',
                doc1: widget.reg_no,
                collectionName2: "Attendance",
                doc2: "AttendanceInfo",
                mainDataAttribute: "this_month",
                attendedDataAttribute: "this_month_attended",
              ),
            ),
            BunkOMeter(),
            //Color.fromARGB(255, 255, 184, 107)
            Row(
              children: [
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutDeveloperPage()));
                  },
                  child: SmallHomepageContainer(
                      color: const Color.fromARGB(255, 244, 244, 244),
                      icon: Icons.person_outline_rounded,
                      heading: "About\nDeveloper"),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                  },
                  child: SmallHomepageContainer(
                      color: Color.fromARGB(255, 107, 255, 255),
                      icon: Icons.warning_amber_rounded,
                      heading: "Terms and\nConditions"),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 15),
                SmallHomepageContainer(
                    color: Color.fromARGB(255, 201, 107, 255),
                    icon: Icons.favorite,
                    heading: "Made with\nLove"),
                SizedBox(width: 5),
                SmallHomepageContainer(
                    color: Color.fromARGB(255, 255, 184, 107),
                    icon: Icons.logout_rounded,
                    heading: "Logout"),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text("Stay tuned for more updates",
                  style: GoogleFonts.ubuntu(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600,
                  )),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget BunkOMeter() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 238, 255, 107),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.class_outlined, size: 20, color: Colors.black),
                SizedBox(width: 10),
                Text("Remaining bunkable classes",
                    style: GoogleFonts.ubuntu(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            Text("${((total_working_hours - (total_working_hours * 0.8)).floor()) - (total - attended)}",
                style: GoogleFonts.ubuntu(
                  fontSize: 55,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                )),
            Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(37, 0, 0, 0),
                    borderRadius: BorderRadius.circular(40)),
                child: Text("Total Bunkable Classes : ${(total_working_hours * 0.2).floor()}",
                    style: GoogleFonts.ubuntu(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )))
          ],
        ),
      ),
    );
  }
}
