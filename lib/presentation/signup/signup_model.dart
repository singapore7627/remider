import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignUpModel extends ChangeNotifier {
  String eMail = '';
  String password = '';

  Future<List<String>> signUp() async {
    List<String> ret = [];
    if (eMail.isEmpty) {
      ret.add('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      ret.add('パスワードを入力してください');
    }
    if (ret.isNotEmpty) {
      return ret;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: eMail,
        password: password,
      );
      FirebaseFirestore.instance.collection('users').add(
        {
          'email': eMail,
          'createdAt': Timestamp.now(),
          'updateAt': Timestamp.now(),
        },
      );
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
    } catch (e) {
      print(e);
    }
    return ret;
  }
}
