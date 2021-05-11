import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_manager/domain/recipe.dart';
import 'package:reservation_manager/presentation/add_recipe/add_recipe_model.dart';

class AddRecipePage extends StatelessWidget {
  final Recipe recipe;
  AddRecipePage({this.recipe});
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = recipe != null;
    final textEditingController = TextEditingController();
    final ingredientTempEditingController = TextEditingController();
    final processTempEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = recipe.title;
      ingredientTempEditingController.text = recipe.ingredientTemp;
      processTempEditingController.text = recipe.processTemp;
    }

    return ChangeNotifierProvider(
      create: (_) => AddRecipeModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? 'レシピを編集' : 'レシピを追加'),
        ),
        body: Consumer<AddRecipeModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
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
                        decoration: InputDecoration(
                          hintText: "タイトルを入力してください。 例:カップヌードル",
                          hintStyle: TextStyle(color: Colors.black38),
                        ),
                        onChanged: (text) {
                          model.title = text;
                        },
                      ),
                      TextFormField(
                        maxLines: 22,
                        controller: ingredientTempEditingController,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(Icons.shopping_cart,
                                  size: 40.0, color: Colors.black54),
                            ),
                            hintText: "材料を入力してください\n例:\nカップヌードル\n熱湯300ml",
                            hintStyle: TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(2.0))),
                            labelStyle: TextStyle(color: Colors.black54)),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                        onChanged: (ingredientTemp) {
                          model.ingredientTemp = ingredientTemp;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Empty value";
                          }
                          return "";
                        },
                      ),
                      TextFormField(
                        maxLines: 32,
                        controller: processTempEditingController,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(Icons.timer,
                                  size: 40.0, color: Colors.black54),
                            ),
                            hintText:
                                "手順を入力してください。\n例:\n1, カップヌードルの蓋を開ける\n2, 熱湯を注ぐ\n3, 3分待つ",
                            hintStyle: TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(2.0))),
                            labelStyle: TextStyle(color: Colors.black54)),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                        onChanged: (processTemp) {
                          model.processTemp = processTemp;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Empty value";
                          }
                          return "";
                        },
                      ),
                      ElevatedButton(
                        child: Text(isUpdate ? '更新する' : '追加する'),
                        onPressed: () async {
                          if (isUpdate) {
                            await updateRecipe(model, context);
                          } else {
                            await addRecipe(model, context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future addRecipe(AddRecipeModel model, BuildContext context) async {
    List<String> errors = await model.addRecipeToFireBase();
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

  Future updateRecipe(AddRecipeModel model, BuildContext context) async {
    List<String> errors = await model.updateRecipe(recipe);
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
