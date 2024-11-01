import 'package:attendance/BloC/LoginBloC.dart';
import 'package:attendance/TextStyles/TextStyles.dart';
import 'package:attendance/auth/auth_service.dart';
import 'package:attendance/components/page_navigator_arrow.dart';
import 'package:attendance/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  AuthService _authService = AuthService();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(36, 0, 0, 0),
                            blurRadius: 10),
                      ],
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Logout",
                            style: Textstyles()
                                .boldTextStyle(24, const Color(0xFF161616)),
                          ),
                          PageNavigatorArrow(
                            onTap: () {
                              _authService.logout();
                              Navigator.pushReplacement(context, 
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => LoginBloc(),
                                    child: LoginPage(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}