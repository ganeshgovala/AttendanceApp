import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class HomePageFunctions {
  Future<Map<String, String>> reloadData(String reg_no, String password) async {
    print("reloadData function called");
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/updateData');
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
}