import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPosts {
  final _auth = FirebaseAuth.instance;

  postUersPostToFirestore(profile, postpic, postdesc) async {
    var user = _auth.currentUser;
    String currentime = DateTime.now().millisecondsSinceEpoch.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('posts');
    await ref.doc(user!.uid).set({
      currentime: {
        'email': user.email,
        'post-pic': '',
        'post-discription': '',
        'blocked': false
      },
    }, SetOptions(merge: true));
  }

  allUsersPost(profile, postpic, postdesc) async {
    var user = _auth.currentUser;
    String currentime = DateTime.now().millisecondsSinceEpoch.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection('allposts');
    await ref.doc(currentime).set({
      'email': user!.email,
      'post-pic': '',
      'post-discription': '',
      'blocked': false
    }, SetOptions(merge: true));
  }
}
