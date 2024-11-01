// event
// ignore_for_file: unnecessary_set_literal
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

abstract class AttendanceEvent {}
class FetchAttendanceEvent extends AttendanceEvent{
  final String reg_no;
  final String password;
  FetchAttendanceEvent({required this.reg_no, required this.password});
}

// state
abstract class AttendanceState{}

class InitialAttendanceState extends AttendanceState{}
class LoadingAttendanceState extends AttendanceState{}

class LoadedAttendanceState extends AttendanceState{
  final Map<String,String> result;
  LoadedAttendanceState(this.result);
}

class ErrorAttendanceState extends AttendanceState{
  final String error;
  ErrorAttendanceState(this.error);
}

// bloc
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(InitialAttendanceState()) {
    on<FetchAttendanceEvent>((event, emit) async {
      emit(LoadingAttendanceState());
      final response = await validationChecker(event.reg_no, event.password);
      emit(LoadedAttendanceState(response));
    });
  }

  Future<Map<String,String>> validationChecker(String reg_no, String password) async {
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/updateData');
    final Map<String, String> data = {
      'username' : reg_no,
      'password' : password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type' : 'application/json',
      },
      body: jsonEncode(data)
    );
    if(response.statusCode == 200) {
      final Map<String,dynamic> result = jsonDecode(response.body); 
      return {
        "till_now" : result['message']['till_now'],
        "till_now_attended" : result['message']['till_now_attended'],
        "this_month" : result['message']['this_month'],
        "this_month_attended" : result['message']['this_month_attended'],
        "name" : result['message']['name']
      };
    }
    return {"till_now" : "Invalid"};
  }
}