// ignore_for_file: unnecessary_import, unused_import

import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String heading;
  final String percentage;
  final String container1;
  final String container2;

  //-----------------------
  //    Stream values
  //-----------------------

  final String collectionName1;
  final String doc1;
  final String collectionName2;
  final String doc2;
  final String mainDataAttribute;
  final String attendedDataAttribute;
  const HomePageContainer(
      {required this.icon,
      required this.color,
      required this.heading,
      required this.percentage,
      required this.container1,
      required this.container2,
      required this.collectionName1,
      required this.doc1,
      required this.collectionName2,
      required this.doc2,
      required this.mainDataAttribute,
      required this.attendedDataAttribute,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Colors.black),
                SizedBox(width: 10),
                Text(heading,
                    style: GoogleFonts.ubuntu(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(collectionName1)
                    .doc(doc1)
                    .collection(collectionName2)
                    .doc(doc2)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...",
                        style: GoogleFonts.ubuntu(
                          fontSize: 55,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ));
                  }
                  if (snapshot.hasError) {
                    return Text("Error",
                        style: GoogleFonts.ubuntu(
                          fontSize: 55,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ));
                  }
                  final DocumentSnapshot<Map<String, dynamic>> data =
                      snapshot.data!;
                  // data['till_now'] + "%"
                  if (data.exists) {
                    return Text(data[mainDataAttribute] + "%",
                        style: GoogleFonts.ubuntu(
                          fontSize: 55,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ));
                  }
                  return Text('Data not found',
                      style: GoogleFonts.ubuntu(
                        fontSize: 55,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ));
                }),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(37, 0, 0, 0),
                        borderRadius: BorderRadius.circular(40)),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(collectionName1)
                          .doc(doc1)
                          .collection(collectionName2)
                          .doc(doc2)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...",
                              style: GoogleFonts.ubuntu(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ));
                        }

                        if (snapshot.hasError) {
                          return Text("Error",
                              style: GoogleFonts.ubuntu(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ));
                        }

                        //"Attended : ${data['this_month_attended']}",

                        final DocumentSnapshot<Map<String, dynamic>> data =
                            snapshot.data!;
                        if (data.exists) {
                          return Text(
                              "Attended : ${data[attendedDataAttribute]}",
                              style: GoogleFonts.ubuntu(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ));
                        }
                        return Text("Attended : ']}",
                            style: GoogleFonts.ubuntu(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ));
                      },
                    )),
                SizedBox(width: 5),
                container2 != ""
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(37, 0, 0, 0),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(container2,
                            style: GoogleFonts.ubuntu(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                      )
                    : Text(""),
              ],
            )
          ],
        ),
      ),
    );
  }
}
