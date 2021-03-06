import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservation_manager/domain/reservation.dart';

class ReservationListModel extends ChangeNotifier {
  List<Reservation> reservations = [];

  Future fetchReservations() async {
    final docs =
        await FirebaseFirestore.instance.collection('reservations').get();
    final reservations = docs.docs.map((doc) => Reservation(doc)).toList();
    this.reservations = reservations;
    notifyListeners();
  }

  Future deleteReservation(Reservation reservation) async {
    await FirebaseFirestore.instance
        .collection('reservations')
        .doc(reservation.documentID)
        .delete();
  }
}
