// Events

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

abstract class RegisterEvent {}

class FetchRegisterEvent extends RegisterEvent {
  final String reg_no;
  final String password;
  FetchRegisterEvent({required this.reg_no, required this.password});
}

// States

abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class LoadedRegisterState extends RegisterState {
  final Map<String, dynamic> result;
  LoadedRegisterState(this.result);
}

class ErrorRegisterState extends RegisterState {}

// BloC
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialRegisterState()) {
    on<FetchRegisterEvent>((event, emit) async {
      emit(LoadingRegisterState());
      final response = await validationChecker(event.reg_no, event.password);
      emit(LoadedRegisterState(response));
    });
  }

  Future<Map<String, dynamic>> validationChecker(
      String reg_no, String password) async {
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/getAttendance');
    // For App : http://192.168.235.94:5000
    final Map<String, String> data = {
      'username': reg_no,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      if(result['message'] != "Invalid") {
        return {
          "till_now": result['message']['till_now'].toString(),
          "till_now_attended": result['message']['till_now_attended'].toString(),
          "this_month": result['message']['this_month'].toString(),
          "this_month_attended": result['message']['this_month_attended'].toString(),
          "name": result['message']['name'].toString(),
        };
      }
      else {
        return {"till_now" : "Invalid"};
      }
    }

    return {"till_now" : "Error"};  
  }
}
