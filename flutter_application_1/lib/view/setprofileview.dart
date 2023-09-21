import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/setuptextfields.dart';
import 'package:flutter_application_1/serivces/firestore/userdetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SetProfileView extends StatefulWidget {
  const SetProfileView({super.key});

  @override
  State<SetProfileView> createState() => _SetProfileViewState();
}

class _SetProfileViewState extends State<SetProfileView> {
  UserDetails _userDetails = UserDetails();
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.35,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(80),
                    //     bottomRight: Radius.circular(80))
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
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        radius: 70,
                        child: InkWell(
                          onTap: () {
                            getUserGallery();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundImage: _image != null
                                ? Image.file(
                                    _image!.absolute,
                                    fit: BoxFit.cover,
                                  ).image
                                : null,
                            backgroundColor: Color.fromARGB(255, 230, 227, 227),
                            radius: 65,
                            // child: _image != null
                            //     ? Image.file(
                            //         _image!.absolute,
                            //         height: 300,
                            //         width: 300,
                            //       )
                            //     : Icon(
                            //         Icons.person,
                            //         color: Colors.grey,
                            //         size: 70,
                            //       ),
                          ),
                        ))),
                Align(
                    heightFactor: 5,
                    alignment: Alignment.center,
                    child: Text(
                      "Set up your profile",
                      style: GoogleFonts.satisfy(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
            SetupTextField(
              controller: firstnamecontroller,
              text: 'First Name',
              icon: Icons.first_page,
            ),
            SetupTextField(
              controller: lastnamecontroller,
              text: 'Last Name',
              icon: Icons.last_page,
            ),
            SetupTextField(
              controller: phonenumbercontroller,
              text: 'Phone Number',
              icon: Icons.phone,
            ),
            SetupTextField(
              controller: addresscontroller,
              text: 'Address',
              icon: Icons.location_city,
            ),
            SetupTextField(
              controller: dobcontroller,
              suffixtext: 'YYYY/MM/DD',
              text: 'DOB',
              icon: Icons.calendar_month,
            ),
            AboutYouTextField(
              controller: aboutmecontroller,
              text: 'Write something about yourself',
            ),
            RoundBtn(
              text: "Save  ",
              height: height * 0.07,
              width: width * 0.25,
              ontap: () {
                _userDetails.adduserdetails(
                    context,
                    firstnamecontroller.text.toString(),
                    lastnamecontroller.text.toString(),
                    addresscontroller.text.toString(),
                    phonenumbercontroller.text.toString(),
                    dobcontroller.text.toString(),
                    aboutmecontroller.text.toString());

                _userDetails.uploadphoto(context, _image!.absolute,
                    firstnamecontroller.text.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
