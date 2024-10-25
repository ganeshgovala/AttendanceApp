import 'dart:convert';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ThisMonthPage extends StatefulWidget {
  final String reg_no;
  final String password;
  const ThisMonthPage(
      {required this.reg_no, required this.password, super.key});

  @override
  State<ThisMonthPage> createState() => _ThisMonthPageState();
}

class _ThisMonthPageState extends State<ThisMonthPage> {
  List? subdata;

  void fetchSubWiseData(String reg_no, String password) async {
    print("Fetching data...");
    final url = Uri.parse('http://127.0.0.1:5000/thisMonthSubWise');
    final Map<String, String> data = {'username': reg_no, 'password': password};
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        subdata = data;
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubWiseData(widget.reg_no, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background and main containers
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 237, 237, 237),
          ),
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('lib/images/YellowBackground.jpg'),
              //   fit: BoxFit.cover,
              // ),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 255, 8),
                  const Color.fromARGB(255, 31, 243, 197),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: const Color.fromARGB(255, 27, 27, 27),
                size: 30,
              ),
            ),
          ),
          Positioned(
            top: 90,
            left: 18,
            right: 18,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 4,
                              color: const Color.fromARGB(255, 226, 226, 226),
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total %",
                              style: TextStyle(
                                color: Color.fromARGB(255, 41, 41, 41),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                      style: Textstyles().boldTextStyle(
                                          45, const Color(0xFF161616)),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Text(
                                      "Error 🙁",
                                      style: Textstyles().boldTextStyle(
                                          45, const Color(0xFF161616)),
                                    );
                                  }
                                  final DocumentSnapshot<Map<String, dynamic>>
                                      data = snapshot.data!;
                                  if (data.exists) {
                                    return Text(
                                      data['till_now'] + "%",
                                      style: Textstyles().boldTextStyle(
                                          45, const Color(0xFF161616)),
                                    );
                                  }
                                  return Text(
                                    "Data Doesn't exist",
                                    style: Textstyles().boldTextStyle(
                                        40, const Color(0xFF161616)),
                                  );
                                }),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Attended",
                              style: TextStyle(
                                color: Color.fromARGB(255, 41, 41, 41),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
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
                                return Text("${data['till_now_attended']}",
                                    style: Textstyles()
                                        .boldTextStyle(25, Colors.black));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: 36,
            right: 36,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subject",
                        style: GoogleFonts.figtree(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    Text("Attended",
                        style: GoogleFonts.figtree(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    Text("Percentage",
                        style: GoogleFonts.figtree(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 18,
            right: 18,
            bottom: 20,
            child: subdata == null
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Text("This may take a while",
                          style: TextStyle(fontSize: 20))
                    ],
                  ))
                : subdata!.isEmpty
                    ? const Center(child: Text("No data available"))
                    : SubWiseAttendance(),
          ),
        ],
      ),
    );
  }

  // List of subjects with attendance
  Widget SubWiseAttendance() {
    return ListView.builder(
      itemCount: subdata!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 82,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          child: Text(
                            subdata![index][0],
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(subdata![index][2].toString() + " / ",
                                  style: GoogleFonts.figtree(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text(
                                subdata![index][1].toString(),
                                style: GoogleFonts.figtree(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 92,
                          child: Text(subdata![index][3].toString(),
                              style: GoogleFonts.figtree(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2, color: Colors.grey[400])
          ],
        );
      },
    );
  }
}
