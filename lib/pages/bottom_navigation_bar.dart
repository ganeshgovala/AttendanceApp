import 'package:attendance/BloC/AttendanceBloc.dart';
import 'package:attendance/pages/HomePage.dart';
import 'package:attendance/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarPage extends StatefulWidget {
  final String reg_no;
  BottomNavigationBarPage({
    super.key,
    required this.reg_no,
  });

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _currentIndex = 0;

  void _tabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home},
    {'icon': Icons.person},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      BlocProvider(
        create: (context) => AttendanceBloc(),
        child: HomePage(reg_no: widget.reg_no),
      ), 
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 90,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        // child: BottomNavigationBar(
        //   backgroundColor: Colors.white,
        //     iconSize: 26,
        //     selectedItemColor: Colors.black,
        //     unselectedItemColor: Colors.grey[700],
        //     currentIndex: _currentIndex,
        //     onTap: _tabChange,
        //     items: [
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home_rounded), label: 'Home'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.person_rounded), label: 'Profile'),
        //     ]),
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          width: 142,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: const Color.fromARGB(255, 90, 90, 90)
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            // boxShadow: [
            //   BoxShadow(color: const Color.fromARGB(34, 0, 0, 0), blurRadius: 15),
            // ]
          ),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_navItems.length, (index) {
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                    child: Icon(
                      _navItems[index]['icon'], size : 28,
                      color: _currentIndex == index ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
          )
        ),
      ),
      body: pages[_currentIndex],
    );
  }
}
