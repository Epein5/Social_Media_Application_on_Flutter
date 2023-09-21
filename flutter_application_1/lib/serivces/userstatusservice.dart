import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/serivces/authorization/emailpasswordauth.dart';
import 'package:flutter_application_1/utlis/popupmessages.dart';
import 'package:flutter_application_1/utlis/routes/routes.dart';

class CurrentUserStatus{
  final _auth = FirebaseAuth.instance;

  checkDocument(BuildContext context) {
    var user = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (checkBlockedStatus(documentSnapshot) != true) {
          if (checkProfileSet(documentSnapshot) == true) {
            Navigator.pushReplacementNamed(context, RouteName.homeview);
            PopUpMessages.snackBar("Successfully Loggin In", context);
          } else {
            Navigator.pushReplacementNamed(context, RouteName.setuprofileview);
          }
        } else {
          EmailPasswordAuthServices emailPasswordAuthServices =
              EmailPasswordAuthServices();

          emailPasswordAuthServices.logout(context, 'blocked');
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  bool checkProfileSet(DocumentSnapshot documentSnapshot) {
    return documentSnapshot.get('set-profile');
  }

  String checkUserStatus(DocumentSnapshot documentSnapshot) {
    return documentSnapshot.get('status').toString();
  }

  String checkUserRole(DocumentSnapshot documentSnapshot) {
    return documentSnapshot.get('role').toString();
  }

  bool checkBlockedStatus(DocumentSnapshot documentSnapshot) {
    return documentSnapshot.get('blocked');
  }

  tryfunc(GetOptions values) async {
    var user = _auth.currentUser;
    GetOptions options = await GetOptions(source: Source.serverAndCache);
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get(options);
    return snapshot;
  }


}
