//stored in collection called 'Post'
// each post will contain message, email, timestamp

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  //current logged in user

  User? user = FirebaseAuth.instance.currentUser;

  //get collection
  final CollectionReference post =
      FirebaseFirestore.instance.collection('Post');

  //post a message
  Future postMessage(String message) async {
    post.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now()
    });
  }

  //read post from database
  Stream<QuerySnapshot<Map<String, dynamic>>> streamPost() {
    final postStream = FirebaseFirestore.instance
        .collection('Post')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postStream;
  }
}
