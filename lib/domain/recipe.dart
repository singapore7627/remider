import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  Recipe(DocumentSnapshot doc) {
    userId = doc.data()['userId'];
    documentID = doc.id;
    title = doc.data()['title'];
    ingredient = doc.data()['ingredient'];
    process = doc.data()['precess'];
    ingredientTemp = doc.data()['ingredientTemp'];
    processTemp = doc.data()['processTemp'];
    imageURL = doc.data()['imageURL'];
  }

  String userId;
  String documentID;
  String title;
  List<String> ingredient;
  List<String> process;
  String ingredientTemp;
  String processTemp;
  String imageURL;
}
