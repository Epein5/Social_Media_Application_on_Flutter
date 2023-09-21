import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/setuptextfields.dart';
import 'package:flutter_application_1/serivces/firestore/userdetails.dart';
import 'package:flutter_application_1/serivces/firestore/userpost.dart';
// import 'package:flutter_application_1/resources/components/boxes.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final posts = FirebaseFirestore.instance.collection('users').snapshots();
  UserPosts userPosts = UserPosts();
  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = UserDetails();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 1,
      height: height * 1,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: userDetails.getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator(
                      minHeight: 5,
                    );
                  }
                  if (snapshot.hasError) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 236, 184, 245),
                                radius: 45,
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
                                    radius: 40,
                                  ),
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data['first-name']} ${snapshot.data['last-name']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(snapshot.data['email'].toString()),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("    ${snapshot.data['about-me']}"),
                      )
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: height * 0.02,
                thickness: 2,
              ),
            ),
            StreamBuilder(
                stream: posts,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator(
                      minHeight: 5,
                    );
                  }
                  if (snapshot.hasError) {
                    return const CircularProgressIndicator();
                  }
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Card();
                          }));
                }),
            RoundBtn(
                height: height / 10,
                width: width / 3,
                ontap: () {
                  userPosts.postUersPostToFirestore(
                      'profile', 'postpic', 'postdesc');
                },
                text: 'PostToUser'),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
