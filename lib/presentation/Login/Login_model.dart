import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  String eMail = '';
  String password = '';

  Future<List<String>> login() async {
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
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: eMail,
        password: password,
      );
      String uid = userCredential.user.uid;
      // TODO uid を端末に保存
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
