import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/domain/reservation.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_model.dart';

class AddReservationPage extends StatelessWidget {
  final Reservation reservation;
  AddReservationPage({this.reservation});
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = reservation != null;
    final textEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = reservation.title;
    }

    return ChangeNotifierProvider(
      create: (_) => AddReservationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '本を編集' : '本を追加'),
        ),
        body: Consumer<AddReservationModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      // todo カメラロール
                    },
                    child: SizedBox(
                      width: 100,
                      height: 160,
                      child: model.imageFile != null
                          ? Image.file(model.imageFile)
                          : Container(color: Colors.grey),
                    ),
                  ),
                  TextField(
                    controller: textEditingController,
                    onChanged: (text) {
                      model.reservationTitle = text;
                    },
                  ),
                  ElevatedButton(
                    child: Text(isUpdate ? '更新する' : '追加する'),
                    onPressed: () async {
                      if (isUpdate) {
                        await updateReservation(model, context);
                      } else {
                        await addReservation(model, context);
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

  Future addReservation(AddReservationModel model, BuildContext context) async {
    List<String> errors = await model.addReservationToFireBase();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (errors.length == 0) {
          return AlertDialog(
            title: Text('追加しました。'),
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
          errors.forEach((element) => message = message + '\n' + element);
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
  }

  Future updateReservation(
      AddReservationModel model, BuildContext context) async {
    List<String> errors = await model.updateReservation(reservation);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (errors.length == 0) {
          return AlertDialog(
            title: Text('更新しました。'),
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
          errors.forEach((element) => message = message + '\n' + element);
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
  }
}
