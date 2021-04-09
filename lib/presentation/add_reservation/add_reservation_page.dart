import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/domain/reservation.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_model.dart';

class AddReservationPage extends StatelessWidget {
  final Reservation reservation;
  AddReservationPage({this.reservation});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddReservationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('予約一覧'),
        ),
        body: Consumer<AddReservationModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (text) {
                      model.reservationTitle = text;
                    },
                  ),
                  ElevatedButton(
                    child: Text('追加する'),
                    onPressed: () async {
                      List<String> errors =
                          await model.addReservationToFireBase();
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
