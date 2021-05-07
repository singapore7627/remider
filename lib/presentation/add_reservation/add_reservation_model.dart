import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservation_manager/domain/reservation.dart';

class AddReservationModel extends ChangeNotifier {
  String reservationTitle = '';
  File imageFile;

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
  }

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

  Future<List<String>> updateReservation(Reservation reservation) async {
    List<String> ret = [];
    if (reservationTitle.isEmpty) {
      ret.add('入力してください。');
      ret.add('入力してください。');
      return ret;
    }
    final document = FirebaseFirestore.instance
        .collection('reservations')
        .doc(reservation.documentID);
    await document.update(
      {
        'title': reservationTitle,
        'updateAt': Timestamp.now(),
      },
    );
    return ret;
  }

  Future uploadImage() async {
    return '';
  }
}
