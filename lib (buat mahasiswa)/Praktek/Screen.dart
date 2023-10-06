import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_sql_db/Praktek/ItemsScreen.dart';
import 'package:my_sql_db/Praktek/model/ShoppingList.dart';
import 'package:my_sql_db/Praktek/ui/shopping_list_dialog.dart';
import 'package:provider/provider.dart';
import 'Provider/myProvider.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    var tmp = Provider.of<ListProductProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
          itemCount:
              tmp.getShoppingList != null ? tmp.getShoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(tmp.getShoppingList[index].id.toString()),
                onDismissed: (direction) {
                  String tmpName = tmp.getShoppingList[index].name;
                  int tmpId = tmp.getShoppingList[index].id;
                  setState(() {
                    tmp.deleteById(tmp.getShoppingList[index]);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$tmpName deleted"),
                  ));
                },
                child: ListTile(
                  title: Text(tmp.getShoppingList[index].name),
                  leading: CircleAvatar(
                    child: Text("${tmp.getShoppingList[index].sum}"),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ItemsScreen(tmp.getShoppingList[index]);
                    }));
                  },
                  trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ShoppingListDialog().buildDialog(
                                  context, tmp.getShoppingList[index], false);
                            });
                      }),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return ShoppingListDialog()
                    .buildDialog(context, ShoppingList(++id, "", 0), true);
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
