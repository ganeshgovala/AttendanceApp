import 'package:attendance/Colors.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BunkOMeterPage extends StatefulWidget {
  final String reg_no;
  const BunkOMeterPage({
    required this.reg_no,
    super.key
  });

  @override
  State<BunkOMeterPage> createState() => _BunkOMeterPageState();
}

class _BunkOMeterPageState extends State<BunkOMeterPage> {

  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June','July', 'August', 'September', 'October', 'November', 'December'];
  int date = DateTime.now().month;
  Future<void> getTotalWorkingDays() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection('WorkingDays').doc(months[date - 1]).get();
    final data = documentSnapshot.data();
    setState(() {
      total_working_hours = data!['total'];
    });
  }

  int total_working_hours = 0;
  int attended = 0;
  int total = 0;
  final month = DateTime.now();

  Future<void> fetchData(String reg_no) async {
    DocumentSnapshot<Map<String,dynamic>>documentSnapshots = await FirebaseFirestore.instance.collection("Users").doc(reg_no).collection("Attendance").doc("AttendanceInfo").get();
    final data = documentSnapshots.data()!;
    final String this_month_attended = data['this_month_attended'];
    setState(() {
      attended = int.parse(this_month_attended.substring(0,2));
      total = int.parse(this_month_attended.substring(5));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(widget.reg_no);
    getTotalWorkingDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.arrow_back_ios, size: 22),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                color: CustomColors().backgroundColor,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Text(months[date - 1], style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ))
            ),
            Text("Remaining", style:  Textstyles().boldTextStyle(38, CustomColors().backgroundColor),),
            Text("Bunkable classes", style: TextStyle(
              color: const Color.fromARGB(255, 88, 88, 88),
              fontSize: 16
            )),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 36,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage('lib/assets/images/PurpleBackground.jpg'),
                //   fit: BoxFit.cover,
                // ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6025F5),
                    const Color(0xFFFF5555),
                  ] 
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text("${((total_working_hours - (total_working_hours * 0.8)).floor()) - (total - attended)}", style: Textstyles().boldTextStyle(120, Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Bunkable classes", style: Textstyles().boldTextStyle(20, CustomColors().backgroundColor )),
                  Text("${(total_working_hours * 0.2).floor()}", style: Textstyles().boldTextStyle(20, CustomColors().backgroundColor),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
