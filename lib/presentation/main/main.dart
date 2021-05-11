import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/domain/recipe.dart';
import 'package:reservation_manager/domain/reservation.dart';
import 'package:reservation_manager/presentation/Login/Login_page.dart';
import 'package:reservation_manager/presentation/add_reservation/add_reservation_page.dart';
import 'package:reservation_manager/presentation/main/main_model.dart';
import 'package:reservation_manager/presentation/reservation_list/reservation_list_model.dart';
import 'package:reservation_manager/presentation/reservation_list/reservation_list_page.dart';
import 'package:reservation_manager/presentation/signup/signup_page.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    final items = List<String>.generate(10000, (i) => "Item $i");

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..fetchReservations(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: Icon(Icons.lunch_dining),
            title: const Text(
              'レシピ管理アプリ',
            ),
            actions: [
              SizedBox(
                width: 40,
                child: TextButton(
                  child: Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO
                  },
                ),
              ),
            ],
          ),
          body: Consumer<MainModel>(
            builder: (context, model, child) {
              final recipes = model.recipes;
              final listTiles = recipes
                  .map(
                    (recipe) => ListTile(
                      leading: recipe.imageURL != null
                          ? Image.network(recipe.imageURL)
                          : Icon(Icons.agriculture),
                      title: Text(recipe.title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                //     builder: (context) => AddRecipePage(
                                //       recipe: recipe,
                                //     ),
                                //     fullscreenDialog: true,
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
                              title: Text('本当に${recipe.title}を削除しますか？'),
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
                                    // todo
                                    // Navigator.of(context).pop();
                                    // await deleteRecipe(
                                    //     context, model, reservation);
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
          floatingActionButton: Consumer<MainModel>(
            builder: (context, model, child) {
              // todo reservation → recipe
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
      ),
    );
  }

  // Future deleteRecipe(
  // todo
  //   BuildContext context,
  //   MainModel model,
  //   Recipe recipe,
  // ) async {
  //   await model.deleteRecipe(recipe);
  //   await deleteMessageDialog(context, recipe.title);
  //   await model.fetchReservations();
  // }

  Future deleteMessageDialog(
    // todo
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
