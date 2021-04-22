import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/presentation/Login/Login_model.dart';
import 'package:reservation_manager/presentation/signup/signup_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eMailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Consumer<LoginModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                    ),
                    controller: eMailController,
                    onChanged: (text) {
                      model.eMail = text;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                    controller: passwordController,
                    onChanged: (text) {
                      model.password = text;
                    },
                  ),
                  ElevatedButton(
                    child: Text('ログインする'),
                    onPressed: () async {
                      List<String> errors = await model.login();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          if (errors.length == 0) {
                            return AlertDialog(
                              title: Text('ログインしました。'),
                              actions: [
                                TextButton(
                                  child: Text('ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          } else {
                            String message = '';
                            errors.forEach((element) =>
                                message = message + '\n' + element);
                            return AlertDialog(
                              title: Text(message),
                              actions: [
                                TextButton(
                                  child: Text('ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      );
                      if (errors.length == 0) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
