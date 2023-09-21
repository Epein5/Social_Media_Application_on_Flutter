import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/drawer.dart';
import 'package:flutter_application_1/resources/components/setuptextfields.dart';
import 'package:flutter_application_1/serivces/firestore/userdetails.dart';
import 'package:flutter_application_1/serivces/userstatusservice.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  CurrentUserStatus currentUserStatus = CurrentUserStatus();
  UserDetails userDetails = UserDetails();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController aboutmecontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    addresscontroller.dispose();
    phonenumbercontroller.dispose();
    dobcontroller.dispose();
    aboutmecontroller.dispose();
  }

  File? _image;
  final picker = ImagePicker();

  Future getUserGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    } else {
      print("No Images Picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    // role();

    return Scaffold(
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: userDetails.getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              firstnamecontroller.text = snapshot.data['first-name'].toString();
              lastnamecontroller.text = snapshot.data['last-name'].toString();
              phonenumbercontroller.text =
                  snapshot.data['phone-number'].toString();
              addresscontroller.text = snapshot.data['address'].toString();
              dobcontroller.text = snapshot.data['dob'].toString();
              aboutmecontroller.text = snapshot.data['about-me'].toString();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              firstnamecontroller.text = '......';
              lastnamecontroller.text = '......';
              phonenumbercontroller.text = '......';
              addresscontroller.text = '......';
              dobcontroller.text = '......';
              aboutmecontroller.text = '......';
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
                      height: height * 0.35,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Container(
                      height: height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade300,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(175),
                          )),
                    ),
                    Align(
                        heightFactor: 2.1,
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            radius: 70,
                            child: InkWell(
                              onTap: () {
                                getUserGallery();
                                setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    snapshot.data['profile-pic'] != ''
                                        ? Image.network(
                                                snapshot.data['profile-pic'])
                                            .image
                                        : _image != null
                                            ? Image.file(_image!.absolute).image
                                            : null,
                                backgroundColor:
                                    const Color.fromARGB(255, 230, 227, 227),
                                radius: 65,
                              ),
                            ))),
                    Align(
                        heightFactor: 5,
                        alignment: Alignment.center,
                        child: Text(
                          "Edit your profile",
                          style: GoogleFonts.satisfy(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
                EditProfileTextField(
                  controller: firstnamecontroller,
                  text: 'First Name',
                  icon: Icons.first_page,
                ),
                EditProfileTextField(
                  controller: lastnamecontroller,
                  text: 'Last Name',
                  icon: Icons.last_page,
                ),
                EditProfileTextField(
                  controller: phonenumbercontroller,
                  text: 'Phone Number',
                  icon: Icons.phone,
                ),
                EditProfileTextField(
                  controller: addresscontroller,
                  text: 'Address',
                  icon: Icons.location_city,
                ),
                EditProfileTextField(
                  controller: dobcontroller,
                  suffixtext: 'YYYY/MM/DD',
                  text: 'DOB',
                  icon: Icons.calendar_month,
                ),
                AboutYouTextField(
                  controller: aboutmecontroller,
                  text: 'Edit Your Description.....',
                ),
                RoundBtn(
                  text: "Edit  ",
                  height: height * 0.07,
                  width: width * 0.25,
                  ontap: () {
                    userDetails.adduserdetails(
                        context,
                        firstnamecontroller.text.toString(),
                        lastnamecontroller.text.toString(),
                        addresscontroller.text.toString(),
                        phonenumbercontroller.text.toString(),
                        dobcontroller.text.toString(),
                        aboutmecontroller.text.toString());

                    userDetails.uploadphoto(context, _image!.absolute,
                        firstnamecontroller.text.toString());
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
