import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservation_manager/domain/reservation.dart';

class AddReservationModel extends ChangeNotifier {
  String reservationTitle = '';

  Future<List<String>> addReservationToFireBase() async {
    List<String> ret = [];
    if (reservationTitle.isEmpty) {
      ret.add('入力してください。');
      ret.add('入力してください。');
      return ret;
    }
    FirebaseFirestore.instance.collection('reservations').add(
      {
        'title': reservationTitle,
        'createdAt': Timestamp.now(),
        'updateAt': Timestamp.now(),
      },
    );
    return ret;
  }
}
