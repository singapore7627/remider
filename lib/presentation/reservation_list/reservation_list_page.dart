import 'dart:html';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/domain/reservation.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_model.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_page.dart';
import 'package:reservation_manager/presentation/reservation_list/reservation_list_model.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ReservationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservationListModel()..fetchReservations(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('予約一覧'),
        ),
        body: Consumer<ReservationListModel>(
          builder: (context, model, child) {
            final reservations = model.reservations;
            final listTiles = reservations
                .map(
                  (reservation) => ListTile(
                    leading: reservation.imageURL != null
                        ? Image.network(reservation.imageURL)
                        : Icon(Icons.agriculture),
                    title: Text(reservation.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReservationPage(
                              reservation: reservation,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchReservations();
                      },
                    ),
                    onLongPress: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('本当に${reservation.title}を削除しますか？'),
                            actions: [
                              TextButton(
                                child: Text('no'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('yes'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await deleteReservation(
                                      context, model, reservation);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<ReservationListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReservationPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchReservations();
              },
            );
          },
        ),
      ),
    );
  }

  Future deleteReservation(
    BuildContext context,
    ReservationListModel model,
    Reservation reservation,
  ) async {
    await model.deleteReservation(reservation);
    await deleteMessageDialog(context, reservation.title);
    await model.fetchReservations();
  }

  Future deleteMessageDialog(
    BuildContext context,
    String title,
  ) async {
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('削除しました'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
