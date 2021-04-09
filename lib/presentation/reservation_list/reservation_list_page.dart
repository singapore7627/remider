import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_model.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_page.dart';
import 'package:reservation_manager/presentation/reservation_list/reservation_list_model.dart';

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
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddReservationPage(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ))
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
}
