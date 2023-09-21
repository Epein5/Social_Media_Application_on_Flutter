// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/resources/components/bottomNav.dart';
import 'package:flutter_application_1/resources/components/drawer.dart';
// import 'package:flutter_application_1/utlis/routes/routes.dart';
import 'package:flutter_application_1/view/chatview.dart';
import 'package:flutter_application_1/view/postview.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedindex = 0;

  // void _navigatebottombar(int index) {
  //   setState(() {
  //     _selectedindex = index;
  //   });
  // }

  final List<Widget> _pages = [
    const PostView(),
    const PostView(),
    const ChatView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade400,
        drawer: const MyDrawer(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(20),
            // )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: GNav(
                gap: 10,
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: const Color.fromARGB(255, 236, 184, 245),
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.all(10),
                onTabChange: (value) {
                  setState(() {
                    _selectedindex = value;
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.message,
                    text: 'Chat',
                  )
                ]),
          ),
        ),
        body: _pages[_selectedindex]);
  }
}
