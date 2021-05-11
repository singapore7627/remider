import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservation_manager/domain/recipe.dart';
import 'package:reservation_manager/domain/reservation.dart';

class MainModel extends ChangeNotifier {
  List<Recipe> recipes = [];

  Future fetchReservations() async {
    final docs = await FirebaseFirestore.instance.collection('recipes').get();
    final recipes = docs.docs.map((doc) => Recipe(doc)).toList();
    this.recipes = recipes;
    notifyListeners();
  }

  Future deleteReservation(Reservation reservation) async {
    await FirebaseFirestore.instance
        .collection('reservations')
        .doc(reservation.documentID)
        .delete();
  }
}
