import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/reservation_list_model.dart';

class ReservationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservationListModel()..fetchReservations(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('予約一覧'),
        ),
        body: Consumer<ReservationListModel>(
          builder: (context, model, child) {
            final reservations = model.reservations;
            final listTiles = reservations
                .map((reservations) => ListTile(
                      title: Text(reservations.title),
                    ))
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
      ),
    );
  }
}
