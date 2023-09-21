import 'package:flutter/material.dart';
import 'package:flutter_application_1/serivces/authorization/emailpasswordauth.dart';
import 'package:flutter_application_1/serivces/firestore/userdetails.dart';
import 'package:flutter_application_1/utlis/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = UserDetails();
    final height = MediaQuery.sizeOf(context).height;

    EmailPasswordAuthServices emailPasswordAuthServices =
        EmailPasswordAuthServices();
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: userDetails.getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LinearProgressIndicator(
                        minHeight: 10,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text("Some error");
                  }
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height * 0.3,
                            // height: 100,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          Container(
                            height: height * 0.3,
                            // height: 60,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade300,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                )),
                          ),
                          Align(
                              heightFactor: 1.8,
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  radius: 60,
                                  child: InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      backgroundImage:
                                          snapshot.data['profile-pic'] != ''
                                              ? Image.network(snapshot
                                                      .data['profile-pic']
                                                      .toString())
                                                  .image
                                              : null,
                                      backgroundColor: const Color.fromARGB(
                                          255, 230, 227, 227),
                                      radius: 55,
                                    ),
                                  ))),
                          Align(
                              heightFactor: 3,
                              alignment: Alignment.center,
                              child: Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "Hello " + snapshot.data['first-name'],
                                style: GoogleFonts.satisfy(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.homeview);
                        },
                        leading: const Icon(Icons.home),
                        title: const Text("Home"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.editprofileview);
                        },
                        leading: const Icon(Icons.person),
                        title: const Text("Edit Profile"),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.notifications),
                        title: const Text("Notifications"),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.favorite),
                        title: const Text("Favourites"),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.location_on),
                        title: const Text("Find us"),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListTile(
                        enabled:
                            snapshot.data['role'] == 'admin' ? true : false,
                        leading: const Icon(Icons.people_alt),
                        title: const Text("Admin features"),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListTile(
                        onTap: () async {
                          emailPasswordAuthServices.logout(context, '');
                        },
                        leading: const Icon(Icons.logout_outlined),
                        title: const Text("Logout"),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
