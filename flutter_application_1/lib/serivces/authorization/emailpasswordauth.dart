import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/serivces/firestore/userdetails.dart';
import 'package:flutter_application_1/serivces/provider/NightMode.dart';
import 'package:flutter_application_1/serivces/userstatusservice.dart';
import 'package:flutter_application_1/utlis/popupmessages.dart';
import 'package:flutter_application_1/utlis/routes/routes.dart';
import 'package:provider/provider.dart';

class EmailPasswordAuthServices {
  UserDetails _userDetails = UserDetails();
  CurrentUserStatus _userStatus = CurrentUserStatus();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signup(BuildContext context, String email, String password) async {
    final providder = Provider.of<LoadingProvider>(context, listen: false);

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      PopUpMessages.snackBar("Successfully Registered", context);
      _userDetails.createUserinFirestore(email);
      providder.setLoading(false);
    }).onError((error, stackTrace) {
      providder.setLoading(false);
    });
  }

  Future login(BuildContext context, String email, String password) async {
    final providder = Provider.of<LoadingProvider>(context, listen: false);

    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      providder.setLoading(false);
      _userDetails.updatestatus("logged-in");
      _userStatus.checkDocument(context);
    }).onError((error, stackTrace) {
      providder.setLoading(false);
      PopUpMessages.flushBarErrorMessage("Couldn't Login", context);
      providder.setLoading(false);
    });
  }

  void forgotpassword(BuildContext context, String email) {
    _auth.sendPasswordResetEmail(email: email).then((value) {
      PopUpMessages.snackBar("Reset main sent to email", context);
    }).onError((error, stackTrace) {
      PopUpMessages.flushBarErrorMessage(error.toString(), context);
    });
  }

  void logout(BuildContext context, String valuee) {
    _userDetails.updatestatus("logged-out");
    _auth.signOut().then((value) {
      Navigator.pushReplacementNamed(context, RouteName.loginview);
      if (valuee == 'blocked') {
        PopUpMessages.flushBarErrorMessage(
            "You have been restricted from using this account", context);
      }
    }).onError((error, stackTrace) {
      PopUpMessages.snackBar(error.toString(), context);
    });
  }
}
