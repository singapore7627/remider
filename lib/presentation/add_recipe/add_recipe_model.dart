import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservation_manager/domain/recipe.dart';

class AddRecipeModel extends ChangeNotifier {
  String userId = '';
  String documentID = '';
  String title = '';
  String ingredientTemp = '';
  String processTemp = '';
  File imageFile;

  Future<List<String>> addRecipeToFireBase() async {
    List<String> ret = [];
    if (title.isEmpty) {
      ret.add('入力してください。');
      return ret;
    }
    FirebaseFirestore.instance.collection('recipes').add(
      {
        'title': title,
        'ingredientTemp': ingredientTemp,
        'processTemp': processTemp,
        'createdAt': Timestamp.now(),
        'updateAt': Timestamp.now(),
      },
    );
    return ret;
  }

  Future<List<String>> updateRecipe(Recipe recipe) async {
    List<String> ret = [];
    if (title.isEmpty) {
      ret.add('入力してください。');
      return ret;
    }
    final document =
        FirebaseFirestore.instance.collection('recipes').doc(recipe.documentID);
    await document.update(
      {
        'title': title,
        'ingredientTemp': ingredientTemp,
        'processTemp': processTemp,
        'createdAt': Timestamp.now(),
      },
    );
    return ret;
  }

  Future uploadImage() async {
    return '';
  }
}
