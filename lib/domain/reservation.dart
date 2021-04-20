import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  Reservation(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc['title'];
  }

  String documentID;
  String title;
}
